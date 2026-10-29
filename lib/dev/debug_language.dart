import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

//goal: a debug-only app language that replaces the phone's, so every screen
//      can be checked in all nine languages without changing the phone's
//      settings. MyApp hands it to MaterialApp as its locale. null means the
//      phone's language, as for every real user; outside debug builds it is
//      always null.
class DebugLanguage {
    static final ValueNotifier<Locale?> locale = ValueNotifier<Locale?>(null);

    //load the stored choice. Call once at app start, before runApp.
    static Future<void> load() async {
        if (!kDebugMode) return;
        final prefs = await SharedPreferences.getInstance();
        final bool on = prefs.getBool('debugLanguageOn') ?? false;
        final String? code = prefs.getString('debugLanguage');
        locale.value = on && code != null ? Locale(code) : null;
    }

    //switch the app to [newLocale] right away and keep it after a restart;
    //null goes back to the phone's language
    static Future<void> change(Locale? newLocale) async {
        if (!kDebugMode) return;
        locale.value = newLocale;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('debugLanguageOn', newLocale != null);
        if (newLocale != null) {
            await prefs.setString('debugLanguage', newLocale.languageCode);
        }
    }
}
