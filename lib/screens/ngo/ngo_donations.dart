import 'package:flutter/material.dart';
import '../../app_state.dart';
import '../../mock_data.dart';
import '../../models.dart';
import '../../theme.dart';
import '../../widgets/common.dart';

Widget donationStatusChip(String status) {
  final isNew = status == 'new';
  return GdChip(isNew ? 'New request' : 'Scheduled', color: isNew ? GdColors.orange : GdColors.forest);
}

Widget donationTable(List<IncomingDonation> rows) {
  return GdCard(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Column(
      children: rows.map((r) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Row(children: [
            const CircleAvatar(radius: 15, backgroundColor: GdColors.mint, child: Icon(Icons.person_rounded, size: 15, color: GdColors.forest)),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(r.donor, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                  Text(r.items, style: const TextStyle(fontSize: 11.5, color: GdColors.copy)),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(r.pickup, style: const TextStyle(fontSize: 11.5, color: GdColors.copy)),
            ),
            donationStatusChip(r.status),
          ]),
        );
      }).toList(),
    ),
  );
}

class NgoDonationsPage extends StatelessWidget {
  final AppState state;
  const NgoDonationsPage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: GdTopBar(
        title: 'Donation requests',
        subtitle: 'Review offers from Pune donors and arrange pickups.',
        showBack: true,
        action: OutlinedButton.icon(
          onPressed: () => showGdToast(context, 'Pickup calendar opened.'),
          icon: const Icon(Icons.calendar_month_rounded, size: 16),
          label: const Text('Pickup calendar'),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
        children: [
          GdCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Your matching preferences', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                const SizedBox(height: 6),
                const Text('GreenDrop uses these to help eligible Pune donations reach you sooner.',
                    style: TextStyle(fontSize: 12, color: GdColors.copy)),
                const SizedBox(height: 14),
                Row(children: [
                  const Icon(Icons.menu_book_rounded, color: GdColors.forest, size: 20),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Books & school supplies', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                        Text('High priority · 8 waiting', style: TextStyle(fontSize: 11.5, color: GdColors.copy)),
                      ],
                    ),
                  ),
                ]),
                const SizedBox(height: 12),
                Row(children: [
                  const Icon(Icons.checkroom_rounded, color: GdColors.forest, size: 20),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Seasonal clothing', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                        Text('High priority · 5 waiting', style: TextStyle(fontSize: 11.5, color: GdColors.copy)),
                      ],
                    ),
                  ),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: GdColors.mint, borderRadius: BorderRadius.circular(18)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("THIS WEEK'S GOAL", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: GdColors.forest, letterSpacing: 1)),
                SizedBox(height: 6),
                Text('Complete 30 distributions.', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                SizedBox(height: 4),
                Text('22 done so far — keep the momentum going.', style: TextStyle(fontSize: 12, color: GdColors.copy)),
                SizedBox(height: 8),
                Text('73% complete', style: TextStyle(fontWeight: FontWeight.w700, color: GdColors.forest)),
              ],
            ),
          ),
          SectionTitle('All incoming donations', subtle: '4 open requests'),
          donationTable(MockData.incomingDonations),
        ],
      ),
    );
  }
}
