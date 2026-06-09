import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../data/model/role_data.dart';
import '../controller/auth_controller.dart';

class SelectRole extends GetView<AuthController> {
  const SelectRole({super.key});

  @override
  Widget build(BuildContext context) {
    // Local state - screen এ manage করবো
    final selectedRole = Rxn<String>();
    final isRoleSelected = false.obs;

    final List<RoleData> roles = [
      RoleData(
        id: '1',
        title: 'Team Lead',
        description: 'Lead and manage teams',
        icon: '👥',
      ),
      RoleData(
        id: '2',
        title: 'Warehouse Manager',
        description: 'Manage inventory and storage',
        icon: '🏢',
      ),
      RoleData(
        id: '3',
        title: 'Real Estate Agent',
        description: 'Sell and manage properties',
        icon: '🏠',
      ),
      RoleData(
        id: '4',
        title: 'Agent Assistant',
        description: 'Support and assist agents',
        icon: '👔',
      ),
      RoleData(
        id: '5',
        title: 'Agent Technician',
        description: 'Field support maintenance',
        icon: '🔧',
      ),
      RoleData(
        id: '6',
        title: 'Sign Company',
        description: 'Signage and branding service',
        icon: '🪧',
      ),
      RoleData(
        id: '7',
        title: 'Main Admin',
        description: 'System administrator',
        icon: '🛡️',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Select Your Role',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
          children: [
            Container(
              height: 50.h,
              width:double.infinity,
                color:Colors.blue,
                child:Center(
                  child: Text(
                    'Choose your workspace profile to continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
            ),
      // Roles list - সরাসরি শুরু
      Expanded(
      child: ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      itemCount: roles.length,
      itemBuilder: (context, index) {
        final role = roles[index];
        return Obx(() {
          final isSelected = selectedRole.value == role.title;
          return Padding(
            padding: EdgeInsets.only(bottom: 15.h),
            child: GestureDetector(
              onTap: () {
                // Role select করলো
                selectedRole.value = role.title;
                isRoleSelected.value = true;
                // Controller এ store করছি
                controller.setSelectedRole(role.title);
                print('Selected: ${role.title}');
              },
              child: _buildRoleCard(role, isSelected),
            ),
          );
        });
      },
    ),
    ),

    // Continue button
    Padding(
    padding: EdgeInsets.all(20.w),
    child: Obx(() {
    return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
    onPressed: isRoleSelected.value
    ? () {
    print('Going to sign up with role: ${selectedRole.value}');
    Get.toNamed('/signup');
    }
        : null,
    style: ElevatedButton.styleFrom(
    backgroundColor: isRoleSelected.value
    ? Colors.blue
        : Colors.grey[300],
    disabledBackgroundColor: Colors.grey[300],
    padding: EdgeInsets.symmetric(vertical: 15.h),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.r),
    ),
    ),
    child: Text(
    'Continue to sign-up',
    style: TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: isRoleSelected.value
    ? Colors.white
        : Colors.grey,
    ),
    ),
    )
    );
  }),
  ),
  ],
  ),
  );
}

// Role card widget
Widget _buildRoleCard(RoleData role, bool isSelected) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: isSelected ? Colors.blue : Colors.grey[300]!,
        width: isSelected ? 2 : 1,
      ),
      borderRadius: BorderRadius.circular(12.r),
      color: isSelected ? Colors.blue.withOpacity(0.05) : Colors.white,
    ),
    padding: EdgeInsets.all(15.w),
    child: Row(
      children: [
        // Icon
        Container(
          height: 50.h,
          width: 50.w,
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.grey[200],
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Center(
            child: Text(
              role.icon,
              style: TextStyle(fontSize: 28.sp),
            ),
          ),
        ),

        SizedBox(width: 15.w),

        // Title and description
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                role.title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                role.description,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: 10.w),

        // Checkmark
        if (isSelected)
          Container(
            height: 28.h,
            width: 28.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 18.sp,
            ),
          )
        else
          Container(
            height: 28.h,
            width: 28.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[300]!, width: 2),
            ),
          ),
      ],
    ),
  );
}
}