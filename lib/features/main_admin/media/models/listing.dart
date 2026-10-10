import 'package:flutter/material.dart';

class Listing {
  final String address;
  final String? thumbnailPath;
  final bool rushed;
  final double listingPrice;
  final String dateShot;
  final String shotBy;
  final String agentClient;
  final String agentInitials;
  final Color agentColor;
  final bool sentStatus;
  final bool paidStatus;
  final String tasks;

  const Listing({
    required this.address,
    this.thumbnailPath,
    this.rushed = false,
    required this.listingPrice,
    required this.dateShot,
    required this.shotBy,
    required this.agentClient,
    required this.agentInitials,
    required this.agentColor,
    this.sentStatus = true,
    this.paidStatus = true,
    this.tasks = 'N/A',
  });

  String get formattedPrice {
    final s = listingPrice.toStringAsFixed(2);
    final parts = s.split('.');
    final whole = parts[0];
    final buffer = StringBuffer();
    for (int i = 0; i < whole.length; i++) {
      final posFromEnd = whole.length - i;
      buffer.write(whole[i]);
      if (posFromEnd > 1 && posFromEnd % 3 == 1) buffer.write(',');
    }
    return '\$$buffer.${parts[1]}';
  }
}
