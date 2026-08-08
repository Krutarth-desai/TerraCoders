import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../../mock_data.dart';
import '../../theme.dart';
import '../../widgets/common.dart';

class DonorHomePage extends StatelessWidget {
  final AppState state;
  const DonorHomePage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: GdTopBar(
        title: 'Welcome, Advait',
        subtitle: 'Your kindness is creating a measurable change across Pune.',
        action: GdPrimaryButton('Donate now',
            icon: Icons.add_rounded, onPressed: () => state.navigate('donate')),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
        children: [
          LayoutBuilder(builder: (context, c) {
            final wide = c.maxWidth > 640;
            final hero = _ImpactHero(state: state);
            final stats = _StatsCard(state: state);
            if (!wide) {
              return Column(children: [hero, const SizedBox(height: 14), stats]);
            }
            return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(child: hero),
              const SizedBox(width: 14),
              Expanded(child: stats),
            ]);
          }),
          SectionTitle('What would you like to give?',
              actionLabel: 'View all categories',
              onAction: () => state.navigate('donate')),
          _DonationTiles(state: state),
          SectionTitle('Needs now in Pune', subtle: 'Verified requests · updated today'),
          _NeedsGrid(state: state),
          SectionTitle('Latest from your donations',
              actionLabel: 'All updates', onAction: () => state.navigate('impact')),
          _UpdatesCard(),
        ],
      ),
    );
  }
}

class _ImpactHero extends StatelessWidget {
  final AppState state;
  const _ImpactHero({required this.state});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [GdColors.forest, GdColors.forestDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('YOUR PUNE GIVING JOURNEY',
              style: TextStyle(
                  color: GdColors.lime, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1)),
          const SizedBox(height: 10),
          const Text('Small drops. A world of change.',
              style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          const Text('You are in the top 12% of Pune donors this month.',
              style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(30)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.bolt_rounded, color: GdColors.lime, size: 16),
              const SizedBox(width: 6),
              Text('${state.xp} XP · Pune Green Champion',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12.5)),
            ]),
          ),
        ],
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  final AppState state;
  const _StatsCard({required this.state});
  @override
  Widget build(BuildContext context) {
    return GdCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Your giving at a glance', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
          const SizedBox(height: 12),
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('${state.donations}',
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: GdColors.forest)),
            const SizedBox(width: 6),
            const Padding(
              padding: EdgeInsets.only(bottom: 6),
              child: Text('donations', style: TextStyle(color: GdColors.copy)),
            ),
          ]),
          const Text('You have helped 46 people so far', style: TextStyle(color: GdColors.copy, fontSize: 12.5)),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: 0.72,
              minHeight: 8,
              backgroundColor: GdColors.mint,
              valueColor: const AlwaysStoppedAnimation(GdColors.forest),
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Level 3', style: TextStyle(fontSize: 12, color: GdColors.copy)),
              Text('260 XP to Level 4', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }
}

class _DonationTiles extends StatelessWidget {
  final AppState state;
  const _DonationTiles({required this.state});
  @override
  Widget build(BuildContext context) {
    final tiles = [
      ('Clothes', 'Give comfort', Icons.checkroom_rounded),
      ('Books', 'Share knowledge', Icons.menu_book_rounded),
      ('Essentials', 'Support families', Icons.shopping_basket_rounded),
    ];
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 0.78,
      children: tiles.map((t) {
        final match = MockData.matchesFor(t.$1).first;
        return Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () {
              state.quickDonate(t.$1, match: match);
              showGdToast(context, 'Matched with ${match.name}');
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: GdColors.line)),
              // FittedBox is a safety net: if this tile ever ends up in a
              // tighter box than expected (e.g. a very narrow window), the
              // content scales down instead of overflowing.
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(t.$3, color: GdColors.forest, size: 22),
                    const SizedBox(height: 10),
                    Text(t.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 2),
                    Text(t.$2, style: const TextStyle(fontSize: 11, color: GdColors.copy)),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _NeedsGrid extends StatelessWidget {
  final AppState state;
  const _NeedsGrid({required this.state});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(MockData.needsNow.length, (i) {
        final n = MockData.needsNow[i];
        final urgent = i == 0;
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: urgent ? GdColors.mint : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: GdColors.line),
          ),
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GdChip(n[1], color: urgent ? GdColors.orange : GdColors.forest),
                  const SizedBox(height: 8),
                  Text(n[2], style: const TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 3),
                  Text(n[3], style: const TextStyle(fontSize: 12, color: GdColors.copy)),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                final match = MockData.matchesFor(n[0]).first;
                state.quickDonate(n[0], match: match);
              },
              child: Text('${n[4]} →', style: const TextStyle(fontWeight: FontWeight.w700)),
            ),
          ]),
        );
      }),
    );
  }
}

class _UpdatesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.menu_book_rounded, 'Your 10 books reached 10 young readers', 'Sahyog Shikshan Foundation · Pune · 2 hours ago'),
      (Icons.checkroom_rounded, 'Rainwear sorted for the monsoon drive', 'Sakhi Saathi Foundation · Yesterday'),
      (Icons.bolt_rounded, 'You earned 120 XP for your impact', 'GreenDrop Pune · 2 days ago'),
    ];
    return GdCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Impact updates', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
          const SizedBox(height: 12),
          ...items.map((it) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(children: [
                  CircleAvatar(
                      backgroundColor: GdColors.mint,
                      child: Icon(it.$1, color: GdColors.forest, size: 18)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(it.$2, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                        Text(it.$3, style: const TextStyle(fontSize: 11.5, color: GdColors.copy)),
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
