import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../../../../../core/utils/widget/customeTextField/custom_text_field.dart';
import '../../../home/presentation/widget/app_drawer_widget.dart';
import '../controller/invoice_controller.dart';

class AssistantManagementScreen extends GetView<InvoiceController> {
  const AssistantManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingColor,
      drawer:const AppDrawerWidget(),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // ===== SEARCH SECTION =====
          _buildSearchSection(),

          // ===== ASSISTANT LIST =====
          Expanded(
            child: _buildAssistantList(),
          ),
        ],
      ),
      floatingActionButton: _buildAddAssistantButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // ===================== AppBar =====================
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primaryBlue,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: const Text(
        'Assistant Management',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none, color: Colors.white),
        ),
      ],
    );
  }

  // ===================== SEARCH SECTION =====================
  Widget _buildSearchSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryBlue,
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: CustomTextField(
        controller: controller.invoiceSearch,
        hintText: "Search invoice or order ID....",
        prefixIcon: const Icon(Icons.search),
      ),
    );
  }


  // ===================== ASSISTANT LIST =====================
  Widget _buildAssistantList() {
    final assistants = [
      {
        'name': 'John Doe',
        'email': 'john.doe@example.com',
        'initials': 'JD',
        'color': const Color(0xFF2196F3),
        'tags': <String>[],
      },
      {
        'name': 'Alice Smith',
        'email': 'alice.smith@example.com',
        'initials': 'AS',
        'color': const Color(0xFFC5CAE9),
        'tags': <String>[],
      },
      {
        'name': 'Alice Smith',
        'email': 'alice.smith@example.com',
        'initials': 'AS',
        'color': const Color(0xFFC5CAE9),
        'tags': <String>[],
      },
      {
        'name': 'Robert Wilson',
        'email': 'robert.w@example.com',
        'initials': 'RW',
        'color': const Color(0xFF00BCD4),
        'tags': ['Admin Zone', 'Lead Management'],
      },
      {
        'name': 'Robert Wilson',
        'email': 'robert.w@example.com',
        'initials': 'RW',
        'color': const Color(0xFF00BCD4),
        'tags': <String>[],
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'All Assistants',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Total: ${assistants.length}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // List
          Expanded(
            child: ListView.builder(
              itemCount: assistants.length,
              itemBuilder: (context, index) {
                final assistant = assistants[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: _buildAssistantCard(
                    name: assistant['name'] as String,
                    email: assistant['email'] as String,
                    initials: assistant['initials'] as String,
                    color: assistant['color'] as Color,
                    tags: assistant['tags'] as List<String>,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ===== ASSISTANT CARD =====
  Widget _buildAssistantCard({
    required String name,
    required String email,
    required String initials,
    required Color color,
    required List<String> tags,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 27,
                backgroundColor: color,
                child: Text(
                  initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Name and Email
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              // Delete Button
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete_outline, color: Color(0xFFD32F2F), size: 24),
              ),
            ],
          ),

          // Tags
          if (tags.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                children: tags.map((tag) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  // ===================== ADD ASSISTANT BUTTON =====================
  Widget _buildAddAssistantButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () => _showAddAssistantDialog(),
          icon: const Icon(Icons.person_add_alt_outlined, color: Colors.white),
          label: const Text(
            'Add New Assistant',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  // ===================== ADD ASSISTANT DIALOG =====================
  void _showAddAssistantDialog() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    showDialog(
      context: Get.context!,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          color: AppColors.onboardingColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== HEADER =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add Assistant',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ===== NAME FIELD =====
              CustomTextField(
                controller:nameController,
                hintText: "e.g John Doew",
                labelText: "Name",
              ),
              const SizedBox(height: 16),

              // ===== EMAIL FIELD =====
              CustomTextField(
                controller:emailController,
                hintText: "Type here",
                labelText: "Email",
                isEmail: true,
              ),
              const SizedBox(height: 16),

              // ===== PASSWORD FIELD =====
              CustomTextField(
                controller:passwordController,
                hintText: "*******",
                labelText: "Password",
                isPassword: true,
              ),
              const SizedBox(height: 16),

              // ===== USER TYPE FIELD =====
              CustomTextField(
                controller:nameController,
                hintText: "assistant",
                labelText: "User type",
              ),
              const SizedBox(height: 24),

              // ===== BUTTONS =====
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Close',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Later implement add assistant logic
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}