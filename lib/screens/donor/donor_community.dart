import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../../mock_data.dart';
import '../../theme.dart';
import '../../widgets/common.dart';

class DonorCommunityPage extends StatelessWidget {
  final AppState state;
  const DonorCommunityPage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const GdTopBar(
        title: 'GreenDrop community',
        subtitle: 'Stories, updates and small acts that add up across Pune.',
        showBack: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
        children: [
          GdCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Share an impact story or ask the Pune community...',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: GdPrimaryButton('Post update',
                      onPressed: () => showGdToast(context, 'Your community post has been shared.')),
                ),
              ],
            ),
          ),
          SectionTitle('From the community'),
          ...MockData.communityFeed.map((f) => Container(
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
                      const CircleAvatar(backgroundColor: GdColors.mint, child: Icon(Icons.person_rounded, size: 18, color: GdColors.forest)),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(f.author, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5)),
                          Text(f.meta, style: const TextStyle(fontSize: 11, color: GdColors.copy)),
                        ],
                      ),
                    ]),
                    const SizedBox(height: 10),
                    Text(f.text, style: const TextStyle(fontSize: 13, height: 1.5)),
                    const SizedBox(height: 8),
                    GdChip(f.tag),
                  ],
                ),
              )),
          SectionTitle('Upcoming in Pune'),
          GdCard(
            child: Column(
              children: const [
                _EventRow(Icons.local_shipping_rounded, 'Weekend collection drive', 'Sat, 9 Aug · 10 AM · Sarasbaug, Pune'),
                Divider(height: 24),
                _EventRow(Icons.menu_book_rounded, 'Back-to-school book drive', 'Sun, 17 Aug · 11 AM · Deccan Gymkhana'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: GdPrimaryButton('Join an event',
                onPressed: () => showGdToast(context, 'You are registered for the Pune collection drive.')),
          ),
        ],
      ),
    );
  }
}

class _EventRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String meta;
  const _EventRow(this.icon, this.title, this.meta);
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CircleAvatar(backgroundColor: GdColors.mint, child: Icon(icon, size: 18, color: GdColors.forest)),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
            Text(meta, style: const TextStyle(fontSize: 11.5, color: GdColors.copy)),
          ],
        ),
      ),
    ]);
  }
}
