/// Data models + mock data for the Inventory Management screens.
/// Swap the `mock...` lists for real API/DB data later — the widgets only
/// depend on these model classes, not on where the data came from.

class InventoryItem {
  final String id;
  final String type;
  final String name;
  final int qty;
  final String assignedAgent;
  final String status; // 'In Stock' | 'Out of Stock'
  final String warehouseLocation;
  final String lastUpdated;
  final String unitPrice;
  final String serialNo;
  final String shipment;
  final String shelveNo;
  final String size;
  final String material;
  final String mountType;
  final String additionalSpecs;
  final String notes;

  const InventoryItem({
    required this.id,
    required this.type,
    required this.name,
    required this.qty,
    required this.assignedAgent,
    required this.status,
    this.warehouseLocation = '—',
    this.lastUpdated = '—',
    this.unitPrice = '—',
    this.serialNo = '—',
    this.shipment = '—',
    this.shelveNo = '—',
    this.size = '—',
    this.material = '—',
    this.mountType = '—',
    this.additionalSpecs = '—',
    this.notes = '',
  });
}

final List<InventoryItem> mockInventoryItems = [
  const InventoryItem(
    id: '#7511',
    type: 'Sign post',
    name: 'L-Shape',
    qty: 45,
    assignedAgent: 'Nm Sujon',
    status: 'In Stock',
    size: '24x7',
    material: 'PVC',
    mountType: 'Top Hanging',
    additionalSpecs: 'High visibility',
  ),
  const InventoryItem(
    id: '#7511',
    type: 'Main Panel',
    name: 'L-Shape',
    qty: 8,
    assignedAgent: 'Nm Sujon',
    status: 'In Stock',
    size: '24x7',
    material: 'Aluminum',
    mountType: 'Ground',
    additionalSpecs: 'Weather resistant',
  ),
  const InventoryItem(
    id: '#7511',
    type: 'Rider',
    name: 'L-Shape',
    qty: 10,
    assignedAgent: 'Nm Sujon',
    status: 'In Stock',
    size: '18x6',
    material: 'PVC',
    mountType: 'Top Hanging',
    additionalSpecs: 'High visibility',
  ),
];

class AgentInventoryLine {
  final String name;
  final String category;
  final String location;
  final int qty;
  final String status; // 'In Stock' | 'Out'
  const AgentInventoryLine({
    required this.name,
    required this.category,
    required this.location,
    required this.qty,
    required this.status,
  });
}

class AgentSummary {
  final String name;
  final int itemTypes;
  final int totalUnits;
  final int totalItems;
  final int checkedOut;
  final int totalQty;
  final List<AgentInventoryLine> lines;

  const AgentSummary({
    required this.name,
    required this.itemTypes,
    required this.totalUnits,
    required this.totalItems,
    required this.checkedOut,
    required this.totalQty,
    required this.lines,
  });
}

final List<AgentSummary> mockAgents = List.generate(3, (_) {
  return const AgentSummary(
    name: 'Nm Sujon',
    itemTypes: 5,
    totalUnits: 123,
    totalItems: 5,
    checkedOut: 5,
    totalQty: 5,
    lines: [
      AgentInventoryLine(
        name: 'Sign post',
        category: 'Sign',
        location: 'Warehouse-1',
        qty: 45,
        status: 'In Stock',
      ),
      AgentInventoryLine(
        name: 'Main panel',
        category: 'Panel',
        location: 'Warehouse-1',
        qty: 45,
        status: 'Out',
      ),
    ],
  );
});

class BranchSummary {
  final String name;
  final String manager;
  final String address;
  final int agents;
  final int totalItems;
  final int lowStock;

  const BranchSummary({
    required this.name,
    required this.manager,
    required this.address,
    required this.agents,
    required this.totalItems,
    required this.lowStock,
  });
}

final List<BranchSummary> mockOffices = List.generate(3, (_) {
  return const BranchSummary(
    name: 'North Branch',
    manager: 'Jennifer Williams',
    address: '456 North Ave, Northside',
    agents: 2,
    totalItems: 250,
    lowStock: 2,
  );
});

final List<BranchSummary> mockWarehouses = List.generate(3, (_) {
  return const BranchSummary(
    name: 'Ware house -01',
    manager: 'Jennifer Williams',
    address: '456 North Ave, Northside',
    agents: 2,
    totalItems: 250,
    lowStock: 2,
  );
});

class CategorySummary {
  final String title;
  final int itemTypes;
  final int totalUnits;
  final int inStock;
  final int checkedOut;
  final int lowStock;

  const CategorySummary({
    required this.title,
    required this.itemTypes,
    required this.totalUnits,
    required this.inStock,
    required this.checkedOut,
    required this.lowStock,
  });
}

final List<CategorySummary> mockMyInventory = List.generate(3, (_) {
  return const CategorySummary(
    title: 'Signs',
    itemTypes: 4,
    totalUnits: 200,
    inStock: 100,
    checkedOut: 100,
    lowStock: 100,
  );
});

class ReturnItem {
  final String returnId;
  final String itemName;
  final int qty;
  final String status;
  const ReturnItem({
    required this.returnId,
    required this.itemName,
    required this.qty,
    required this.status,
  });
}

final List<ReturnItem> mockReturns = [];
