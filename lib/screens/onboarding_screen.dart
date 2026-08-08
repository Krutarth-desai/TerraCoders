import 'package:flutter/material.dart';
import '../app_state.dart';
import '../theme.dart';

class _Slide {
  final IconData icon;
  final String title;
  final String copy;
  const _Slide(this.icon, this.title, this.copy);
}

const _slides = [
  _Slide(Icons.recycling_rounded, 'Give good a second life',
      'Turn what you no longer need into real change for someone nearby.'),
  _Slide(Icons.handshake_rounded, 'Smart NGO matching',
      "GreenDrop connects your donation with a verified Pune NGO that needs it right now."),
  _Slide(Icons.insights_rounded, 'See your verified impact',
      'Track every donation from pickup to distribution, with proof of the good it did.'),
];

class OnboardingScreen extends StatelessWidget {
  final AppState state;
  const OnboardingScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final slide = _slides[state.onboardingIndex];
    return Scaffold(
      backgroundColor: GdColors.sand,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: state.skipOnboarding,
                  child: const Text('Skip'),
                ),
              ),
              const Spacer(),
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: GdColors.mint,
                  borderRadius: BorderRadius.circular(36),
                ),
                child: Icon(slide.icon, size: 64, color: GdColors.forest),
              ),
              const SizedBox(height: 34),
              Text('0${state.onboardingIndex + 1} / 03',
                  style: const TextStyle(
                      color: GdColors.forest,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1)),
              const SizedBox(height: 10),
              Text(slide.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              Text(slide.copy,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: GdColors.copy, height: 1.5)),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _slides.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: i == state.onboardingIndex ? 22 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: i == state.onboardingIndex
                          ? GdColors.forest
                          : GdColors.line,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GdColors.forest,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: state.onboardingIndex == 2
                      ? state.skipOnboarding
                      : state.nextOnboarding,
                  child: Text(
                    state.onboardingIndex == 2 ? 'Get started' : 'Next',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
