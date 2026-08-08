import 'package:flutter/material.dart';
import '../app_state.dart';
import '../theme.dart';

class SplashScreen extends StatefulWidget {
  final AppState state;
  const SplashScreen({super.key, required this.state});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) widget.state.goToOnboarding();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [GdColors.forestDark, GdColors.forest],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: GdColors.lime,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(Icons.eco_rounded, size: 46, color: GdColors.forestDark),
            ),
            const SizedBox(height: 22),
            const Text('GreenDrop',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            const Text('Give good a second life.',
                style: TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 30),
            const SizedBox(
              width: 26,
              height: 26,
              child: CircularProgressIndicator(
                color: GdColors.lime,
                strokeWidth: 2.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
