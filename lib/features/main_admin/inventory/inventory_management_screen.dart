import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'models.dart';
import 'widgets/common.dart';
import 'widgets/add_item_dialog.dart';
import 'widgets/item_details_dialog.dart';
import 'widgets/new_item_dialog.dart';
import 'tabs/table_view_tab.dart';
import 'tabs/agent_tab.dart';
import 'tabs/office_warehouse_tab.dart';
import 'tabs/my_inventory_tab.dart';
import 'tabs/returns_tab.dart';

const _sectionTabs = [
  'Table View',
  'Agent',
  'Office',
  'Warehouse',
  'My Inventory',
  'Returns',
];

class InventoryManagementScreen extends StatefulWidget {
  const InventoryManagementScreen({super.key});

  @override
  State<InventoryManagementScreen> createState() =>
      _InventoryManagementScreenState();
}

class _InventoryManagementScreenState
    extends State<InventoryManagementScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(
                selectedTab: selectedTab,
                onAddPressed: () => selectedTab == 5
                    ? NewItemDialog.show(context)
                    : AddItemDialog.show(context),
              ),
              const SizedBox(height: 20),
              SectionTabBar(
                tabs: _sectionTabs,
                selectedIndex: selectedTab,
                onChanged: (i) => setState(() => selectedTab = i),
              ),
              const SizedBox(height: 16),
              _buildTabContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return TableViewTab(
          items: mockInventoryItems,
          onView: (item) => ItemDetailsDialog.show(context, item),
        );
      case 1:
        return AgentTab(agents: mockAgents);
      case 2:
        return OfficeWarehouseTab(
          branches: mockOffices,
          firstExpanded: true,
        );
      case 3:
        return OfficeWarehouseTab(
          branches: mockWarehouses,
          firstExpanded: false,
        );
      case 4:
        return MyInventoryTab(categories: mockMyInventory);
      case 5:
        return ReturnsTab(
          returns: mockReturns,
          onNewItem: () => NewItemDialog.show(context),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

/// Page header (title + subtitle + action buttons). Wrapped in a
/// LayoutBuilder so on narrow screens the buttons drop below the title
/// instead of squeezing the title's Expanded column down to ~0px — that
/// squeeze is what was making "Inventory Management" wrap one letter per
/// line.
class _Header extends StatelessWidget {
  final int selectedTab;
  final VoidCallback onAddPressed;
  const _Header({required this.selectedTab, required this.onAddPressed});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 640;

        final titleBlock = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Inventory Management', style: AppText.h1),
            const SizedBox(height: 2),
            Text('Track and manage all inventory items',
                style: AppText.pageSubtitle),
          ],
        );

        final buttons = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SecondaryButton(
              label: 'Import',
              icon: Icons.upload_outlined,
              onPressed: () {},
            ),
            const SizedBox(width: 10),
            SecondaryButton(
              label: 'Export',
              icon: Icons.download_outlined,
              onPressed: () {},
            ),
            const SizedBox(width: 10),
            PrimaryButton(
              label: selectedTab == 5 ? 'New Item' : 'Add Item',
              icon: Icons.add,
              onPressed: onAddPressed,
            ),
          ],
        );

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleBlock,
              const SizedBox(height: 14),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: buttons,
              ),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: titleBlock),
            buttons,
          ],
        );
      },
    );
  }
}