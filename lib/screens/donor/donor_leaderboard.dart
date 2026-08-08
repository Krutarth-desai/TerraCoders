import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../../mock_data.dart';
import '../../theme.dart';
import '../../widgets/common.dart';

class DonorLeaderboardPage extends StatelessWidget {
  final AppState state;
  const DonorLeaderboardPage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const GdTopBar(
        title: 'Local change-makers',
        subtitle: 'Pune is giving back — one drop at a time.',
        showBack: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [GdColors.forest, GdColors.forestDark]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('AUGUST LEADERBOARD',
                    style: TextStyle(color: GdColors.lime, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1)),
                const SizedBox(height: 8),
                const Text('You are #4 in Pune.',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                const Text('One more donation could move you up the rankings and unlock your next badge.',
                    style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 10),
                const Text('🏆 Top 12% of Pune donors',
                    style: TextStyle(color: GdColors.lime, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          SectionTitle('This month\'s champions', subtle: 'Updated weekly'),
          GdCard(
            child: Column(
              children: MockData.leaderboard.map((e) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                    color: e.isMe ? GdColors.mint : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(children: [
                    SizedBox(
                        width: 26,
                        child: Text('${e.rank}', style: const TextStyle(fontWeight: FontWeight.w800))),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: e.rank == 1 ? GdColors.lime : GdColors.mint,
                      child: Icon(e.rank == 1 ? Icons.emoji_events_rounded : Icons.person_rounded,
                          size: 16, color: GdColors.forest),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
                          Text(e.rank == 1 ? 'Local Legend' : 'Making a difference',
                              style: const TextStyle(fontSize: 11, color: GdColors.copy)),
                        ],
                      ),
                    ),
                    Text(e.isMe ? '${state.xp} XP' : e.xp,
                        style: const TextStyle(fontWeight: FontWeight.w800, color: GdColors.forest)),
                  ]),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
