class Assistant {
  final int sn;
  final String name;
  final String email;
  final String phone;
  final String joinDate;
  final String role;
  final String office;
  final String brokerage;
  final int totalOrders;
  final int totalAgent;
  final int inventoryItems;

  const Assistant({
    required this.sn,
    required this.name,
    required this.email,
    required this.phone,
    required this.joinDate,
    this.role = 'Team Lead',
    this.office = 'Real estate office',
    this.brokerage = 'Brokerage office',
    this.totalOrders = 0,
    this.totalAgent = 0,
    this.inventoryItems = 0,
  });

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  static const List<Assistant> sample = [
    Assistant(
      sn: 1,
      name: 'Sarah Ahmed',
      email: 'sarah@gmail.com',
      phone: '+880171234568',
      joinDate: '02/18/2026',
      totalOrders: 34,
      totalAgent: 6,
      inventoryItems: 80,
    ),
    Assistant(
      sn: 2,
      name: 'Olivia Taylor',
      email: 'olivia@gmail.com',
      phone: '+880171234562',
      joinDate: '02/15/2026',
      totalOrders: 21,
      totalAgent: 4,
      inventoryItems: 55,
    ),
    Assistant(
      sn: 3,
      name: 'Lucas Garcia',
      email: 'lucas@gmail.com',
      phone: '+880171234567',
      joinDate: '02/12/2026',
      totalOrders: 50,
      totalAgent: 10,
      inventoryItems: 100,
    ),
  ];
}
