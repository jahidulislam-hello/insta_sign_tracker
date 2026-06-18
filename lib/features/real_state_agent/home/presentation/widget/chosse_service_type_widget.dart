import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../../data/model/service_item.dart';

class ChooseServiceTypeWidget extends StatelessWidget {
  final List<ServiceItem> serviceItems;
  final Function(String serviceType)? onServiceSelected;

  const ChooseServiceTypeWidget({
    Key? key,
    required this.serviceItems,
    this.onServiceSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ===== Header =====
        Text(
          'Choose Service Type',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 16),

        // ===== Service Grid =====
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.85,
          ),
          itemCount: serviceItems.length,
          itemBuilder: (context, index) {
            final item = serviceItems[index];
            return _buildServiceItem(context, item);
          },
        ),
      ],
    );
  }

  // ===== Service Item Widget =====
  Widget _buildServiceItem(BuildContext context, ServiceItem item) {
    return GestureDetector(
      onTap:(){
        onServiceSelected?.call(item.title);
        item.goNextPage();
      },
      child: Container(
        decoration: BoxDecoration(
          color:AppColors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ===== Icon =====
            CircleAvatar(
              radius: 35,
              backgroundColor: AppColors.white,
              child: Image.asset(
                item.iconPath,
                width: 44,
                height: 44,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.image_not_supported,
                      size: 44, color: Colors.grey.shade400);
                },
              ),
            ),
            const SizedBox(height: 10),

            // ===== Title =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}