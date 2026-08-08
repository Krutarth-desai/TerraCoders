enum Role { donor, ngo }

enum AppStage { splash, onboarding, roleSelect, auth, dashboard }

enum AuthMode { login, signup }

/// A verified NGO match shown to a donor for a given donation type.
class NgoMatch {
  final String name;
  final String area;
  final String distance;
  final String need;
  final String registration;
  final String matchPercent;
  final String urgency;

  const NgoMatch({
    required this.name,
    required this.area,
    required this.distance,
    required this.need,
    required this.registration,
    required this.matchPercent,
    required this.urgency,
  });
}

/// A donation the donor has made or requested, shown in the impact timeline.
class DonationRecord {
  final String type;
  final String title;
  final String source;
  final String status; // requested | scheduled | completed
  const DonationRecord({
    required this.type,
    required this.title,
    required this.source,
    required this.status,
  });
}

/// An incoming donation request as seen from the NGO side.
class IncomingDonation {
  final String donor;
  final String items;
  final String pickup;
  final String status; // new | scheduled
  const IncomingDonation({
    required this.donor,
    required this.items,
    required this.pickup,
    required this.status,
  });
}

class LeaderboardEntry {
  final int rank;
  final String name;
  final String xp;
  final bool isMe;
  const LeaderboardEntry(this.rank, this.name, this.xp, {this.isMe = false});
}

class FeedPost {
  final String author;
  final String meta;
  final String text;
  final String tag;
  const FeedPost(this.author, this.meta, this.text, this.tag);
}

class NearbyNgo {
  final String name;
  final String area;
  final String distance;
  final String need;
  final String matchPercent;
  final String initials;
  final String donationType;
  const NearbyNgo(this.name, this.area, this.distance, this.need,
      this.matchPercent, this.initials, this.donationType);
}
