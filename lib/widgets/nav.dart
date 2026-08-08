import 'package:flutter/material.dart';
import '../app_state.dart';
import '../models.dart';
import '../theme.dart';
import 'common.dart';

class NavItem {
  final String key;
  final IconData icon;
  final String label;
  const NavItem(this.key, this.icon, this.label);
}

const donorNav = [
  NavItem('home', Icons.home_rounded, 'Home'),
  NavItem('donate', Icons.add_circle_rounded, 'Donate'),
  NavItem('impact', Icons.donut_large_rounded, 'My impact'),
  NavItem('nearby', Icons.map_rounded, 'Nearby NGOs'),
  NavItem('leaderboard', Icons.emoji_events_rounded, 'Pune ranks'),
  NavItem('community', Icons.groups_rounded, 'Community'),
  NavItem('profile', Icons.person_rounded, 'Profile'),
];

const ngoNav = [
  NavItem('home', Icons.dashboard_rounded, 'Dashboard'),
  NavItem('donations', Icons.inventory_2_rounded, 'Donations'),
  NavItem('updates', Icons.campaign_rounded, 'Post updates'),
  NavItem('community', Icons.groups_rounded, 'Community'),
  NavItem('profile', Icons.verified_rounded, 'NGO profile'),
];

const donorMobileNav = [
  NavItem('home', Icons.home_rounded, 'Home'),
  NavItem('donate', Icons.add_circle_rounded, 'Donate'),
  NavItem('impact', Icons.donut_large_rounded, 'Impact'),
  NavItem('nearby', Icons.map_rounded, 'Nearby'),
  NavItem('profile', Icons.person_rounded, 'Profile'),
];

class GdSidebar extends StatelessWidget {
  final AppState state;
  const GdSidebar({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final donor = state.role == Role.donor;
    final nav = donor ? donorNav : ngoNav;
    final dark = state.dark;
    return Container(
      width: 260,
      color: dark ? GdColors.darkCard : GdColors.card,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: GdColors.forest,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.eco_rounded, color: GdColors.lime, size: 20),
            ),
            const SizedBox(width: 10),
            Text('GreenDrop',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: dark ? GdColors.darkInk : GdColors.ink)),
          ]),
          const SizedBox(height: 28),
          Expanded(
            child: ListView(
              children: nav
                  .map((item) => _NavButton(
                        item: item,
                        active: state.page == item.key,
                        onTap: () => state.navigate(item.key),
                      ))
                  .toList(),
            ),
          ),
          GdCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(donor ? 'Your kindness matters' : 'A stronger community',
                    style: const TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text(
                  donor
                      ? 'You have created 46 moments of support.'
                      : 'Your impact is visible to every donor.',
                  style: TextStyle(
                      fontSize: 12.5,
                      color: dark ? GdColors.darkCopy : GdColors.copy),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => showGdToast(
                      context, 'Your GreenDrop impact certificate is ready.'),
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: const Text('View impact story →',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundColor: GdColors.mint,
              child: Text(donor ? 'AC' : 'PF',
                  style: const TextStyle(
                      color: GdColors.forest, fontWeight: FontWeight.w800)),
            ),
            title: Text(donor ? 'Advait Chitale' : 'Prayatna Foundation',
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
            subtitle: Text(
                donor ? 'Pune Green Champion' : 'Verified NGO · Pune',
                style: const TextStyle(fontSize: 11.5)),
            onTap: () => state.navigate('profile'),
          ),
          TextButton.icon(
            onPressed: state.logout,
            icon: const Icon(Icons.logout_rounded, size: 18, color: Colors.redAccent),
            label: const Text('Sign out', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final NavItem item;
  final bool active;
  final VoidCallback onTap;
  const _NavButton({required this.item, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: active ? GdColors.mint : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(children: [
              Icon(item.icon,
                  size: 19,
                  color: active ? GdColors.forest : GdColors.copy),
              const SizedBox(width: 12),
              Text(item.label,
                  style: TextStyle(
                      fontWeight: active ? FontWeight.w800 : FontWeight.w600,
                      color: active ? GdColors.forestDark : GdColors.copy)),
            ]),
          ),
        ),
      ),
    );
  }
}

class GdMobileBottomNav extends StatelessWidget {
  final AppState state;
  const GdMobileBottomNav({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.role != Role.donor) return const SizedBox.shrink();
    final index = donorMobileNav.indexWhere((n) => n.key == state.page);
    return NavigationBar(
      selectedIndex: index < 0 ? 0 : index,
      backgroundColor: state.dark ? GdColors.darkCard : GdColors.card,
      onDestinationSelected: (i) => state.navigate(donorMobileNav[i].key),
      destinations: donorMobileNav
          .map((n) => NavigationDestination(icon: Icon(n.icon), label: n.label))
          .toList(),
    );
  }
}
