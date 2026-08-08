import 'package:flutter/material.dart';
import 'app_state.dart';
import 'models.dart';
import 'theme.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/role_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/dashboard_shell.dart';

void main() {
  runApp(const GreenDropApp());
}

class GreenDropApp extends StatefulWidget {
  const GreenDropApp({super.key});

  @override
  State<GreenDropApp> createState() => _GreenDropAppState();
}

class _GreenDropAppState extends State<GreenDropApp> {
  final AppState state = AppState();

  @override
  void initState() {
    super.initState();
    state.addListener(_onStateChanged);
  }

  void _onStateChanged() => setState(() {});

  @override
  void dispose() {
    state.removeListener(_onStateChanged);
    super.dispose();
  }

  Widget _currentScreen() {
    switch (state.stage) {
      case AppStage.splash:
        return SplashScreen(state: state);
      case AppStage.onboarding:
        return OnboardingScreen(state: state);
      case AppStage.roleSelect:
        return RoleScreen(state: state);
      case AppStage.auth:
        return AuthScreen(state: state);
      case AppStage.dashboard:
        return DashboardShell(state: state);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenDrop',
      debugShowCheckedModeBanner: false,
      theme: GdTheme.light(),
      darkTheme: GdTheme.dark(),
      themeMode: state.dark ? ThemeMode.dark : ThemeMode.light,
      home: AnimatedSwitcher(
        duration: const Duration(milliseconds: 260),
        child: KeyedSubtree(
          key: ValueKey('${state.stage}-${state.role}-${state.page}'),
          child: _currentScreen(),
        ),
      ),
    );
  }
}
