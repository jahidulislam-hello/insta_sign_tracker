enum TechnicianRole { installer, photographer }

extension TechnicianRoleX on TechnicianRole {
  String get label =>
      this == TechnicianRole.installer ? 'Installer' : 'Photographer';

  static TechnicianRole fromLabel(String label) =>
      label == 'Installer' ? TechnicianRole.installer : TechnicianRole.photographer;
}

class TimeOffEntry {
  final String title;
  final String dateRange;
  final String status; // Approved / Pending
  final bool isVacationType;

  TimeOffEntry({
    required this.title,
    required this.dateRange,
    required this.status,
    this.isVacationType = true,
  });
}

class Technician {
  final String id;
  String name;
  String email;
  String phone;
  String address;
  TechnicianRole role;

  // Extended profile info shown on the detail screen.
  bool isActive;
  bool isAdmin;
  String lastLogin;
  String userSince;
  String slackIntegrationStatus;
  String calendarIntegrationStatus;
  String launchLocationStatus;
  List<String> allowedServiceCategories;
  List<String> allowedEntryMethods;
  List<TimeOffEntry> timeOff;

  Technician({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.role,
    this.isActive = true,
    this.isAdmin = false,
    this.lastLogin = 'Monday, June 08, 2026',
    this.userSince = 'Monday, September 02, 2024',
    this.slackIntegrationStatus = 'Pending',
    this.calendarIntegrationStatus = 'Completed',
    this.launchLocationStatus = 'Added',
    List<String>? allowedServiceCategories,
    List<String>? allowedEntryMethods,
    List<TimeOffEntry>? timeOff,
  })  : allowedServiceCategories =
            allowedServiceCategories ?? ['3D', 'Drone', 'Editing Only', 'Floor Plan', 'Other', 'Photo', 'Video'],
        allowedEntryMethods = allowedEntryMethods ?? ['Lockbox', 'Owner Entry', 'SentriLock'],
        timeOff = timeOff ??
            [
              TimeOffEntry(title: 'Vacation', dateRange: 'Aug 15, 2026 - Aug 20, 2026', status: 'APPROVED'),
              TimeOffEntry(title: 'Medical', dateRange: 'Sep 01, 2026 - Sep 02, 2026', status: 'PENDING', isVacationType: false),
            ];
}
