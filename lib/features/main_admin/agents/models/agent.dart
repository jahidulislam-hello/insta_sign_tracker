class Agent {
  final int sn;
  final String name;
  final String email;
  final String phone;
  final String joinDate;
  final String brokerage;
  final String? tag;
  final String? lastContactDate;
  final String? nextContactDate;
  final String contactNote;
  final bool hasLocationPin;

  const Agent({
    required this.sn,
    required this.name,
    required this.email,
    required this.phone,
    required this.joinDate,
    required this.brokerage,
    this.tag,
    this.lastContactDate,
    this.nextContactDate,
    this.contactNote = '',
    this.hasLocationPin = false,
  });

  static const List<Agent> sample = [
    Agent(
      sn: 1,
      name: "Todd's Company",
      email: 'todd@gmail.com',
      phone: '+8564564654',
      joinDate: '02/20/2026',
      brokerage: 'Coldwell Banker',
      lastContactDate: 'Dec 3, 2025',
      nextContactDate: 'Dec 17, 2025',
      contactNote:
          'Bob said he would introduce me to the broker, call back in a week to check in for an introduction',
    ),
    Agent(
      sn: 2,
      name: 'Unknown Agent',
      email: 'unknown1@gmail.com',
      phone: '+8564564654',
      joinDate: '02/20/2026',
      brokerage: 'None',
      lastContactDate: 'Dec 9, 2025',
      nextContactDate: 'Dec 16, 2025',
      contactNote:
          'Alexander commented on our post on FB with a cinematic reel - touch back',
    ),
    Agent(
      sn: 3,
      name: 'Coldwell Banker',
      email: 'coldwell@gmail.com',
      phone: '+8564564654',
      joinDate: '02/20/2026',
      brokerage: 'Coldwell Banker',
      lastContactDate: 'Dec 15, 2025',
      nextContactDate: 'Dec 16, 2025',
      contactNote: 'Agent needs to place an order for a house just listed',
    ),
    Agent(
      sn: 4,
      name: 'Unknown Agent 2',
      email: 'unknown2@gmail.com',
      phone: '+8564564654',
      joinDate: '02/20/2026',
      brokerage: 'None',
      tag: 'New Client',
      lastContactDate: 'Nov 18, 2025',
      nextContactDate: 'Dec 15, 2025',
      contactNote:
          'Agent interested in being on camera for their next listing. They anticipate a listing in 2 weeks. ...',
    ),
    Agent(
      sn: 5,
      name: 'New Company',
      email: 'new@gmail.com',
      phone: '+8564564654',
      joinDate: '02/20/2026',
      brokerage: 'RE/MAX',
      tag: 'New Client',
      hasLocationPin: true,
    ),
    Agent(
      sn: 6,
      name: 'Lovie Test Compar',
      email: 'lovie@gmail.com',
      phone: '+880171234567',
      joinDate: '02/19/2026',
      brokerage: 'Keller Williams',
    ),
    Agent(
      sn: 7,
      name: 'My Real Estate Cor',
      email: 'emma@gmail.com',
      phone: '+880171234561',
      joinDate: '02/16/2026',
      brokerage: 'RE/MAX',
      tag: 'New Client',
      hasLocationPin: true,
    ),
    Agent(
      sn: 8,
      name: 'Sophia Lee',
      email: 'sophia@gmail.com',
      phone: '+880171234565',
      joinDate: '02/13/2026',
      brokerage: 'RE/MAX',
      hasLocationPin: true,
    ),
    Agent(
      sn: 9,
      name: 'Mia Rodriguez',
      email: 'mia@gmail.com',
      phone: '+880171234568',
      joinDate: '02/11/2026',
      brokerage: 'None',
    ),
  ];
}
