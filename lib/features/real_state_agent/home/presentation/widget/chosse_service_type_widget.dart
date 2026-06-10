import 'package:flutter/material.dart';

class ChooseServiceTypeWidget extends StatelessWidget {
  // Service item data model
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
        // "Choose Service Type" header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Choose Service Type',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Service grid - 3 columns
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 columns
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemCount: serviceItems.length,
            itemBuilder: (context, index) {
              final item = serviceItems[index];
              return _buildServiceItem(
                context,
                item,
              );
            },
          ),
        ),
      ],
    );
  }

  // Individual service item widget
  Widget _buildServiceItem(BuildContext context, ServiceItem item) {
    return GestureDetector(
      onTap: () {
        // Call the callback if provided
        onServiceSelected?.call(item.title);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade200,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Service icon
            Image.asset(
              item.iconPath,
              width: 48,
              height: 48,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 12),

            // Service title
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// Service item model
class ServiceItem {
  final String title;
  final String iconPath;

  ServiceItem({
    required this.title,
    required this.iconPath,
  });
}