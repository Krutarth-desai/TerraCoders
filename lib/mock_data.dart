import 'models.dart';

class MockData {
  static const donationTypes = ['Clothes', 'Books', 'Essentials'];

  static const ngoMatches = <String, List<NgoMatch>>{
    'Clothes': [
      NgoMatch(
        name: 'Sakhi Saathi Foundation',
        area: 'Kothrud, Pune',
        distance: '1.2 km away',
        need: 'Urgently needs 40 raincoats for women and children',
        registration: 'MH/2020/PN/381',
        matchPercent: '98%',
        urgency: 'Urgent',
      ),
      NgoMatch(
        name: 'Navjeevan Seva Trust',
        area: 'Shivajinagar, Pune',
        distance: '2.8 km away',
        need: 'Collecting clean clothing for 25 families',
        registration: 'MH/2018/PN/244',
        matchPercent: '94%',
        urgency: 'High need',
      ),
      NgoMatch(
        name: 'Maitri Foundation',
        area: 'Hadapsar, Pune',
        distance: '4.5 km away',
        need: 'Preparing a monsoon relief kit drive',
        registration: 'MH/2021/PN/512',
        matchPercent: '89%',
        urgency: 'This week',
      ),
    ],
    'Books': [
      NgoMatch(
        name: 'Sahyog Shikshan Foundation',
        area: 'Deccan, Pune',
        distance: '1.8 km away',
        need: 'Needs story books for a reading circle of 30 children',
        registration: 'MH/2017/PN/190',
        matchPercent: '99%',
        urgency: 'Urgent',
      ),
      NgoMatch(
        name: 'Dnyan Prabodhini Trust',
        area: 'Kondhwa, Pune',
        distance: '3.6 km away',
        need: 'Building back-to-school kits for 18 students',
        registration: 'MH/2019/PN/431',
        matchPercent: '95%',
        urgency: 'High need',
      ),
      NgoMatch(
        name: 'Prerna Bal Kendra',
        area: 'Pimpri, Pune',
        distance: '6.1 km away',
        need: 'Seeking reference books for secondary students',
        registration: 'MH/2016/PN/087',
        matchPercent: '88%',
        urgency: 'This week',
      ),
    ],
    'Essentials': [
      NgoMatch(
        name: 'Asha Kiran Seva Sanstha',
        area: 'Camp, Pune',
        distance: '2.1 km away',
        need: 'Packing household essentials for 20 families',
        registration: 'MH/2015/PN/166',
        matchPercent: '97%',
        urgency: 'Urgent',
      ),
      NgoMatch(
        name: 'Samarth Foundation',
        area: 'Warje, Pune',
        distance: '3.9 km away',
        need: 'Needs dry-ration and hygiene supplies',
        registration: 'MH/2020/PN/489',
        matchPercent: '92%',
        urgency: 'High need',
      ),
      NgoMatch(
        name: 'Maitri Foundation',
        area: 'Hadapsar, Pune',
        distance: '4.5 km away',
        need: 'Coordinating a family support drive',
        registration: 'MH/2021/PN/512',
        matchPercent: '86%',
        urgency: 'This week',
      ),
    ],
  };

  static List<NgoMatch> matchesFor(String type) =>
      ngoMatches[type] ?? ngoMatches['Books']!;

  static const donationTimeline = <DonationRecord>[
    DonationRecord(
      type: 'Books',
      title: '10 children received your books',
      source: 'Sahyog Shikshan Foundation · 02 Aug 2026 · Distribution complete',
      status: 'completed',
    ),
    DonationRecord(
      type: 'Clothes',
      title: 'Rainwear is being sorted for the monsoon drive',
      source: 'Sakhi Saathi Foundation · 01 Aug 2026 · Pickup complete',
      status: 'scheduled',
    ),
    DonationRecord(
      type: 'Essentials',
      title: 'Family essentials delivered',
      source: 'Asha Kiran Seva Sanstha · 23 Jul 2026 · Distribution complete',
      status: 'completed',
    ),
  ];

  static const incomingDonations = <IncomingDonation>[
    IncomingDonation(
      donor: 'Advait Chitale',
      items: '10 Books',
      pickup: 'Today, 4:30 PM',
      status: 'new',
    ),
    IncomingDonation(
      donor: 'Tanvi Joshi',
      items: '2 bags of clothes',
      pickup: 'Tomorrow, 11 AM',
      status: 'scheduled',
    ),
    IncomingDonation(
      donor: 'Omkar Kulkarni',
      items: 'Food essentials',
      pickup: 'Tomorrow, 2 PM',
      status: 'new',
    ),
    IncomingDonation(
      donor: 'Anagha Deshmukh',
      items: 'Study table',
      pickup: '8 Aug, 12 PM',
      status: 'scheduled',
    ),
  ];

  static const leaderboard = <LeaderboardEntry>[
    LeaderboardEntry(1, 'Isha Bhosale', '2,480 XP'),
    LeaderboardEntry(2, 'Pranav Kulkarni', '1,980 XP'),
    LeaderboardEntry(3, 'Siddhesh Patil', '1,655 XP'),
    LeaderboardEntry(4, 'You · Advait Chitale', '', isMe: true),
    LeaderboardEntry(5, 'Anagha Deshmukh', '1,120 XP'),
  ];

  static const communityFeed = <FeedPost>[
    FeedPost(
      'Sahyog Shikshan Foundation',
      '2 hours ago · Pune NGO update',
      "Today's reading circle began with 10 story books from Advait Chitale "
          'through GreenDrop. The smiles say everything.',
      '#EducationForPune',
    ),
    FeedPost(
      'Tanvi Joshi',
      'Yesterday · Pune Green Champion',
      'My clothes will reach 18 women through Sakhi Saathi Foundation. '
          'GreenDrop makes every donation feel real.',
      '#MyGreenDrop',
    ),
  ];

  static const nearbyNgos = <NearbyNgo>[
    NearbyNgo('Sakhi Saathi Foundation', 'Kothrud', '1.2 km',
        'Urgently needs rainwear', '98%', 'SS', 'Clothes'),
    NearbyNgo('Sahyog Shikshan Foundation', 'Deccan', '1.8 km',
        'Reading circles need books', '99%', 'SK', 'Books'),
    NearbyNgo('Asha Kiran Seva Sanstha', 'Camp', '2.1 km',
        'Supporting 20 households', '97%', 'AK', 'Essentials'),
  ];

  static const needsNow = [
    ['Clothes', 'Urgent · 1.2 km away', '40 raincoats needed before Pune monsoon drive', 'Sakhi Saathi Foundation · Kothrud', 'Respond now'],
    ['Books', 'High need · 1.8 km away', "Story books for 30 children's reading circle", 'Sahyog Shikshan Foundation · Deccan', 'Match books'],
    ['Essentials', 'This week · 2.1 km away', 'Family essentials for 20 Pune households', 'Asha Kiran Seva Sanstha · Camp', 'Help now'],
  ];
}
