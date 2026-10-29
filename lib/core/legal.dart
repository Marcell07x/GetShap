import 'package:flutter/foundation.dart' show kDebugMode, debugPrint;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

/// Where the user stands relative to the current documents.
enum ConsentStatus {
    /// Never accepted anything: a fresh install, or one made before the
    /// consent screen existed (the `gaveConsent` key is simply absent).
    none,

    /// Accepted an earlier version of the documents. The text has changed
    /// materially since, so it has to be accepted again — the earlier
    /// acceptance does not cover the new terms.
    outdated,

    /// Accepted the version currently shipping.
    current,
}

/// Consent state plus where the legal documents are.
///
/// The gate is a stored flag, `gaveConsent`, together with the version that was
/// accepted. Nothing writes them until the user actually ticks the box on the
/// consent screen, so for everyone who installed the app before that screen
/// existed both keys are absent and the status comes back as [ConsentStatus.none].
/// Those users meet the screen once, on their next launch, before they can
/// reach the home screen — see `MyApp._firstScreen`.
class Legal {
    /// Version of the documents the user is accepting.
    ///
    /// **Bump this only when the documents change materially** — a new or wider
    /// liability limitation, a new obligation on the user, paid features, a
    /// change in what data is handled, a new health warning, a different
    /// governing law, or a change in who the contracting party is. Everyone who
    /// accepted an earlier version is then asked again on their next launch.
    ///
    /// Do **not** bump it for typos, clearer wording, formatting or a fixed
    /// link: those do not change what was agreed to, and re-prompting every
    /// user over them is noise that makes the prompt easier to dismiss
    /// unread the one time it matters.
    static const String documentVersion = '1.0';

    static const String _keyGaveConsent = 'gaveConsent';
    static const String _keyAcceptedAt = 'consentAcceptedAt';
    static const String _keyVersion = 'consentVersion';

    /// Reads the stored acceptance and compares it with [documentVersion].
    ///
    /// A stored flag without a version is treated as outdated rather than
    /// current: if it cannot be shown which text was accepted, the safe answer
    /// is to ask again.
    static Future<ConsentStatus> status() async {
        final prefs = await SharedPreferences.getInstance();

        final gaveConsent = prefs.getBool(_keyGaveConsent) ?? false;
        if (!gaveConsent) return ConsentStatus.none;

        final acceptedVersion = prefs.getString(_keyVersion);
        return acceptedVersion == documentVersion
            ? ConsentStatus.current
            : ConsentStatus.outdated;
    }

    /// Records the acceptance. The timestamp and version are written next to
    /// the flag as the actual record of consent — the flag alone only says
    /// "yes at some point", which is worth much less if it is ever questioned.
    static Future<void> saveConsent() async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(_keyGaveConsent, true);
        await prefs.setString(_keyAcceptedAt, DateTime.now().toIso8601String());
        await prefs.setString(_keyVersion, documentVersion);
    }

    // The documents ship with the app, in every language it speaks: the same
    // markdown the website is built from (legal/build_site.dart), shown by
    // LegalDocumentPage in the app's language. The Hungarian files have
    // Hungarian names; every other language uses the English ones.
    static String _asset(BuildContext context, String hu, String other) {
        final String language = Localizations.localeOf(context).languageCode;
        return 'legal/$language/${language == 'hu' ? hu : other}.md';
    }

    static String termsAsset(BuildContext context) =>
        _asset(context, 'felhasznalasi-feltetelek', 'terms-of-use');

    static String healthAsset(BuildContext context) =>
        _asset(context, 'egeszsegugyi-tajekoztato', 'health-disclaimer');

    static String privacyAsset(BuildContext context) =>
        _asset(context, 'adatvedelmi-tajekoztato', 'privacy-policy');

    /// Opens a web address from one of the documents — an authority's site, a
    /// store's privacy policy — in the browser. Failures are swallowed on
    /// purpose: a missing browser must not be able to break the page.
    static Future<void> open(String url) async {
        try {
            await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        } catch (e) {
            if (kDebugMode) debugPrint('Could not open $url: $e');
        }
    }
}
