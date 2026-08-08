import 'package:flutter/material.dart';
import 'models.dart';

/// Single source of truth for the whole app. Mirrors the small `state`
/// object the original JS prototype used, but as a proper ChangeNotifier
/// so widgets can rebuild reactively via [AnimatedBuilder]/[ListenableBuilder].
class AppState extends ChangeNotifier {
  AppStage stage = AppStage.splash;
  int onboardingIndex = 0;

  Role? role;
  AuthMode authMode = AuthMode.login;
  bool passwordVisible = false;

  bool dark = false;
  String page = 'home';

  String donationType = 'Books';
  int donations = 6;
  int xp = 1240;
  NgoMatch? recentMatch;
  String? recentDonationType;

  void goToOnboarding() {
    stage = AppStage.onboarding;
    notifyListeners();
  }

  void nextOnboarding() {
    onboardingIndex = (onboardingIndex + 1).clamp(0, 2);
    notifyListeners();
  }

  void skipOnboarding() {
    stage = AppStage.roleSelect;
    onboardingIndex = 0;
    notifyListeners();
  }

  void chooseRole(Role r) {
    role = r;
    stage = AppStage.auth;
    authMode = AuthMode.login;
    notifyListeners();
  }

  void backToRoles() {
    stage = AppStage.roleSelect;
    notifyListeners();
  }

  void toggleAuthMode() {
    authMode = authMode == AuthMode.login ? AuthMode.signup : AuthMode.login;
    notifyListeners();
  }

  void togglePasswordVisible() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  void login() {
    stage = AppStage.dashboard;
    page = 'home';
    notifyListeners();
  }

  void toggleTheme() {
    dark = !dark;
    notifyListeners();
  }

  void navigate(String p) {
    page = p;
    notifyListeners();
  }

  void logout() {
    role = null;
    page = 'home';
    authMode = AuthMode.login;
    stage = AppStage.roleSelect;
    notifyListeners();
  }

  void setDonationType(String type) {
    donationType = type;
    notifyListeners();
  }

  /// Simulates requesting a match with the top NGO for [type], the way the
  /// "quick donate" tiles do in the original prototype.
  void quickDonate(String type, {NgoMatch? match}) {
    donationType = type;
    recentMatch = match;
    recentDonationType = type;
    donations += 1;
    xp += 40;
    page = 'impact';
    notifyListeners();
  }
}
