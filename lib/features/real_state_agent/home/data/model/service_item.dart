import 'package:flutter/foundation.dart';

class ServiceItem {
  final String title;
  final String iconPath;
  final VoidCallback goNextPage;

  ServiceItem({
    required this.title,
    required this.iconPath,
    required this.goNextPage
  });
}