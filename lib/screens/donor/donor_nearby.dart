import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../../mock_data.dart';
import '../../theme.dart';
import '../../widgets/common.dart';

class DonorNearbyPage extends StatelessWidget {
  final AppState state;
  const DonorNearbyPage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: GdTopBar(
        title: 'Nearby NGOs',
        subtitle: 'Verified partners making change close to you.',
        showBack: true,
        action: GdPrimaryButton('Donate now', onPressed: () => state.navigate('donate')),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: GdColors.mint, borderRadius: BorderRadius.circular(18)),
            child: Row(children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('PUNE, MAHARASHTRA', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: GdColors.forest, letterSpacing: 1)),
                    SizedBox(height: 6),
                    Text('Local needs, ready for your kindness.', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                    SizedBox(height: 4),
                    Text('Every partner is verified for location, registration and impact history.',
                        style: TextStyle(fontSize: 12, color: GdColors.copy)),
                  ],
                ),
              ),
              const Icon(Icons.map_rounded, color: GdColors.forest, size: 32),
            ]),
          ),
          SectionTitle('Recommended near you', subtle: 'Sorted by active need'),
          ...MockData.nearbyNgos.map((n) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: GdColors.line),
                ),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: GdColors.mint,
                    child: Text(n.initials, style: const TextStyle(color: GdColors.forest, fontWeight: FontWeight.w800)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Expanded(child: Text(n.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5))),
                          GdChip('${n.matchPercent} match'),
                        ]),
                        const SizedBox(height: 3),
                        Text('${n.area}, Pune · ${n.distance} away', style: const TextStyle(fontSize: 12, color: GdColors.copy)),
                        const SizedBox(height: 6),
                        Text(n.need, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                        const SizedBox(height: 8),
                        Row(children: [
                          const Icon(Icons.shield_rounded, size: 14, color: GdColors.forest),
                          const SizedBox(width: 4),
                          const Text('Verified partner', style: TextStyle(fontSize: 11, color: GdColors.forest)),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              final match = MockData.matchesFor(n.donationType).first;
                              state.quickDonate(n.donationType, match: match);
                            },
                            child: const Text('Help now →', style: TextStyle(fontWeight: FontWeight.w700)),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ]),
              )),
        ],
      ),
    );
  }
}
