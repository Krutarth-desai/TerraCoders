import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../../theme.dart';
import '../../widgets/common.dart';

class NgoProfilePage extends StatelessWidget {
  final AppState state;
  const NgoProfilePage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: GdTopBar(
        title: 'Prayatna Foundation',
        subtitle: 'Your verified public profile and organisation settings.',
        showBack: true,
        action: GdPrimaryButton('Save changes',
            onPressed: () => showGdToast(context, 'Profile changes saved successfully.')),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
        children: [
          GdCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  const CircleAvatar(radius: 32, backgroundColor: GdColors.mint, child: Icon(Icons.eco_rounded, color: GdColors.forest, size: 28)),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Prayatna Foundation', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
                        Text('Kothrud, Pune, Maharashtra', style: TextStyle(fontSize: 12, color: GdColors.copy)),
                        SizedBox(height: 4),
                        Row(children: [
                          Icon(Icons.verified_rounded, size: 14, color: GdColors.forest),
                          SizedBox(width: 4),
                          Text('GreenDrop verified NGO', style: TextStyle(fontSize: 11.5, color: GdColors.forest, fontWeight: FontWeight.w700)),
                        ]),
                      ],
                    ),
                  ),
                ]),
                const SizedBox(height: 18),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2.6,
                  children: const [
                    _VerifyStat('Registration', 'MH/2020/PN/381'),
                    _VerifyStat('Compliance', '12A & 80G verified'),
                    _VerifyStat('Trust score', '4.9 / 5 · 126 donors'),
                    _VerifyStat('Active since', '2020 · Pune'),
                  ],
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: GdColors.mint, borderRadius: BorderRadius.circular(10)),
                  child: const Text('✓ Registration, location and impact history independently checked by GreenDrop.',
                      style: TextStyle(fontSize: 12, color: GdColors.forestDark, fontWeight: FontWeight.w600)),
                ),
                const Divider(height: 30),
                TextField(
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'About your organisation', border: OutlineInputBorder()),
                  controller: TextEditingController(
                      text: 'Prayatna Foundation supports education, dignity and livelihood for '
                          'underserved communities across Pune.'),
                ),
                const SizedBox(height: 14),
                TextField(
                  decoration: const InputDecoration(labelText: 'Collection address', border: OutlineInputBorder()),
                  controller: TextEditingController(text: 'Paud Road, Kothrud, Pune, Maharashtra'),
                ),
              ],
            ),
          ),
          SectionTitle('Verified impact history'),
          GdCard(
            child: Column(
              children: const [
                _ImpactRow(Icons.groups_rounded, '3,240', 'Lives supported since joining GreenDrop'),
                Divider(height: 24),
                _ImpactRow(Icons.inventory_2_rounded, '1,678', 'Donations transparently distributed'),
                Divider(height: 24),
                _ImpactRow(Icons.map_rounded, '12', 'Pune neighbourhoods reached'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VerifyStat extends StatelessWidget {
  final String label;
  final String value;
  const _VerifyStat(this.label, this.value);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(border: Border.all(color: GdColors.line), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(fontSize: 10.5, color: GdColors.copy)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
        ],
      ),
    );
  }
}

class _ImpactRow extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const _ImpactRow(this.icon, this.value, this.label);
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, color: GdColors.forest),
      const SizedBox(width: 12),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
      const SizedBox(width: 10),
      Expanded(child: Text(label, style: const TextStyle(fontSize: 12.5, color: GdColors.copy))),
    ]);
  }
}
