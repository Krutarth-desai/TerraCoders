import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../../theme.dart';
import '../../widgets/common.dart';

class DonorProfilePage extends StatelessWidget {
  final AppState state;
  const DonorProfilePage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const GdTopBar(
        title: 'Your profile',
        subtitle: 'Your GreenDrop identity, impact and preferences.',
        showBack: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
        children: [
          Row(children: [
            const CircleAvatar(
              radius: 34,
              backgroundColor: GdColors.mint,
              child: Text('AC', style: TextStyle(color: GdColors.forest, fontWeight: FontWeight.w800, fontSize: 18)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(children: [
                    Icon(Icons.verified_rounded, size: 14, color: GdColors.forest),
                    SizedBox(width: 4),
                    Text('GreenDrop verified', style: TextStyle(fontSize: 11, color: GdColors.forest, fontWeight: FontWeight.w700)),
                  ]),
                  SizedBox(height: 4),
                  Text('Advait Chitale', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
                  Text('Pune Green Champion · Member since 2025', style: TextStyle(fontSize: 12, color: GdColors.copy)),
                ],
              ),
            ),
          ]),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _StatBox('${state.donations}', 'donations')),
              const SizedBox(width: 10),
              Expanded(child: _StatBox('46', 'people supported')),
              const SizedBox(width: 10),
              Expanded(child: _StatBox('${state.xp}', 'impact XP')),
            ],
          ),
          const SizedBox(height: 20),
          GdCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _SettingRow(Icons.emoji_events_rounded, 'My community rank', 'Top 12% of Pune donors',
                    onTap: () => state.navigate('leaderboard')),
                const Divider(height: 1),
                _SettingRow(Icons.groups_rounded, 'Community stories', 'See updates from Pune',
                    onTap: () => state.navigate('community')),
                const Divider(height: 1),
                _SettingRow(
                  state.dark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  state.dark ? 'Use light appearance' : 'Use dark appearance',
                  'Easy on the eyes, day or night',
                  trailing: Switch(value: state.dark, onChanged: (_) => state.toggleTheme(), activeColor: GdColors.forest),
                  onTap: state.toggleTheme,
                ),
                const Divider(height: 1),
                _SettingRow(Icons.logout_rounded, 'Log out', 'Return to role selection',
                    danger: true, onTap: state.logout),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String value;
  final String label;
  const _StatBox(this.value, this.label);
  @override
  Widget build(BuildContext context) {
    return GdCard(
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: GdColors.forest)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 11, color: GdColors.copy), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final bool danger;
  final VoidCallback onTap;
  const _SettingRow(this.icon, this.title, this.subtitle,
      {this.trailing, this.danger = false, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final color = danger ? Colors.redAccent : GdColors.ink;
    return ListTile(
      leading: Icon(icon, color: danger ? Colors.redAccent : GdColors.forest),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w700, color: color, fontSize: 13.5)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 11.5, color: GdColors.copy)),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: GdColors.copy),
      onTap: onTap,
    );
  }
}
