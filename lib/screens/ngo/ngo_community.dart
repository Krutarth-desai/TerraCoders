import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../../mock_data.dart';
import '../../theme.dart';
import '../../widgets/common.dart';

class NgoCommunityPage extends StatelessWidget {
  final AppState state;
  const NgoCommunityPage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: GdTopBar(
        title: 'Build your community',
        subtitle: 'Create events and stories that bring Pune supporters together.',
        showBack: true,
        action: OutlinedButton.icon(
          onPressed: () => showGdToast(context, 'Event creator opened.'),
          icon: const Icon(Icons.add_rounded, size: 16),
          label: const Text('Create event'),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [GdColors.forest, GdColors.forestDark]),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('NEXT COMMUNITY EVENT', style: TextStyle(color: GdColors.lime, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1)),
                SizedBox(height: 6),
                Text('Monsoon essentials drive', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17)),
                SizedBox(height: 4),
                Text('9 Aug · 10:00 AM · Sarasbaug, Pune', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          SectionTitle('Community wall'),
          ...MockData.communityFeed.map((f) => GdCard(
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
          SectionTitle('Your community reach'),
          GdCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.end, children: const [
                  Text('1,284', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: GdColors.forest)),
                  SizedBox(width: 6),
                  Padding(padding: EdgeInsets.only(bottom: 4), child: Text('supporters', style: TextStyle(color: GdColors.copy))),
                ]),
                const Text('Across Pune donors, volunteers and local changemakers.', style: TextStyle(fontSize: 12, color: GdColors.copy)),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: 0.81, minHeight: 8, backgroundColor: GdColors.mint,
                    valueColor: const AlwaysStoppedAnimation(GdColors.forest),
                  ),
                ),
                const SizedBox(height: 6),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('August goal', style: TextStyle(fontSize: 12, color: GdColors.copy)),
                    Text('1,500 people', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
