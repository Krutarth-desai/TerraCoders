import 'package:flutter/material.dart';
import '../app_state.dart';
import '../models.dart';
import '../theme.dart';

class AuthScreen extends StatefulWidget {
  final AppState state;
  const AuthScreen({super.key, required this.state});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late TextEditingController emailCtrl;
  late TextEditingController passwordCtrl;
  late TextEditingController nameCtrl;

  @override
  void initState() {
    super.initState();
    final donor = widget.state.role == Role.donor;
    emailCtrl = TextEditingController(
        text: donor ? 'advait.chitale@greendrop.demo' : 'prayatna@greendrop.demo');
    passwordCtrl = TextEditingController(text: donor ? 'Green@123' : 'NGO@123');
    nameCtrl = TextEditingController();
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final donor = state.role == Role.donor;
    final signup = state.authMode == AuthMode.signup;

    return Scaffold(
      backgroundColor: GdColors.sand,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton.icon(
                onPressed: state.backToRoles,
                icon: const Icon(Icons.arrow_back_rounded, size: 18),
                label: const Text('Back to roles'),
              ),
              const SizedBox(height: 12),
              Text(
                donor
                    ? (signup
                        ? 'Make room for more good.'
                        : 'Welcome back, change-maker.')
                    : (signup
                        ? 'Make impact happen, together.'
                        : 'Your Pune community is waiting.'),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(
                donor
                    ? 'See each donation grow into something real for people in your own Pune neighbourhood.'
                    : 'Bring your mission closer to generous Pune neighbours and make every contribution visible.',
                style: const TextStyle(color: GdColors.copy, height: 1.5),
              ),
              const SizedBox(height: 28),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(donor ? 'Donor portal' : 'NGO partner portal',
                          style: const TextStyle(
                              color: GdColors.forest,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              letterSpacing: 1)),
                      const SizedBox(height: 6),
                      Text(
                        signup ? 'Create your account' : 'Sign in to GreenDrop',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 16),
                      if (signup) ...[
                        TextField(
                          controller: nameCtrl,
                          decoration: InputDecoration(
                            labelText: donor ? 'Your name' : 'Organisation name',
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 14),
                      ] else
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 14),
                          decoration: BoxDecoration(
                            color: GdColors.mint,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Demo access',
                                  style: TextStyle(fontSize: 11, color: GdColors.copy)),
                              Text(emailCtrl.text,
                                  style: const TextStyle(fontWeight: FontWeight.w700)),
                              Text(passwordCtrl.text,
                                  style: const TextStyle(fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      TextField(
                        controller: emailCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Email address',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: passwordCtrl,
                        obscureText: !state.passwordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(state.passwordVisible
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded),
                            onPressed: state.togglePasswordVisible,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: GdColors.forest,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                          onPressed: state.login,
                          child: Text(
                            signup ? 'Create my account' : 'Enter GreenDrop',
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: TextButton(
                          onPressed: state.toggleAuthMode,
                          child: Text(signup
                              ? 'Already part of the community? Sign in'
                              : 'New to GreenDrop? Create an account'),
                        ),
                      ),
                    ],
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
