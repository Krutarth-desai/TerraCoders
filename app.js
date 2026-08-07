const app = document.getElementById('app');
const state = {
  role: null,
  authMode: 'login',
  page: 'home',
  modal: null,
  donationType: 'Books',
  pickupType: 'NGO pickup',
  matchedNgo: null,
  donations: 6,
  xp: 1240,
  recentDonation: null
};

const ngoMatches = {
  Clothes: [
    ['Sakhi Saathi Foundation', 'Kothrud, Pune', '1.2 km away', 'Urgently needs 40 raincoats for women and children', 'MH/2020/PN/381', '98%', 'Urgent'],
    ['Navjeevan Seva Trust', 'Shivajinagar, Pune', '2.8 km away', 'Collecting clean clothing for 25 families', 'MH/2018/PN/244', '94%', 'High need'],
    ['Maitri Foundation', 'Hadapsar, Pune', '4.5 km away', 'Preparing a monsoon relief kit drive', 'MH/2021/PN/512', '89%', 'This week']
  ],
  Books: [
    ['Sahyog Shikshan Foundation', 'Deccan, Pune', '1.8 km away', 'Needs story books for a reading circle of 30 children', 'MH/2017/PN/190', '99%', 'Urgent'],
    ['Dnyan Prabodhini Trust', 'Kondhwa, Pune', '3.6 km away', 'Building back-to-school kits for 18 students', 'MH/2019/PN/431', '95%', 'High need'],
    ['Prerna Bal Kendra', 'Pimpri, Pune', '6.1 km away', 'Seeking reference books for secondary students', 'MH/2016/PN/087', '88%', 'This week']
  ],
  Essentials: [
    ['Asha Kiran Seva Sanstha', 'Camp, Pune', '2.1 km away', 'Packing household essentials for 20 families', 'MH/2015/PN/166', '97%', 'Urgent'],
    ['Samarth Foundation', 'Warje, Pune', '3.9 km away', 'Needs dry-ration and hygiene supplies', 'MH/2020/PN/489', '92%', 'High need'],
    ['Maitri Foundation', 'Hadapsar, Pune', '4.5 km away', 'Coordinating a family support drive', 'MH/2021/PN/512', '86%', 'This week']
  ]
};

const donorNav = [['home', '&#8962;', 'Home'], ['donate', '+', 'Donate'], ['impact', '&#9678;', 'My impact'], ['leaderboard', '&#9819;', 'Pune ranks'], ['community', '&#9673;', 'Community']];
const ngoNav = [['home', '&#8962;', 'Dashboard'], ['donations', '&#9638;', 'Donations'], ['updates', '&#10022;', 'Post updates'], ['community', '&#9673;', 'Community'], ['profile', '&#9817;', 'NGO profile']];

function icon(name) {
  return { clothes: '&#128085;', books: '&#128218;', essentials: '&#129370;', impact: '&#127807;', people: '&#128101;', map: '&#128205;', truck: '&#128666;', pickup: '&#129526;', check: '&#10003;' }[name] || '&#10022;';
}

function matches() { return ngoMatches[state.donationType] || ngoMatches.Books; }
function ngoObject(index) {
  const item = matches()[Number(index)];
  return { name: item[0], area: item[1], distance: item[2], need: item[3], registration: item[4], match: item[5], urgency: item[6] };
}

function topbar(title, subtitle, action = '') {
  return `<header class="topbar"><div class="page-title"><h1>${title}</h1><p>${subtitle}</p></div><div class="top-actions"><button class="icon-button" data-action="toast" data-message="You are all caught up.">&#9825;<span class="notice-dot"></span></button>${action}</div></header>`;
}

function sidebar() {
  const donor = state.role === 'donor';
  const nav = donor ? donorNav : ngoNav;
  return `<div class="brand"><i class="brand-mark"></i><span>GreenDrop</span></div><nav class="nav">${nav.map(([key, mark, label]) => `<button class="${state.page === key ? 'active' : ''}" data-action="nav" data-page="${key}"><span class="nav-ico">${mark}</span><span>${label}</span></button>`).join('')}</nav><div class="sidebar-bottom"><div class="help-card"><strong>${donor ? 'Your generosity matters' : 'Need a hand?'}</strong>${donor ? 'Every donation creates a verified local impact.' : 'Access GreenDrop partner support.'}<button data-action="toast" data-message="Support request received. We will be in touch shortly.">${donor ? 'View your impact &rarr;' : 'Contact support &rarr;'}</button></div><div class="account"><div class="profile-img">${donor ? '&#128100;' : '&#127807;'}</div><div><div class="name">${donor ? 'Advait Chitale' : 'Prayatna Foundation'}</div><div class="role-type">${donor ? 'Pune Green Champion' : 'Verified NGO · Pune'}</div></div><button class="dots" data-action="logout" title="Log out">&middot;&middot;&middot;</button></div></div>`;
}

function layout(content) {
  return `<div class="dashboard"><aside class="sidebar">${sidebar()}</aside><main class="main">${content}</main></div>${state.modal ? modal() : ''}`;
}

function donationTiles() {
  const tiles = [['clothes', 'Clothes', 'Give comfort'], ['books', 'Books', 'Share knowledge'], ['essentials', 'Essentials', 'Support families'], ['impact', 'More items', 'Make space']];
  return `<div class="donate-grid">${tiles.map(([id, title, detail]) => `<button class="donate-tile" data-action="quick-donate" data-type="${title === 'More items' ? 'Essentials' : title}"><span class="tile-icon">${icon(id)}</span><b>${title}</b><small>${detail}</small><span class="plus">+</span></button>`).join('')}</div>`;
}

function needsNow() {
  const needs = [
    ['Clothes', 'Urgent · 1.2 km away', '40 raincoats needed before Pune monsoon drive', 'Sakhi Saathi Foundation · Kothrud', 'Respond now'],
    ['Books', 'High need · 1.8 km away', 'Story books for 30 children\'s reading circle', 'Sahyog Shikshan Foundation · Deccan', 'Match books'],
    ['Essentials', 'This week · 2.1 km away', 'Family essentials for 20 Pune households', 'Asha Kiran Seva Sanstha · Camp', 'Help now']
  ];
  return `<section class="needs-grid">${needs.map(([type, status, title, ngo, cta], index) => `<article class="need-card ${index === 0 ? 'urgent' : ''}"><div><span class="need-kicker">${status}</span><h3>${title}</h3><p>${ngo}</p></div><button data-action="need-respond" data-type="${type}">${cta} &rarr;</button></article>`).join('')}</section>`;
}

function updatesCard() {
  return `<article class="card update-card"><div class="update-head"><h3>Impact updates</h3><span class="status completed">3 new</span></div><div class="update-list"><div class="update-item"><span class="update-icon">${icon('books')}</span><div><b>Your 10 books reached 10 young readers</b><p>Sahyog Shikshan Foundation · Pune · 2 hours ago</p></div><span class="time">${icon('check')}</span></div><div class="update-item"><span class="update-icon">${icon('clothes')}</span><div><b>Rainwear sorted for the monsoon drive</b><p>Sakhi Saathi Foundation · Yesterday</p></div><span class="time">${icon('check')}</span></div><div class="update-item"><span class="update-icon">${icon('impact')}</span><div><b>You earned 120 XP for your impact</b><p>GreenDrop Pune · 2 days ago</p></div><span class="time">+</span></div></div></article>`;
}

function donorHome() {
  return layout(`${topbar('Welcome, Advait', 'Your kindness is creating a measurable change across Pune.', '<button class="add-button" data-action="modal" data-modal="donate">+ Donate now</button>')}<div class="grid-2"><article class="impact-hero"><p class="eyebrow">Your Pune giving journey</p><h2>Small drops. A world of change.</h2><p>You are in the top 12% of Pune donors this month.</p><div class="xp-chip">&#9889; <b>${state.xp} XP</b> &nbsp;·&nbsp; Pune Green Champion</div></article><article class="card stats-card"><h3>Your giving at a glance</h3><div class="donation-total">${state.donations} <span>donations</span></div><div class="subtle">You have helped 46 people so far</div><div class="progress-track"><span></span></div><div class="progress-label"><span>Level 3</span><b>260 XP to Level 4</b></div></article></div><div class="section-title"><h2>What would you like to give?</h2><button class="text-button" data-action="modal" data-modal="donate">View all categories &rarr;</button></div>${donationTiles()}<div class="section-title"><h2>Needs now in Pune</h2><span class="subtle">Verified requests · updated today</span></div>${needsNow()}<div class="grid-2"><section><div class="section-title"><h2>Where your gifts went</h2><button class="text-button" data-action="nav" data-page="impact">See impact &rarr;</button></div><article class="card map-card"><h3>Local impact, made visible</h3><p>Your donations are strengthening communities near you.</p><i class="map-pin one"></i><i class="map-pin two"></i><i class="map-pin three"></i><div class="map-caption"><b>3 verified Pune NGOs</b> have received your support.</div></article></section><section><div class="section-title"><h2>Latest from your donations</h2><button class="text-button" data-action="nav" data-page="impact">All updates &rarr;</button></div>${updatesCard()}</section></div>`);
}

function donorDonate() {
  return layout(`${topbar('Donate something meaningful', 'GreenDrop matches your items with verified Pune NGOs that need them now.', '<button class="add-button" data-action="modal" data-modal="donate">+ New donation</button>')}<div class="grid-2 equal"><section><article class="impact-hero"><p class="eyebrow">Every item counts</p><h2>Your unused things can be someone else\'s new beginning.</h2><p>Choose a category to find a nearby Pune NGO.</p></article><div class="section-title"><h2>Popular categories</h2></div>${donationTiles()}</section><section><article class="leader-card"><div class="leader-head"><h3>How the match works</h3><span>Simple & transparent</span></div><div class="rank-row"><span class="rank-number">1</span><span class="mini-icon">&#128230;</span><div><div class="rank-name">Tell us what you have</div><div class="rank-detail">Choose an item and a pickup area.</div></div></div><div class="rank-row"><span class="rank-number">2</span><span class="mini-icon">&#129309;</span><div><div class="rank-name">Get a smart match</div><div class="rank-detail">See Pune NGOs with a live need.</div></div></div><div class="rank-row"><span class="rank-number">3</span><span class="mini-icon">${icon('impact')}</span><div><div class="rank-name">Track verified impact</div><div class="rank-detail">Follow pickup to distribution.</div></div></div></article></section></div>`);
}

function metricGrid() {
  return `<section class="metric-grid"><article class="metric-card"><span>&#128230;</span><b>86</b><small>items reused</small></article><article class="metric-card"><span>&#9851;</span><b>42 kg</b><small>diverted from landfill</small></article><article class="metric-card"><span>&#127758;</span><b>114 kg</b><small>CO<sub>2</sub> saved</small></article><article class="metric-card"><span>&#128154;</span><b>46</b><small>people supported</small></article></section>`;
}

function proofCard() {
  return `<article class="impact-proof"><div class="proof-image"><span>SAHYOG<br>SHIKSHAN</span><i>${icon('books')}</i></div><div class="proof-copy"><span class="verified-mark">${icon('check')} Verified NGO · MH/2017/PN/190</span><h3>Your 10 books reached 10 young readers.</h3><p>On 02 Aug 2026, Sahyog Shikshan Foundation distributed your books at its Deccan reading circle in Pune.</p><div class="proof-meta"><span>${icon('map')} Deccan, Pune</span><span>&#128103; 10 recipients</span><span>&#128197; 02 Aug 2026</span></div></div></article>`;
}

function donorImpact() {
  const current = state.recentDonation ? `<div class="impact-row"><span class="mini-icon">${icon(state.recentDonation.type.toLowerCase())}</span><div><b>${state.recentDonation.type} matched with ${state.recentDonation.ngo}</b><span>${state.recentDonation.pickup} · Pune · Awaiting NGO acceptance</span></div><strong class="status requested">Requested</strong></div>` : '';
  return layout(`${topbar('Your impact story', 'A transparent, verifiable record of the good you have made possible.')}<div class="grid-2"><article class="impact-hero"><p class="eyebrow">Impact score</p><h2>46 lives touched, and counting.</h2><p>Your consistent giving supports education, dignity and care across Pune.</p><div class="xp-chip">&#9889; <b>${state.xp} XP earned</b></div></article><article class="card"><h3 style="margin-top:0">Impact by category</h3><div class="impact-list" style="margin-top:20px"><div class="impact-row"><span class="mini-icon">${icon('books')}</span><div><b>Books & stationery</b><span>10 children supported</span></div><strong class="impact-value">42%</strong></div><div class="impact-row"><span class="mini-icon">${icon('clothes')}</span><div><b>Clothes</b><span>22 people supported</span></div><strong class="impact-value">36%</strong></div><div class="impact-row"><span class="mini-icon">${icon('essentials')}</span><div><b>Essentials</b><span>14 people supported</span></div><strong class="impact-value">22%</strong></div></div></article></div><div class="section-title"><h2>Your anti-waste impact</h2><span class="subtle">Measured across verified distributions</span></div>${metricGrid()}<div class="section-title"><h2>Verified impact proof</h2><button class="text-button" data-action="toast" data-message="Your GreenDrop impact certificate is ready to share.">Share certificate &rarr;</button></div>${proofCard()}<div class="section-title"><h2>Donation timeline</h2><button class="text-button" data-action="modal" data-modal="donate">+ Add donation</button></div><article class="card"><div class="impact-list">${current}<div class="impact-row"><span class="mini-icon">${icon('books')}</span><div><b>10 children received your books</b><span>Sahyog Shikshan Foundation · 02 Aug 2026 · Distribution complete</span></div><strong class="status completed">Impact verified</strong></div><div class="impact-row"><span class="mini-icon">${icon('clothes')}</span><div><b>Rainwear is being sorted for the monsoon drive</b><span>Sakhi Saathi Foundation · 01 Aug 2026 · Pickup complete</span></div><strong class="status scheduled">Collected</strong></div><div class="impact-row"><span class="mini-icon">${icon('essentials')}</span><div><b>Family essentials delivered</b><span>Asha Kiran Seva Sanstha · 23 Jul 2026 · Distribution complete</span></div><strong class="status completed">Distributed</strong></div></div></article>`);
}

function donorLeaderboard() {
  const people = [['1', 'Isha Bhosale', '2,480 XP'], ['2', 'Pranav Kulkarni', '1,980 XP'], ['3', 'Siddhesh Patil', '1,655 XP'], ['4', 'You · Advait Chitale', `${state.xp} XP`], ['5', 'Anagha Deshmukh', '1,120 XP']];
  return layout(`${topbar('Local change-makers', 'Pune is giving back - one drop at a time.')}<div class="grid-2 equal"><article class="impact-hero"><p class="eyebrow">August leaderboard</p><h2>You are #4 in Pune.</h2><p>One more donation could move you up the rankings and unlock your next badge.</p><div class="xp-chip">&#9819; <b>Top 12%</b> of Pune donors</div></article><article class="card"><h3 style="margin:0 0 12px">Your next reward</h3><div class="mini-icon" style="width:52px;height:52px;font-size:25px">&#127803;</div><b style="display:block;margin-top:12px">Community Hero badge</b><p class="subtle">Earn 260 XP more to unlock a feature on Pune's wall of gratitude.</p><div class="progress-track"><span></span></div></article></div><div class="section-title"><h2>Pune rankings</h2><span class="subtle">Updated weekly</span></div><article class="leader-card"><div class="leader-head"><h3>This month's champions</h3><span>&#9889; XP earned</span></div>${people.map(([rank, name, xp]) => `<div class="rank-row ${name.startsWith('You') ? 'you' : ''}"><span class="rank-number">${rank}</span><span class="rank-avatar">${rank === '1' ? '&#128081;' : '&#128100;'}</span><div><div class="rank-name">${name}</div><div class="rank-detail">${rank === '1' ? 'Local Legend' : 'Making a difference'}</div></div><span class="rank-xp">${xp}</span></div>`).join('')}</article>`);
}

function communityFeed() {
  return `<article class="card"><div class="feed-item"><div class="feed-author"><div class="mini-avatar">&#127804;</div><div><b>Sahyog Shikshan Foundation</b><small>2 hours ago · Pune NGO update</small></div></div><p class="feed-text">Today's reading circle began with 10 story books from Advait Chitale through GreenDrop. The smiles say everything.</p><span class="feed-tag">#EducationForPune</span></div><div class="feed-item"><div class="feed-author"><div class="mini-avatar">&#128100;</div><div><b>Tanvi Joshi</b><small>Yesterday · Pune Green Champion</small></div></div><p class="feed-text">My clothes will reach 18 women through Sakhi Saathi Foundation. GreenDrop makes every donation feel real.</p><span class="feed-tag">#MyGreenDrop</span></div></article>`;
}

function donorCommunity() {
  return layout(`${topbar('GreenDrop community', 'Stories, updates and small acts that add up across Pune.')}<div class="grid-2"><section><article class="card"><div class="event-post"><div class="profile-img">&#128100;</div><div class="field"><textarea placeholder="Share an impact story or ask the Pune community..."></textarea></div></div><div style="display:flex;justify-content:flex-end;margin-top:10px"><button class="add-button" data-action="toast" data-message="Your community post has been shared.">Post update</button></div></article><div class="section-title"><h2>From the community</h2></div>${communityFeed()}</section><section><article class="card"><h3 style="margin-top:0">Upcoming in Pune</h3><div class="impact-list"><div class="impact-row"><span class="mini-icon">&#129526;</span><div><b>Weekend collection drive</b><span>Sat, 9 Aug · 10 AM · Sarasbaug, Pune</span></div></div><div class="impact-row"><span class="mini-icon">${icon('books')}</span><div><b>Back-to-school book drive</b><span>Sun, 17 Aug · 11 AM · Deccan Gymkhana</span></div></div></div><button class="primary" style="margin-top:19px" data-action="toast" data-message="You are registered for the Pune collection drive.">Join an event</button></article></section></div>`);
}

function donationTable(short = false) {
  const rows = [['Advait Chitale', '10 Books', 'Today, 4:30 PM', 'new'], ['Tanvi Joshi', '2 bags of clothes', 'Tomorrow, 11 AM', 'scheduled'], ['Omkar Kulkarni', 'Food essentials', 'Tomorrow, 2 PM', 'new'], ['Anagha Deshmukh', 'Study table', '8 Aug, 12 PM', 'scheduled']];
  return `<article class="card table-wrap"><table class="data-table"><thead><tr><th>Donor</th><th>Items</th><th>Pickup</th><th>Status</th></tr></thead><tbody>${rows.slice(0, short ? 3 : 4).map(([name, items, pickup, status]) => `<tr><td><div class="donor-cell"><span class="mini-avatar">&#128100;</span>${name}</div></td><td>${items}</td><td>${pickup}</td><td><span class="status ${status}">${status === 'new' ? 'New request' : 'Scheduled'}</span></td></tr>`).join('')}</tbody></table></article>`;
}

function ngoHome() {
  return layout(`${topbar('Welcome, Prayatna Foundation', 'Here is what your Pune community has made possible today.', '<button class="add-button" data-action="modal" data-modal="update">+ Post an update</button>')}<article class="ngo-banner"><p class="eyebrow">Community impact · Pune</p><h2>16 new donations are waiting to do good.</h2><p>3 donors are ready to schedule a pickup with your team.</p></article><div class="ngo-kpis"><article class="kpi"><span class="kpi-icon">&#128230;</span><b>124</b><span>Items received this month</span></article><article class="kpi"><span class="kpi-icon">&#128154;</span><b>89</b><span>Lives supported</span></article><article class="kpi"><span class="kpi-icon">&#129309;</span><b>38</b><span>Active donors</span></article></div><div class="grid-2"><section><div class="section-title"><h2>New donation requests</h2><button class="text-button" data-action="nav" data-page="donations">View all &rarr;</button></div>${donationTable(true)}</section><section><div class="section-title"><h2>Community updates</h2><button class="text-button" data-action="nav" data-page="updates">Create post &rarr;</button></div>${communityFeed()}</section></div>`);
}

function ngoDonations() {
  return layout(`${topbar('Donation requests', 'Review offers from Pune donors and arrange pickups.', '<button class="add-button" data-action="toast" data-message="Pickup calendar opened.">&#9638; Pickup calendar</button>')}<div class="grid-2 equal"><article class="card"><h3 style="margin-top:0">Your matching preferences</h3><p class="subtle">GreenDrop uses these to help eligible Pune donations reach you sooner.</p><div class="impact-list" style="margin-top:18px"><div class="impact-row"><span class="mini-icon">${icon('books')}</span><div><b>Books & school supplies</b><span>High priority · 8 waiting</span></div></div><div class="impact-row"><span class="mini-icon">${icon('clothes')}</span><div><b>Seasonal clothing</b><span>High priority · 5 waiting</span></div></div></div></article><article class="impact-hero"><p class="eyebrow">This week's goal</p><h2>Complete 30 distributions.</h2><p>22 done so far - keep the momentum going.</p><div class="xp-chip"><b>73%</b>&nbsp; complete</div></article></div><div class="section-title"><h2>All incoming donations</h2><span class="subtle">4 open requests</span></div>${donationTable(false)}`);
}

function ngoUpdates() {
  return layout(`${topbar('Share an impact update', 'Keep your donors close to the change they made.', '<button class="add-button" data-action="modal" data-modal="update">+ New update</button>')}<div class="grid-2"><section><article class="card"><h3 style="margin-top:0">Write to your donor community</h3><p class="subtle">A clear update builds trust and brings donors back.</p><div class="field"><label>Update title</label><input value="Your Pune donations made today brighter" /></div><div class="field"><label>What happened?</label><textarea>We distributed school books and learning kits to children at our weekly Deccan reading circle. Thank you for making this possible.</textarea></div><button class="primary" data-action="publish-update">Publish update</button></article></section><section><article class="card"><h3 style="margin-top:0">Why updates matter</h3><div class="impact-list" style="margin-top:20px"><div class="impact-row"><span class="mini-icon">&#128172;</span><div><b>Build lasting trust</b><span>Donors understand exactly where support goes.</span></div></div><div class="impact-row"><span class="mini-icon">&#128260;</span><div><b>Encourage repeat giving</b><span>Visible impact makes donors feel part of the mission.</span></div></div><div class="impact-row"><span class="mini-icon">${icon('impact')}</span><div><b>Grow your community</b><span>Every post can inspire Pune neighbours to help.</span></div></div></div></article><div class="section-title"><h2>Recent posts</h2></div>${communityFeed()}</section></div>`);
}

function ngoCommunity() {
  return layout(`${topbar('Build your community', 'Create events and stories that bring Pune supporters together.', '<button class="add-button" data-action="toast" data-message="Event creator opened.">+ Create event</button>')}<div class="grid-2"><section><article class="ngo-banner"><p class="eyebrow">Next community event</p><h2>Monsoon essentials drive</h2><p>9 Aug · 10:00 AM · Sarasbaug, Pune</p></article><div class="section-title"><h2>Community wall</h2></div>${communityFeed()}</section><section><article class="card"><h3 style="margin-top:0">Your community reach</h3><div class="donation-total">1,284 <span>supporters</span></div><p class="subtle">Across Pune donors, volunteers and local changemakers.</p><div class="progress-track"><span style="width:81%"></span></div><div class="progress-label"><span>August goal</span><b>1,500 people</b></div></article><div class="section-title"><h2>Content ideas</h2></div><article class="card"><div class="impact-list"><div class="impact-row"><span class="mini-icon">&#128247;</span><div><b>Show the journey</b><span>Post a photo update after a distribution.</span></div></div><div class="impact-row"><span class="mini-icon">&#127942;</span><div><b>Celebrate a donor</b><span>Thank a Pune Green Champion this week.</span></div></div></div></article></section></div>`);
}

function ngoProfile() {
  return layout(`${topbar('Prayatna Foundation', 'Your verified public profile and organisation settings.', '<button class="add-button" data-action="toast" data-message="Profile changes saved successfully.">Save changes</button>')}<div class="grid-2"><section><article class="card verified-profile"><div style="display:flex;gap:17px;align-items:center"><div class="profile-img" style="width:70px;height:70px;font-size:32px;background:#d8efd8">&#127807;</div><div><h2 style="margin:0;font-size:21px">Prayatna Foundation</h2><p class="subtle" style="margin:5px 0">Kothrud, Pune, Maharashtra</p><span class="verified-mark">${icon('check')} GreenDrop verified NGO</span></div></div><div class="verification-grid"><div><span>Registration</span><b>MH/2020/PN/381</b></div><div><span>Compliance</span><b>12A & 80G verified</b></div><div><span>Trust score</span><b>4.9 / 5 · 126 donors</b></div><div><span>Active since</span><b>2020 · Pune</b></div></div><div class="profile-impact-note">${icon('check')} Registration, location and impact history independently checked by GreenDrop.</div><hr style="border:0;border-top:1px solid var(--line);margin:22px 0"><div class="field"><label>About your organisation</label><textarea>Prayatna Foundation supports education, dignity and livelihood for underserved communities across Pune.</textarea></div><div class="field"><label>Collection address</label><input value="Paud Road, Kothrud, Pune, Maharashtra" /></div></article></section><section><article class="card"><h3 style="margin-top:0">Verified impact history</h3><div class="impact-list" style="margin-top:20px"><div class="impact-row"><span class="mini-icon">${icon('people')}</span><div><b>3,240</b><span>Lives supported since joining GreenDrop</span></div></div><div class="impact-row"><span class="mini-icon">&#128230;</span><div><b>1,678</b><span>Donations transparently distributed</span></div></div><div class="impact-row"><span class="mini-icon">${icon('map')}</span><div><b>12</b><span>Pune neighbourhoods reached</span></div></div></div></article><div class="section-title"><h2>Verification makes trust visible</h2></div><article class="card"><p class="subtle" style="line-height:1.6;margin:0">Donors can see Prayatna's registration record, exact Pune location and proof-of-impact history before accepting a match.</p></article></section></div>`);
}

function splash() {
  app.innerHTML = `<section class="splash"><div class="splash-grid"><div class="splash-copy"><div class="brand"><i class="brand-mark"></i><span>GreenDrop</span></div><h1>Give good<br>a <em>second life.</em></h1><p class="hero-copy">The easy, transparent way to turn what you no longer need into real change across Pune.</p><div class="tiny-proof"><div class="avatar-stack"><span>&#128100;</span><span>&#128105;</span><span>&#128104;</span><span>&#127807;</span></div><span>Join 12,000+ local change-makers</span></div></div><section class="role-panel"><p class="eyebrow">Welcome to GreenDrop</p><h2>How will you make an impact?</h2><p>Choose your role to get started.</p><div class="role-options"><button class="role" data-action="choose-role" data-role="donor"><span class="role-icon">&#127873;</span><span><strong>I'm a donor</strong><small>Give items, track their impact and grow your green legacy.</small></span><span class="role-arrow">&rarr;</span></button><button class="role" data-action="choose-role" data-role="ngo"><span class="role-icon">${icon('impact')}</span><span><strong>I represent an NGO</strong><small>Connect with Pune donors, distribute support and build community.</small></span><span class="role-arrow">&rarr;</span></button></div><p class="powered">Every drop of kindness creates a ripple.</p></section></div></section>`;
}

function auth() {
  const donor = state.role === 'donor';
  const signup = state.authMode === 'signup';
  const email = donor ? 'advait.chitale@greendrop.demo' : 'prayatna@greendrop.demo';
  const password = donor ? 'Green@123' : 'NGO@123';
  app.innerHTML = `<section class="auth-screen"><div class="auth-visual"><div class="brand"><i class="brand-mark"></i><span>GreenDrop</span></div><div class="auth-message"><h1>${donor ? (signup ? 'Start your giving story.' : 'Welcome back, change-maker.') : (signup ? 'Make impact happen, together.' : 'Your Pune community is waiting.')}</h1><p>${donor ? 'See each donation grow into something real for people in your own Pune neighbourhood.' : 'Bring your mission closer to generous Pune neighbours and make every contribution visible.'}</p></div><div class="impact-note">When people can see the impact of their help, generosity becomes a habit.</div></div><div class="auth-box"><form class="auth-card" data-form="login"><button type="button" class="back" data-action="back-splash">&larr; Back to role selection</button><p class="eyebrow">${donor ? 'Pune donor portal' : 'Pune NGO partner portal'}</p><h2>${signup ? 'Create your account' : 'Sign in to GreenDrop'}</h2><p>${signup ? 'Just a few details and you are ready to begin.' : 'Use the ready-made credentials below for your live demo.'}</p>${signup ? `<div class="field"><label>${donor ? 'Your name' : 'Organisation name'}</label><input required placeholder="${donor ? 'Advait Chitale' : 'Prayatna Foundation'}" /></div>` : `<div class="demo-credentials"><span>Demo account</span><b>${email}</b><b>${password}</b></div>`}<div class="field"><label>Email address</label><input type="email" required value="${email}" /></div><div class="field"><label>Password</label><input type="password" required value="${password}" /></div>${!signup ? '<div class="form-row"><label class="check"><input type="checkbox" checked> Remember me</label><button type="button" class="linkish" data-action="toast" data-message="Password reset link sent (demo).">Forgot password?</button></div>' : ''}<button class="primary" type="submit">${signup ? 'Create my account' : 'Enter GreenDrop'} &rarr;</button><p class="auth-switch">${signup ? 'Already part of the community?' : 'New to GreenDrop?'} <button type="button" class="linkish" data-action="toggle-auth">${signup ? 'Sign in' : 'Create an account'}</button></p></form></div></section>`;
}

function tracker() {
  return `<div class="tracking-card"><div class="tracking-title"><span>Donation tracking</span><b>Requested</b></div><div class="tracking-steps"><div class="active"><i>1</i><span>Requested<small>Just now</small></span></div><div><i>2</i><span>Accepted<small>NGO confirms</small></span></div><div><i>3</i><span>Collected<small>Pickup complete</small></span></div><div><i>4</i><span>Distributed<small>Impact proof</small></span></div></div></div>`;
}

function modal() {
  if (state.modal === 'logout') return `<div class="modal-backdrop logout-backdrop" role="dialog" aria-modal="true" aria-labelledby="logout-title"><div class="modal logout-modal"><button class="close-modal" data-action="close-modal" aria-label="Close">&times;</button><div class="logout-mark">${gdIcon('leaf')}</div><h2 id="logout-title">Leave GreenDrop?</h2><p>Your impact is safely saved. You can continue making change whenever you return.</p><div class="logout-actions"><button class="secondary-button" data-action="close-modal">Stay signed in</button><button class="primary" data-action="confirm-logout">Yes, log out</button></div></div></div>`;
  if (state.modal === 'confirm') return `<div class="modal-backdrop"><div class="modal confirm"><button class="close-modal" data-action="close-modal">&times;</button><div class="confirm-icon">${icon('impact')}</div><h2>Your donation request is live!</h2><p><b>${state.matchedNgo.name}</b> has received your ${state.donationType.toLowerCase()} donation request. You will see every next step here.</p>${tracker()}<div class="xp-chip" style="background:#e9f8ec;color:var(--forest);margin:14px 0 16px">&#9889; <b style="color:var(--forest)">+120 XP earned</b></div><button class="primary" data-action="view-tracking">View my tracking page</button></div></div>`;
  if (state.modal === 'matches') return `<div class="modal-backdrop"><div class="modal match-modal"><button class="close-modal" data-action="close-modal">&times;</button><p class="eyebrow">Smart match for your ${state.donationType.toLowerCase()}</p><h2>Nearby NGOs that need this now</h2><p>Matched using Pune location, current need and category fit. Every partner is independently verified.</p><div class="match-list">${matches().map((item, index) => { const ngo = ngoObject(index); return `<button class="match-card" data-action="choose-match" data-index="${index}"><span class="match-emblem">${index === 0 ? '&#10022;' : '&#10010;'}</span><span class="match-copy"><span class="match-top"><b>${ngo.name}</b><em>${ngo.match} match</em></span><small>${icon('check')} Verified · ${ngo.registration} · ${ngo.distance}</small><strong>${ngo.need}</strong><span class="match-bottom"><i>${ngo.urgency}</i><span>${icon('map')} ${ngo.area}</span></span><span class="match-arrow">&rarr;</span></span></button>`; }).join('')}</div></div></div>`;
  if (state.modal === 'pickup') { const ngo = state.matchedNgo || ngoObject(0); const options = [['NGO pickup', icon('truck'), 'Free doorstep pickup in Kothrud & nearby areas'], ['Self drop-off', icon('map'), 'Drop at the verified NGO collection point'], ['Community drive', icon('pickup'), 'Bring it to the next Sarasbaug collection drive']]; return `<div class="modal-backdrop"><form class="modal" data-form="pickup"><button type="button" class="close-modal" data-action="close-modal">&times;</button><p class="eyebrow">Step 3 of 3 · ${ngo.name}</p><h2>How should your donation travel?</h2><p>Choose the most convenient handover option in Pune.</p><div class="pickup-options">${options.map(([type, mark, copy]) => `<button type="button" class="pickup-option ${state.pickupType === type ? 'selected' : ''}" data-action="choose-pickup" data-pickup="${type}"><i>${mark}</i><span><b>${type}</b><small>${copy}</small></span><em>${state.pickupType === type ? '&#10003;' : ''}</em></button>`).join('')}</div><div class="field"><label>Preferred time</label><select><option>Tomorrow, 4 PM - 6 PM</option><option>This weekend</option><option>Saturday collection drive, 10 AM</option></select></div><button class="primary" type="submit">Confirm donation request &rarr;</button></form></div>`; }
  if (state.modal === 'update') return `<div class="modal-backdrop"><form class="modal" data-form="update"><button type="button" class="close-modal" data-action="close-modal">&times;</button><h2>Share an impact update</h2><p>Let supporters know the story behind their generosity.</p><div class="field"><label>Update title</label><input required placeholder="e.g. 10 children received new books" /></div><div class="field"><label>What happened?</label><textarea required placeholder="Tell your donors what their support made possible..."></textarea></div><button class="primary" type="submit">Publish update</button></form></div>`;
  return `<div class="modal-backdrop"><form class="modal" data-form="donation"><button type="button" class="close-modal" data-action="close-modal">&times;</button><p class="eyebrow">Step 1 of 3</p><h2>Make a donation</h2><p>Share a few details and GreenDrop will find Pune NGOs that need your gift now.</p><div class="type-select">${['Clothes', 'Books', 'Essentials'].map(type => `<button type="button" class="${state.donationType === type ? 'selected' : ''}" data-action="choose-type" data-type="${type}">${icon(type.toLowerCase())} ${type}</button>`).join('')}</div><div class="field"><label>What are you donating?</label><input required placeholder="e.g. 10 children's story books" value="${state.donationType === 'Books' ? '10 children\'s story books' : ''}" /></div><div class="field"><label>Pickup area</label><input required value="Kothrud, Pune" /></div><div class="field"><label>Preferred pickup time</label><select><option>Tomorrow, 4 PM - 6 PM</option><option>This weekend</option><option>I will drop it off myself</option></select></div><button class="primary" type="submit">Find matching NGOs &rarr;</button></form></div>`;
}

function showToast(message) {
  const toast = document.getElementById('toast');
  toast.textContent = message;
  toast.classList.add('show');
  clearTimeout(window.toastTimer);
  window.toastTimer = setTimeout(() => toast.classList.remove('show'), 3300);
}

function renderDashboard() {
  const pages = state.role === 'donor' ? { home: donorHome, donate: donorDonate, impact: donorImpact, leaderboard: donorLeaderboard, community: donorCommunity } : { home: ngoHome, donations: ngoDonations, updates: ngoUpdates, community: ngoCommunity, profile: ngoProfile };
  app.innerHTML = (pages[state.page] || pages.home)();
}

function render() {
  if (!state.role) splash();
  else if (state.page === 'auth') auth();
  else renderDashboard();
}

document.addEventListener('click', (event) => {
  const el = event.target.closest('[data-action]');
  if (!el) return;
  const action = el.dataset.action;
  if (action === 'choose-role') { state.role = el.dataset.role; state.page = 'auth'; }
  if (action === 'back-splash') { state.role = null; state.page = 'home'; state.authMode = 'login'; }
  if (action === 'toggle-auth') state.authMode = state.authMode === 'login' ? 'signup' : 'login';
  if (action === 'nav') state.page = el.dataset.page;
  if (action === 'modal') state.modal = el.dataset.modal;
  if (action === 'close-modal') state.modal = null;
  if (action === 'quick-donate' || action === 'need-respond') { state.donationType = el.dataset.type; state.modal = 'donate'; }
  if (action === 'choose-type') state.donationType = el.dataset.type;
  if (action === 'choose-match') { state.matchedNgo = ngoObject(el.dataset.index); state.modal = 'pickup'; }
  if (action === 'choose-pickup') state.pickupType = el.dataset.pickup;
  if (action === 'view-tracking') { state.modal = null; state.page = 'impact'; }
  if (action === 'logout') { state.role = null; state.page = 'home'; state.authMode = 'login'; showToast('You have been logged out.'); }
  if (action === 'toast') showToast(el.dataset.message);
  if (action === 'publish-update') showToast('Your impact update is live.');
  render();
});

document.addEventListener('submit', (event) => {
  const form = event.target;
  const formName = form.dataset.form;
  if (!formName) return;
  event.preventDefault();
  if (formName === 'login') { state.page = 'home'; showToast(`Welcome to your ${state.role === 'donor' ? 'donor' : 'NGO'} dashboard.`); }
  if (formName === 'donation') state.modal = 'matches';
  if (formName === 'pickup') {
    state.donations += 1;
    state.xp += 120;
    state.recentDonation = { type: state.donationType, ngo: state.matchedNgo.name, pickup: state.pickupType };
    state.modal = 'confirm';
  }
  if (formName === 'update') { state.modal = null; showToast('Update published to your donor community.'); }
  render();
});

render();

/*
  GreenDrop premium experience layer
  This deliberately extends the original view functions and state machine instead
  of replacing the HTML/CSS/JavaScript architecture or donation flows above.
*/
function gdIcon(name) {
  const paths = {
    leaf: '<path d="M12 21c5.4-2.1 8-6.3 8-13-6.7 0-10.5 2.3-12.5 6.7C6.4 17.1 7.7 20 12 21Z"/><path d="M4 20c3.3-5.3 7.3-8.6 12-10"/>',
    home: '<path d="m3 10 9-7 9 7v10a1 1 0 0 1-1 1h-5v-6H9v6H4a1 1 0 0 1-1-1V10Z"/>',
    plus: '<path d="M12 5v14M5 12h14"/>',
    chart: '<path d="M4 19V5M4 19h17"/><path d="m7 15 4-4 3 2 5-6"/>',
    map: '<path d="M12 21s7-5.6 7-12a7 7 0 1 0-14 0c0 6.4 7 12 7 12Z"/><circle cx="12" cy="9" r="2"/>',
    user: '<circle cx="12" cy="8" r="4"/><path d="M4.5 21a7.5 7.5 0 0 1 15 0"/>',
    bell: '<path d="M18 9a6 6 0 0 0-12 0c0 7-3 7-3 9h18c0-2-3-2-3-9M10 22h4"/>',
    arrow: '<path d="M5 12h14M13 6l6 6-6 6"/>',
    back: '<path d="M19 12H5M11 18l-6-6 6-6"/>',
    close: '<path d="m6 6 12 12M18 6 6 18"/>',
    moon: '<path d="M20.5 14.3A8 8 0 0 1 9.7 3.5 8 8 0 1 0 20.5 14.3Z"/>',
    sun: '<circle cx="12" cy="12" r="4"/><path d="M12 2v2M12 20v2M4.9 4.9l1.4 1.4M17.7 17.7l1.4 1.4M2 12h2M20 12h2M4.9 19.1l1.4-1.4M17.7 6.3l1.4-1.4"/>',
    eye: '<path d="M2.5 12s3.5-6 9.5-6 9.5 6 9.5 6-3.5 6-9.5 6-9.5-6-9.5-6Z"/><circle cx="12" cy="12" r="2.5"/>',
    shield: '<path d="M12 3 5 6v5c0 4.8 2.9 8.2 7 10 4.1-1.8 7-5.2 7-10V6l-7-3Z"/><path d="m9 12 2 2 4-4"/>',
    spark: '<path d="m12 2 1.7 6.3L20 10l-6.3 1.7L12 18l-1.7-6.3L4 10l6.3-1.7L12 2Z"/>'
  };
  return `<svg class="gd-icon" viewBox="0 0 24 24" aria-hidden="true" fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round">${paths[name] || paths.spark}</svg>`;
}

function premiumSplash() {
  return `<section class="gd-splash" aria-label="GreenDrop loading">
    <div class="gd-orb orb-one"></div><div class="gd-orb orb-two"></div><div class="gd-grain"></div>
    <div class="gd-splash-content">
      <div class="gd-logo-wrap"><div class="gd-logo-large">${gdIcon('leaf')}</div></div>
      <div class="gd-wordmark">GreenDrop</div>
      <p>Small drops.<br><strong>A world of change.</strong></p>
      <span class="gd-loading"><i></i><i></i><i></i></span>
    </div>
  </section>`;
}

function onboarding() {
  const slides = [
    ['01', 'One kind choice can change a story.', 'Your useful things deserve a meaningful next chapter.', '✦'],
    ['02', 'Give exactly where your city needs it.', 'Meet verified local NGOs and make every donation count.', '⌁'],
    ['03', 'Watch your impact ripple outward.', 'Track each gift from your hands to a brighter tomorrow.', '↗']
  ];
  const index = Math.min(state.onboardingIndex || 0, slides.length - 1);
  const [number, title, copy, glyph] = slides[index];
  return `<section class="onboarding-screen">
    <div class="onboarding-art art-${index}"><div class="art-ring"></div><div class="art-card art-card-a">${glyph}</div><div class="art-card art-card-b">${index === 0 ? '♡' : index === 1 ? '⌖' : '✦'}</div><div class="art-leaf">${gdIcon('leaf')}</div></div>
    <div class="onboarding-copy"><span class="onboarding-number">${number} / 03</span><h1>${title}</h1><p>${copy}</p></div>
    <div class="onboarding-footer"><button class="text-action" data-action="skip-onboarding">Skip</button><div class="dots" aria-label="Onboarding step ${index + 1} of 3">${slides.map((_, i) => `<i class="${i === index ? 'active' : ''}"></i>`).join('')}</div>${index === 2 ? `<button class="round-action wide" data-action="finish-onboarding">Get started ${gdIcon('arrow')}</button>` : `<button class="round-action" aria-label="Next" data-action="next-onboarding">${gdIcon('arrow')}</button>`}</div>
  </section>`;
}

function splash() {
  return `<section class="role-screen">
    <header class="role-top"><div class="brand"><i class="brand-mark"></i><span>GreenDrop</span></div><span class="role-trust">${gdIcon('shield')} Verified local impact</span></header>
    <main class="role-main">
      <div class="role-intro"><span class="eyebrow">A better way to give locally</span><h1>Every useful thing<br>can begin <em>again.</em></h1><p>Join Pune’s kinder, lower-waste community—one small drop at a time.</p><div class="impact-people"><span>JD</span><span>AS</span><span>RK</span><b>12k+ people already creating change</b></div></div>
      <section class="role-panel premium-role-panel"><span class="eyebrow">Choose your path</span><h2>How will you show up?</h2><p>Select a role to continue. You can switch later.</p>
        <div class="role-options premium-roles">
          <button class="role donor-role" data-action="choose-role" data-role="donor"><span class="role-icon">${gdIcon('leaf')}</span><span><strong>Donate with purpose</strong><small>Match your items with trusted local needs.</small></span><span class="role-arrow">${gdIcon('arrow')}</span></button>
          <button class="role ngo-role" data-action="choose-role" data-role="ngo"><span class="role-icon">${gdIcon('shield')}</span><span><strong>Represent an NGO</strong><small>Bring support closer to your community.</small></span><span class="role-arrow">${gdIcon('arrow')}</span></button>
          <button class="role volunteer-role" data-action="choose-role" data-role="donor" data-role-label="volunteer"><span class="role-icon">${gdIcon('spark')}</span><span><strong>Volunteer locally</strong><small>Help coordinate pickups and community drives.</small></span><span class="role-arrow">${gdIcon('arrow')}</span></button>
        </div>
      </section>
    </main>
  </section>`;
}

function auth() {
  const donor = state.role === 'donor';
  const signup = state.authMode === 'signup';
  const email = donor ? 'advait.chitale@greendrop.demo' : 'prayatna@greendrop.demo';
  const password = donor ? 'Green@123' : 'NGO@123';
  const visible = state.passwordVisible ? 'text' : 'password';
  return `<section class="auth-screen premium-auth">
    <div class="auth-visual"><div class="auth-orb"></div><div class="brand"><i class="brand-mark"></i><span>GreenDrop</span></div><div class="auth-message"><span class="eyebrow">${donor ? 'A thoughtful giving space' : 'A trusted partner space'}</span><h1>${signup ? 'Make room for more good.' : donor ? 'Welcome back, change-maker.' : 'Your community is waiting.'}</h1><p>${donor ? 'Give with clarity, and see each act of generosity travel further.' : 'Meet generous neighbors, make impact visible, and build lasting trust.'}</p></div><div class="auth-proof"><span class="proof-dot"></span> 12,000+ people are using GreenDrop today</div></div>
    <div class="auth-box"><form class="auth-card" data-form="login" novalidate><button type="button" class="back" data-action="back-splash">${gdIcon('back')} Back to roles</button><span class="eyebrow">${donor ? 'Donor portal' : 'NGO partner portal'}</span><h2>${signup ? 'Create your account' : 'Sign in to GreenDrop'}</h2><p>${signup ? 'A few details and your giving journey begins.' : 'Use the live demo account to explore the complete experience.'}</p>${signup ? `<div class="field"><label>${donor ? 'Your name' : 'Organisation name'}</label><input required autocomplete="name" placeholder="${donor ? 'Advait Chitale' : 'Prayatna Foundation'}" /></div>` : `<div class="demo-credentials"><span>Demo access</span><b>${email}</b><b>${password}</b></div>`}<div class="field"><label>Email address</label><input type="email" required autocomplete="email" value="${email}" /></div><div class="field password-field"><label>Password</label><div><input type="${visible}" required autocomplete="current-password" value="${password}" /><button type="button" class="password-toggle" data-action="toggle-password" aria-label="${visible === 'password' ? 'Show' : 'Hide'} password">${gdIcon('eye')}</button></div></div>${!signup ? '<div class="form-row"><label class="check"><input type="checkbox" checked> Keep me signed in</label><button type="button" class="linkish" data-action="toast" data-message="A demo reset link is on its way.">Forgot password?</button></div>' : ''}<button class="primary premium-primary" type="submit"><span>${signup ? 'Create my account' : 'Enter GreenDrop'}</span>${gdIcon('arrow')}</button><p class="auth-switch">${signup ? 'Already part of the community?' : 'New to GreenDrop?'} <button type="button" class="linkish" data-action="toggle-auth">${signup ? 'Sign in' : 'Create an account'}</button></p></form></div>
  </section>`;
}

function topbar(title, subtitle, action = '') {
  const back = state.page !== 'home' ? `<button class="icon-button back-app" data-action="nav-back" aria-label="Go back">${gdIcon('back')}</button>` : '<div class="mobile-logo"><i class="brand-mark"></i></div>';
  return `<header class="topbar premium-topbar"><div class="topbar-leading">${back}<div class="page-title"><h1>${title}</h1><p>${subtitle}</p></div></div><div class="top-actions"><button class="icon-button theme-button" data-action="toggle-theme" aria-label="Toggle dark mode">${gdIcon(state.dark ? 'sun' : 'moon')}</button><button class="icon-button notice-button" data-action="toast" data-message="You’re all caught up."> ${gdIcon('bell')}<span class="notice-dot"></span></button><button class="top-avatar" data-action="open-profile" aria-label="Open profile">${state.role === 'ngo' ? 'PF' : 'AC'}</button>${action}</div></header>`;
}

function sidebar() {
  const donor = state.role === 'donor';
  const nav = donor ? [['home', 'home', 'Home'], ['donate', 'plus', 'Donate'], ['impact', 'chart', 'My impact'], ['nearby', 'map', 'Nearby NGOs'], ['community', 'spark', 'Community'], ['profile', 'user', 'Profile']] : [['home', 'home', 'Dashboard'], ['donations', 'plus', 'Donations'], ['updates', 'spark', 'Post updates'], ['community', 'map', 'Community'], ['profile', 'user', 'NGO profile']];
  return `<div class="brand"><i class="brand-mark"></i><span>GreenDrop</span></div><nav class="nav" aria-label="Main navigation">${nav.map(([key, mark, label]) => `<button class="${state.page === key ? 'active' : ''}" data-action="nav" data-page="${key}"><span class="nav-ico">${gdIcon(mark)}</span><span>${label}</span></button>`).join('')}</nav><div class="sidebar-bottom"><div class="help-card"><span class="help-icon">${gdIcon('spark')}</span><strong>${donor ? 'Your kindness matters' : 'A stronger community'}</strong>${donor ? 'You have created 46 moments of support.' : 'Your impact is visible to every donor.'}<button data-action="toast" data-message="Your GreenDrop impact certificate is ready.">View impact story →</button></div><button class="account" data-action="open-profile" aria-label="Open profile"><div class="profile-img">${donor ? 'AC' : 'PF'}</div><div><div class="name">${donor ? 'Advait Chitale' : 'Prayatna Foundation'}</div><div class="role-type">${donor ? 'Pune Green Champion' : 'Verified NGO · Pune'}</div></div></button><button class="sidebar-logout" data-action="logout-request">Sign out</button></div>`;
}

function mobileNav() {
  if (state.role !== 'donor') return '';
  const nav = [['home', 'home', 'Home'], ['donate', 'plus', 'Donate'], ['impact', 'chart', 'Impact'], ['nearby', 'map', 'Nearby'], ['profile', 'user', 'Profile']];
  return `<nav class="mobile-bottom-nav" aria-label="Mobile navigation">${nav.map(([page, ico, label]) => `<button class="${state.page === page ? 'active' : ''}" data-action="nav" data-page="${page}"><span>${gdIcon(ico)}</span><small>${label}</small></button>`).join('')}</nav>`;
}

function layout(content) {
  return `<div class="dashboard"><aside class="sidebar">${sidebar()}</aside><main class="main">${content}</main>${mobileNav()}</div>${state.modal ? modal() : ''}`;
}

function donorNearby() {
  const items = [['Sakhi Saathi Foundation', 'Kothrud', '1.2 km', 'Urgently needs rainwear', '98%'], ['Sahyog Shikshan Foundation', 'Deccan', '1.8 km', 'Reading circles need books', '99%'], ['Asha Kiran Seva Sanstha', 'Camp', '2.1 km', 'Supporting 20 households', '97%']];
  return layout(`${topbar('Nearby NGOs', 'Verified partners making change close to you.', '<button class="add-button" data-action="modal" data-modal="donate">Donate now</button>')}<section class="nearby-hero"><div><span class="eyebrow">Pune, Maharashtra</span><h2>Local needs, ready for your kindness.</h2><p>Every partner is verified for location, registration and impact history.</p></div><span class="nearby-map-pin">${gdIcon('map')}</span></section><div class="section-title"><h2>Recommended near you</h2><span class="subtle">Sorted by active need</span></div><section class="ngo-discovery">${items.map(([name, place, dist, need, match], index) => `<article class="nearby-card"><div class="nearby-card-logo">${index === 0 ? 'SS' : index === 1 ? 'SK' : 'AK'}</div><div><div class="nearby-card-head"><h3>${name}</h3><span>${match} match</span></div><p>${gdIcon('map')} ${place}, Pune · ${dist} away</p><strong>${need}</strong><div><i>${gdIcon('shield')} Verified partner</i><button data-action="quick-donate" data-type="${index === 1 ? 'Books' : index === 2 ? 'Essentials' : 'Clothes'}">Help now ${gdIcon('arrow')}</button></div></div></article>`).join('')}</section>`);
}

function donorProfile() {
  return layout(`${topbar('Your profile', 'Your GreenDrop identity, impact and preferences.')}<section class="profile-hero"><div class="profile-avatar-large">AC</div><div><span class="verified-mark">${gdIcon('shield')} GreenDrop verified</span><h2>Advait Chitale</h2><p>Pune Green Champion · Member since 2025</p></div><button class="edit-profile" data-action="toast" data-message="Profile editing is ready in the full product.">Edit profile</button></section><section class="profile-stat-row"><article><strong>6</strong><span>donations</span></article><article><strong>46</strong><span>people supported</span></article><article><strong>1,240</strong><span>impact XP</span></article></section><section class="profile-settings"><button data-action="nav" data-page="leaderboard"><span>${gdIcon('chart')}</span><div><b>My community rank</b><small>Top 12% of Pune donors</small></div>${gdIcon('arrow')}</button><button data-action="nav" data-page="community"><span>${gdIcon('spark')}</span><div><b>Community stories</b><small>See updates from Pune</small></div>${gdIcon('arrow')}</button><button data-action="toggle-theme"><span>${gdIcon(state.dark ? 'sun' : 'moon')}</span><div><b>${state.dark ? 'Use light appearance' : 'Use dark appearance'}</b><small>Easy on the eyes, day or night</small></div><span class="toggle-state ${state.dark ? 'on' : ''}"><i></i></span></button><button class="danger-row" data-action="logout-request"><span>${gdIcon('back')}</span><div><b>Log out</b><small>Return to role selection</small></div>${gdIcon('arrow')}</button></section>`);
}

function renderDashboard() {
  const pages = state.role === 'donor'
    ? { home: donorHome, donate: donorDonate, impact: donorImpact, leaderboard: donorLeaderboard, community: donorCommunity, nearby: donorNearby, profile: donorProfile }
    : { home: ngoHome, donations: ngoDonations, updates: ngoUpdates, community: ngoCommunity, profile: ngoProfile };
  app.innerHTML = (pages[state.page] || pages.home)();
}

function render() {
  if (!state.stage) state.stage = 'splash';
  document.body.classList.toggle('dark-mode', Boolean(state.dark));
  if (state.stage === 'splash') {
    app.innerHTML = premiumSplash();
    if (!window.greenDropSplashTimer) {
      window.greenDropSplashTimer = window.setTimeout(() => { state.stage = 'onboarding'; window.greenDropSplashTimer = null; render(); }, 2400);
    }
  } else if (state.stage === 'onboarding') {
    app.innerHTML = onboarding();
  } else if (!state.role) {
    app.innerHTML = splash();
  } else if (state.page === 'auth') {
    app.innerHTML = auth();
  } else {
    renderDashboard();
  }
  window.requestAnimationFrame(() => enhanceCurrentView());
}

function enhanceCurrentView() {
  document.querySelectorAll('.donation-total, .metric-card b, .kpi b').forEach((node) => {
    if (node.dataset.counted) return;
    const found = node.textContent.replace(/[^\d]/g, '');
    const target = Number(found);
    if (!target || target > 5000) return;
    node.dataset.counted = 'true';
    const suffix = node.textContent.replace(/[\d,]+/, '');
    const start = performance.now();
    const animate = (now) => {
      const progress = Math.min((now - start) / 650, 1);
      node.childNodes[0].nodeValue = `${Math.round(target * (1 - Math.pow(1 - progress, 3))).toLocaleString()}${suffix.includes('kg') ? ' kg' : ''}`;
      if (progress < 1) requestAnimationFrame(animate);
    };
    requestAnimationFrame(animate);
  });
  document.querySelectorAll('.progress-track span').forEach((bar) => { bar.style.setProperty('--target-width', bar.style.width || '72%'); });
}

function rememberView(next) {
  history.pushState({ greenDrop: true, stage: next.stage || state.stage, role: next.role || state.role, page: next.page || state.page }, '', location.href);
}

document.addEventListener('click', (event) => {
  const el = event.target.closest('[data-action]');
  if (!el) return;
  const action = el.dataset.action;
  if (action === 'skip-onboarding' || action === 'finish-onboarding') { state.stage = 'roles'; state.onboardingIndex = 0; render(); }
  if (action === 'next-onboarding') { state.onboardingIndex = Math.min((state.onboardingIndex || 0) + 1, 2); render(); }
  if (action === 'toggle-password') { state.passwordVisible = !state.passwordVisible; }
  if (action === 'toggle-theme') { state.dark = !state.dark; render(); }
  if (action === 'open-profile') { state.page = 'profile'; rememberView({ page: 'profile' }); render(); }
  if (action === 'logout-request') { state.modal = 'logout'; render(); }
  if (action === 'confirm-logout') { state.role = null; state.page = 'home'; state.modal = null; state.authMode = 'login'; state.stage = 'roles'; showToast('You have been logged out.'); render(); }
  if (action === 'nav' && el.dataset.page) rememberView({ page: el.dataset.page });
  if (action === 'choose-role') { state.stage = 'roles'; rememberView({ role: el.dataset.role, page: 'auth' }); }
  if (action === 'nav-back') { history.back(); }
}, true);

document.addEventListener('submit', (event) => {
  if (event.target.dataset.form === 'login') rememberView({ page: 'home' });
}, true);

document.addEventListener('keydown', (event) => {
  if (event.key === 'Escape' && state.modal) { state.modal = null; render(); }
});

document.addEventListener('touchstart', (event) => {
  if (state.stage === 'onboarding') window.greenDropTouchStart = event.changedTouches[0].clientX;
}, { passive: true });

document.addEventListener('touchend', (event) => {
  if (state.stage !== 'onboarding' || typeof window.greenDropTouchStart !== 'number') return;
  const distance = event.changedTouches[0].clientX - window.greenDropTouchStart;
  window.greenDropTouchStart = null;
  if (Math.abs(distance) < 46) return;
  if (distance < 0 && (state.onboardingIndex || 0) < 2) state.onboardingIndex += 1;
  if (distance > 0 && (state.onboardingIndex || 0) > 0) state.onboardingIndex -= 1;
  render();
}, { passive: true });

window.addEventListener('popstate', (event) => {
  const view = event.state;
  if (view && view.greenDrop) { state.stage = view.stage || 'roles'; state.role = view.role || null; state.page = view.page || 'home'; state.modal = null; render(); }
  else if (state.page !== 'home') { state.page = 'home'; state.modal = null; render(); }
});
