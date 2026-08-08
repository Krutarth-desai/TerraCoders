import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../../mock_data.dart';
import '../../theme.dart';
import '../../widgets/common.dart';

class NgoUpdatesPage extends StatelessWidget {
  final AppState state;
  const NgoUpdatesPage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const GdTopBar(
        title: 'Share an impact update',
        subtitle: 'Keep your donors close to the change they made.',
        showBack: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
        children: [
          GdCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Write to your donor community', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                const SizedBox(height: 4),
                const Text('A clear update builds trust and brings donors back.',
                    style: TextStyle(fontSize: 12, color: GdColors.copy)),
                const SizedBox(height: 14),
                const TextField(
                  decoration: InputDecoration(labelText: 'Update title', border: OutlineInputBorder()),
                  controller: null,
                ),
                const SizedBox(height: 14),
                TextField(
                  maxLines: 4,
                  decoration: const InputDecoration(labelText: 'What happened?', border: OutlineInputBorder()),
                  controller: TextEditingController(
                      text: 'We distributed school books and learning kits to children at our weekly '
                          'Deccan reading circle. Thank you for making this possible.'),
                ),
                const SizedBox(height: 14),
                GdPrimaryButton('Publish update',
                    onPressed: () => showGdToast(context, 'Your update has been published.')),
              ],
            ),
          ),
          SectionTitle('Why updates matter'),
          GdCard(
            child: Column(
              children: const [
                _WhyRow(Icons.forum_rounded, 'Build lasting trust', 'Donors understand exactly where support goes.'),
                Divider(height: 24),
                _WhyRow(Icons.autorenew_rounded, 'Encourage repeat giving', 'Visible impact makes donors feel part of the mission.'),
                Divider(height: 24),
                _WhyRow(Icons.groups_rounded, 'Grow your community', 'Every post can inspire Pune neighbours to help.'),
              ],
            ),
          ),
          SectionTitle('Recent posts'),
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
        ],
      ),
    );
  }
}

class _WhyRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;
  const _WhyRow(this.icon, this.title, this.detail);
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, color: GdColors.forest),
      const SizedBox(width: 12),
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
