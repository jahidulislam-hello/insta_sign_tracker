import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_sign_tracker/core/routes/app_routes.dart';

class SignInstallationController extends GetxController {
  // TextEditingControllers
  final addressController = TextEditingController();
  final agentNameController = TextEditingController();
  final unitAptController = TextEditingController();
  final listingIdController = TextEditingController();
  final dueDateController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final notesController = TextEditingController();
  final gateCodeController = TextEditingController();
  final signPlacementController = TextEditingController();

  // Observables
  final selectedOrder = ''.obs; // 'asap' or 'rush'
  final selectedPostType = ''.obs;
  final selectedPropertyType = ''.obs;
  final selectedSignPlacement = ''.obs;

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Dropdowns data
  final postTypes = ['Single Install', 'Dual Install', 'Triple Install'];
  final propertyTypes = ['Residential', 'Commercial', 'Industrial'];
  final signPlacements = [
    'Installer\'s choice',
    'I\'ll choose - please specify details in notes'
  ];

  // Date picker function
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // Format date as DD/MM/YYYY
      dueDateController.text =
      '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
    }
  }

  // Next button function
  void goToNextPage() {
    if (formKey.currentState!.validate()) {
     Get.toNamed(AppRoutes.signInstallation2ndScreen);
    }
  }

  // ============ 2nd Screen Related ============

// Image Upload
  final signImagePath = ''.obs;

// Confirm address
  final confirmAddress = ''.obs;

// Location
  final locationController = TextEditingController();

// Site Warning checkboxes
  final undergroundSprinkler = false.obs;
  final undergroundUtility = false.obs;
  final invisibleDogFence = false.obs;

// Add-on Services checkboxes
  final addBrochureBox = false.obs;
  final shoeCovers = false.obs;

// Material Type
  final selectedMaterial = ''.obs;
  final materialTypes = ['Material 1', 'Material 2', 'Material 3'];

// Choose Size
  final selectedSize = ''.obs;
  final sizeTypes = ['Small', 'Medium', 'Large'];

// Riser list
  final risers = <Map<String, String>>[].obs;

// Place Order function
  void placeOrder() {
    Get.toNamed(AppRoutes.reviewOrderScreen,arguments: {
    'address': addressController.text,
    'agentName': agentNameController.text,
    'propertyType': selectedPropertyType.value,
    'postType': selectedPostType.value,
    // অন্য সব data...
    });
  }

  @override
  void onClose() {
    addressController.dispose();
    agentNameController.dispose();
    unitAptController.dispose();
    listingIdController.dispose();
    dueDateController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    notesController.dispose();
    gateCodeController.dispose();
    signPlacementController.dispose();
    locationController.dispose();
    super.onClose();
  }

}