import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:getshap/theme/app_colors.dart';
import 'package:getshap/theme/app_theme.dart';

/// Branded launch splash: the app's logo mark in brand blue, fading and scaling
/// in at the centre of the page background. After [minDuration] it replaces
/// itself with [nextBuilder]'s screen.
///
/// `logo_mark.png` is pure white, so it is tinted here, as in the side menu,
/// rather than shipping a second, blue artwork.
///
/// The background is the same [AppColors.pageBg] as the screen that follows,
/// so the hand-over fades only the content. The native Android and iOS launch
/// screens use the same colour too, so the cold start is one continuous
/// background from the launcher icon to the first screen.
class SplashScreen extends StatefulWidget {
    /// Builds the screen to show once the splash finishes (home or onboarding).
    final WidgetBuilder nextBuilder;

    /// How long the splash stays visible before navigating on.
    final Duration minDuration;

    const SplashScreen({
        super.key,
        required this.nextBuilder,
        this.minDuration = const Duration(milliseconds: 1900),
    });

    @override
    State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
    late final AnimationController _controller;
    late final Animation<double> _fade;
    late final Animation<double> _scale;

    @override
    void initState() {
        super.initState();
        _controller = AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 900),
        );
        _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
        _scale = Tween<double>(begin: 0.82, end: 1.0).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
        );
        _controller.forward();
        _scheduleNext();
    }

    Future<void> _scheduleNext() async {
        await Future.delayed(widget.minDuration);
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
            PageRouteBuilder<void>(
                transitionDuration: const Duration(milliseconds: 450),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    widget.nextBuilder(context),
                transitionsBuilder: (context, animation, _, child) =>
                    FadeTransition(opacity: animation, child: child),
            ),
        );
    }

    @override
    void dispose() {
        _controller.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        // No app bar here, so AppBarTheme's overlay style never applies — set it
        // directly. The page is the ordinary page background, so the bars are
        // the ordinary ones too, and they do not change as the next screen
        // fades in.
        return AnnotatedRegion<SystemUiOverlayStyle>(
            value: AppTheme.systemBars,
            child: Scaffold(
                backgroundColor: AppColors.pageBg,
                body: Center(
                    child: FadeTransition(
                        opacity: _fade,
                        child: ScaleTransition(
                            scale: _scale,
                            child: Image.asset(
                                'assets/icon/logo_mark.png',
                                width: MediaQuery.of(context).size.width * 0.52,
                                filterQuality: FilterQuality.high,
                                color: AppColors.brand500,
                            ),
                        ),
                    ),
                ),
            ),
        );
    }
}
