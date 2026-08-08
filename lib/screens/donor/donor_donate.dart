import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../../mock_data.dart';
import '../../theme.dart';
import '../../widgets/common.dart';

class DonorDonatePage extends StatelessWidget {
  final AppState state;
  const DonorDonatePage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const GdTopBar(
        title: 'Donate something meaningful',
        subtitle: 'GreenDrop matches your items with verified Pune NGOs.',
        showBack: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
        children: [
          const SizedBox(height: 10),
          const Text('Choose a category', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
          const SizedBox(height: 4),
          const Text('Select an item type to see nearby Pune NGOs with a live need.',
              style: TextStyle(color: GdColors.copy, fontSize: 13)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            children: MockData.donationTypes.map((t) {
              final selected = state.donationType == t;
              return ChoiceChip(
                label: Text(t),
                selected: selected,
                onSelected: (_) => state.setDonationType(t),
                selectedColor: GdColors.forest,
                labelStyle: TextStyle(
                    color: selected ? Colors.white : GdColors.ink,
                    fontWeight: FontWeight.w700),
                backgroundColor: Colors.white,
                side: const BorderSide(color: GdColors.line),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          SectionTitle('Matches for ${state.donationType}'),
          ...MockData.matchesFor(state.donationType).map((m) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: GdColors.line),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Expanded(
                        child: Text(m.name,
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                      ),
                      GdChip('${m.matchPercent} match'),
                    ]),
                    const SizedBox(height: 4),
                    Text('${m.area} · ${m.distance}',
                        style: const TextStyle(fontSize: 12, color: GdColors.copy)),
                    const SizedBox(height: 8),
                    Text(m.need, style: const TextStyle(fontSize: 13)),
                    const SizedBox(height: 10),
                    Row(children: [
                      GdChip(m.urgency, color: GdColors.orange),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          state.quickDonate(state.donationType, match: m);
                          showGdToast(context, 'Donation matched with ${m.name}');
                        },
                        child: const Text('Donate to this NGO →',
                            style: TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    ]),
                  ],
                ),
              )),
          SectionTitle('How the match works'),
          GdCard(
            child: Column(
              children: const [
                _StepRow(1, Icons.inventory_2_rounded, 'Tell us what you have',
                    'Choose an item and a pickup area.'),
                Divider(height: 26),
                _StepRow(2, Icons.handshake_rounded, 'Get a smart match',
                    'See Pune NGOs with a live need.'),
                Divider(height: 26),
                _StepRow(3, Icons.donut_large_rounded, 'Track verified impact',
                    'Follow pickup to distribution.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  final int n;
  final IconData icon;
  final String title;
  final String detail;
  const _StepRow(this.n, this.icon, this.title, this.detail);
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CircleAvatar(
        backgroundColor: GdColors.mint,
        child: Text('$n', style: const TextStyle(color: GdColors.forest, fontWeight: FontWeight.w800)),
      ),
      const SizedBox(width: 14),
      Icon(icon, color: GdColors.forest, size: 20),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
            Text(detail, style: const TextStyle(fontSize: 12, color: GdColors.copy)),
          ],
        ),
      ),
    ]);
  }
}
