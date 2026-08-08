import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../../mock_data.dart';
import '../../theme.dart';
import '../../widgets/common.dart';
import 'ngo_donations.dart' show donationStatusChip, donationTable;

class NgoHomePage extends StatelessWidget {
  final AppState state;
  const NgoHomePage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: GdTopBar(
        title: 'Welcome, Prayatna Foundation',
        subtitle: 'Here is what your Pune community has made possible today.',
        showBack: false,
        action: GdPrimaryButton('Post update', icon: Icons.campaign_rounded, onPressed: () => state.navigate('updates')),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [GdColors.forest, GdColors.forestDark]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('COMMUNITY IMPACT · PUNE',
                    style: TextStyle(color: GdColors.lime, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1)),
                SizedBox(height: 8),
                Text('16 new donations are waiting to do good.',
                    style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w800)),
                SizedBox(height: 6),
                Text('3 donors are ready to schedule a pickup with your team.',
                    style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.05,
            children: const [
              _Kpi(Icons.inventory_2_rounded, '124', 'Items received this month'),
              _Kpi(Icons.favorite_rounded, '89', 'Lives supported'),
              _Kpi(Icons.groups_rounded, '38', 'Active donors'),
            ],
          ),
          SectionTitle('New donation requests', actionLabel: 'View all', onAction: () => state.navigate('donations')),
          donationTable(MockData.incomingDonations.take(3).toList()),
          SectionTitle('Community updates', actionLabel: 'Create post', onAction: () => state.navigate('updates')),
          ...MockData.communityFeed.take(1).map((f) => GdCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(f.author, style: const TextStyle(fontWeight: FontWeight.w800)),
                    Text(f.meta, style: const TextStyle(fontSize: 11, color: GdColors.copy)),
                    const SizedBox(height: 8),
                    Text(f.text, style: const TextStyle(fontSize: 13, height: 1.5)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _Kpi extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const _Kpi(this.icon, this.value, this.label);
  @override
  Widget build(BuildContext context) {
    return GdCard(
      padding: const EdgeInsets.all(14),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: GdColors.forest),
            const SizedBox(height: 10),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            Text(label, style: const TextStyle(fontSize: 10.5, color: GdColors.copy)),
          ],
        ),
      ),
    );
  }
}
