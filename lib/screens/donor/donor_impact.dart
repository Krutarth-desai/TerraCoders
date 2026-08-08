import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../../mock_data.dart';
import '../../theme.dart';
import '../../widgets/common.dart';

class DonorImpactPage extends StatelessWidget {
  final AppState state;
  const DonorImpactPage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final metrics = [
      ('86', 'items reused', Icons.inventory_2_rounded),
      ('42 kg', 'diverted from landfill', Icons.eco_rounded),
      ('114 kg', 'CO₂ saved', Icons.public_rounded),
      ('46', 'people supported', Icons.favorite_rounded),
    ];
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const GdTopBar(
        title: 'Your impact story',
        subtitle: 'A transparent, verifiable record of the good you have made possible.',
        showBack: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
        children: [
          if (state.recentMatch != null)
            Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: GdColors.mint,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(children: [
                const Icon(Icons.check_circle_rounded, color: GdColors.forest),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${state.recentDonationType} matched with ${state.recentMatch!.name}',
                          style: const TextStyle(fontWeight: FontWeight.w800)),
                      const Text('Pune · Awaiting NGO acceptance',
                          style: TextStyle(fontSize: 12, color: GdColors.copy)),
                    ],
                  ),
                ),
                const GdChip('Requested'),
              ]),
            ),
          GdCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('IMPACT SCORE',
                    style: TextStyle(color: GdColors.forest, fontWeight: FontWeight.w800, fontSize: 11, letterSpacing: 1)),
                const SizedBox(height: 8),
                const Text('46 lives touched, and counting.',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                const Text('Your consistent giving supports education, dignity and care across Pune.',
                    style: TextStyle(color: GdColors.copy)),
                const SizedBox(height: 12),
                Text('⚡ ${state.xp} XP earned', style: const TextStyle(fontWeight: FontWeight.w700, color: GdColors.forest)),
              ],
            ),
          ),
          SectionTitle('Your anti-waste impact'),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: metrics.map((m) => GdCard(
              padding: const EdgeInsets.all(14),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(m.$3, color: GdColors.forest),
                    const SizedBox(height: 10),
                    Text(m.$1, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                    Text(m.$2, style: const TextStyle(fontSize: 11.5, color: GdColors.copy)),
                  ],
                ),
              ),
            )).toList(),
          ),
          SectionTitle('Verified impact proof',
              actionLabel: 'Share certificate',
              onAction: () => showGdToast(context, 'Your GreenDrop impact certificate is ready to share.')),
          GdCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(children: [
                  Icon(Icons.verified_rounded, color: GdColors.forest, size: 16),
                  SizedBox(width: 6),
                  Text('Verified NGO · MH/2017/PN/190',
                      style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: GdColors.forest)),
                ]),
                const SizedBox(height: 8),
                const Text('Your 10 books reached 10 young readers.',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                const SizedBox(height: 6),
                const Text(
                  'On 02 Aug 2026, Sahyog Shikshan Foundation distributed your books at its Deccan reading circle in Pune.',
                  style: TextStyle(fontSize: 12.5, color: GdColors.copy, height: 1.5),
                ),
                const SizedBox(height: 10),
                Wrap(spacing: 14, children: const [
                  Text('📍 Deccan, Pune', style: TextStyle(fontSize: 12)),
                  Text('👥 10 recipients', style: TextStyle(fontSize: 12)),
                  Text('📅 02 Aug 2026', style: TextStyle(fontSize: 12)),
                ]),
              ],
            ),
          ),
          SectionTitle('Donation timeline',
              actionLabel: '+ Add donation', onAction: () => state.navigate('donate')),
          GdCard(
            child: Column(
              children: MockData.donationTimeline
                  .map((d) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(d.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                                Text(d.source, style: const TextStyle(fontSize: 11.5, color: GdColors.copy)),
                              ],
                            ),
                          ),
                          GdChip(d.status == 'completed' ? 'Impact verified' : 'Collected',
                              color: d.status == 'completed' ? GdColors.forest : GdColors.blue),
                        ]),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
