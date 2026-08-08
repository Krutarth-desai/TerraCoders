import 'package:flutter/material.dart';
import '../app_state.dart';
import '../models.dart';
import '../theme.dart';

class RoleScreen extends StatelessWidget {
  final AppState state;
  const RoleScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GdColors.sand,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: const [
                Icon(Icons.eco_rounded, color: GdColors.forest),
                SizedBox(width: 8),
                Text('GreenDrop',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
              ]),
              const SizedBox(height: 30),
              const Text('Every useful thing\ncan begin again.',
                  style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w800, height: 1.2)),
              const SizedBox(height: 10),
              const Text(
                "Join Pune's kinder, lower-waste community — one small drop at a time.",
                style: TextStyle(color: GdColors.copy, fontSize: 14.5, height: 1.5),
              ),
              const SizedBox(height: 30),
              const Text('Choose your path',
                  style: TextStyle(
                      color: GdColors.forest,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      letterSpacing: 1)),
              const SizedBox(height: 6),
              const Text('How will you show up?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              const SizedBox(height: 16),
              _RoleCard(
                icon: Icons.volunteer_activism_rounded,
                title: 'Donate with purpose',
                subtitle: 'Match your items with trusted local needs.',
                onTap: () => state.chooseRole(Role.donor),
              ),
              const SizedBox(height: 12),
              _RoleCard(
                icon: Icons.shield_rounded,
                title: 'Represent an NGO',
                subtitle: 'Bring support closer to your community.',
                onTap: () => state.chooseRole(Role.ngo),
              ),
              const SizedBox(height: 12),
              _RoleCard(
                icon: Icons.auto_awesome_rounded,
                title: 'Volunteer locally',
                subtitle: 'Help coordinate pickups and community drives.',
                onTap: () => state.chooseRole(Role.donor),
              ),
              const SizedBox(height: 24),
              const Center(
                child: Text('12,000+ people already creating change',
                    style: TextStyle(color: GdColors.copy, fontSize: 12.5)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _RoleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: GdColors.line),
          ),
          child: Row(children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: GdColors.mint,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: GdColors.forest),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 3),
                  Text(subtitle,
                      style: const TextStyle(color: GdColors.copy, fontSize: 12.5)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_rounded, color: GdColors.forest),
          ]),
        ),
      ),
    );
  }
}
