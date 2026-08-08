import 'package:flutter/material.dart';
import '../app_state.dart';
import '../models.dart';
import '../theme.dart';
import '../widgets/nav.dart';
import 'donor/donor_home.dart';
import 'donor/donor_donate.dart';
import 'donor/donor_impact.dart';
import 'donor/donor_leaderboard.dart';
import 'donor/donor_nearby.dart';
import 'donor/donor_community.dart';
import 'donor/donor_profile.dart';
import 'ngo/ngo_home.dart';
import 'ngo/ngo_donations.dart';
import 'ngo/ngo_updates.dart';
import 'ngo/ngo_community.dart';
import 'ngo/ngo_profile.dart';

class DashboardShell extends StatelessWidget {
  final AppState state;
  const DashboardShell({super.key, required this.state});

  Widget _page() {
    if (state.role == Role.donor) {
      switch (state.page) {
        case 'donate':
          return DonorDonatePage(state: state);
        case 'impact':
          return DonorImpactPage(state: state);
        case 'leaderboard':
          return DonorLeaderboardPage(state: state);
        case 'nearby':
          return DonorNearbyPage(state: state);
        case 'community':
          return DonorCommunityPage(state: state);
        case 'profile':
          return DonorProfilePage(state: state);
        default:
          return DonorHomePage(state: state);
      }
    } else {
      switch (state.page) {
        case 'donations':
          return NgoDonationsPage(state: state);
        case 'updates':
          return NgoUpdatesPage(state: state);
        case 'community':
          return NgoCommunityPage(state: state);
        case 'profile':
          return NgoProfilePage(state: state);
        default:
          return NgoHomePage(state: state);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: state.dark ? GdColors.darkBg : GdColors.sand,
      body: LayoutBuilder(builder: (context, constraints) {
        final wide = constraints.maxWidth >= 900;
        return Row(
          children: [
            if (wide) GdSidebar(state: state),
            Expanded(child: _page()),
          ],
        );
      }),
      bottomNavigationBar: LayoutBuilder(builder: (context, constraints) {
        final wide = constraints.maxWidth >= 900;
        if (wide) return const SizedBox.shrink();
        return GdMobileBottomNav(state: state);
      }),
    );
  }
}
