import 'dart:typed_data';
import 'package:flutter/material.dart';



class EntryMethod {
  String name;
  String description;
  IconData icon;
  Uint8List? iconBytes;

  EntryMethod({
    required this.name,
    required this.description,
    this.icon = Icons.vpn_key_outlined,
    this.iconBytes,
  });
}

class EntryMethodsPage extends StatefulWidget {
  const EntryMethodsPage({super.key});

  @override
  State<EntryMethodsPage> createState() => _EntryMethodsPageState();
}

class _EntryMethodsPageState extends State<EntryMethodsPage> {
  final List<EntryMethod> _methods = [
    EntryMethod(
      name: 'Lockbox',
      description: 'Standard lockbox with combo code',
      icon: Icons.vpn_key_outlined,
    ),
    EntryMethod(
      name: 'Owner Entry',
      description: 'Homeowner will grant access',
      icon: Icons.location_on_outlined,
    ),
    EntryMethod(
      name: 'SentriLock',
      description: 'Electronic bluetooth lockbox',
      icon: Icons.vpn_key_outlined,
    ),
  ];

  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  List<EntryMethod> get _filtered => _query.isEmpty
      ? _methods
      : _methods
      .where((m) =>
  m.name.toLowerCase().contains(_query.toLowerCase()) ||
      m.description.toLowerCase().contains(_query.toLowerCase()))
      .toList();

  Future<void> _openAddDialog() async {
    final result = await showDialog<EntryMethod>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => const EntryMethodDialog(isEdit: false),
    );
    if (result != null) {
      setState(() => _methods.add(result));
    }
  }

  Future<void> _openEditDialog(EntryMethod method) async {
    final result = await showDialog<EntryMethod>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => EntryMethodDialog(isEdit: true, existing: method),
    );
    if (result != null) {
      setState(() {
        method.name = result.name;
        method.description = result.description;
        method.iconBytes = result.iconBytes;
      });
    }
  }

  void _deleteMethod(EntryMethod method) {
    setState(() => _methods.remove(method));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSearchBar(),
                      const SizedBox(height: 16),
                      Expanded(
                        child: _filtered.isEmpty
                            ? const Center(
                          child: Text(
                            'No entry methods found',
                            style: TextStyle(color: Color(0xFF9CA3AF)),
                          ),
                        )
                            : ListView.separated(
                          itemCount: _filtered.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            return _buildRow(_filtered[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Entry Methods',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2937),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Manage property access options available to agents and technicians',
                style: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
              ),
            ],
          ),
        ),
        ElevatedButton.icon(
          onPressed: _openAddDialog,
          icon: const Icon(Icons.add, size: 18, color: Colors.white),
          label: const Text(
            'Add Entry Method',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2F9BFF),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return SizedBox(
      width: 320,
      height: 42,
      child: TextField(
        controller: _searchController,
        onChanged: (v) => setState(() => _query = v),
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Search entry methods...',
          hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
          prefixIcon: const Icon(Icons.search, size: 20, color: Color(0xFF9CA3AF)),
          filled: true,
          fillColor: const Color(0xFFF7F8FA),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF2F9BFF)),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(EntryMethod method) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEFF0F2)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F0FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: method.iconBytes != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.memory(method.iconBytes!, fit: BoxFit.cover),
            )
                : Icon(method.icon, size: 20, color: const Color(0xFF2F9BFF)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  method.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  method.description,
                  style: const TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => _openEditDialog(method),
            borderRadius: BorderRadius.circular(4),
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(Icons.edit_outlined, size: 18, color: Color(0xFF9CA3AF)),
            ),
          ),
          const SizedBox(width: 4),
          InkWell(
            onTap: () => _deleteMethod(method),
            borderRadius: BorderRadius.circular(4),
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(Icons.delete_outline, size: 18, color: Color(0xFF9CA3AF)),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================================================================
// Add / Edit Entry Method Dialog (shared widget, driven by isEdit)
// ==================================================================

class EntryMethodDialog extends StatefulWidget {
  final bool isEdit;
  final EntryMethod? existing;

  const EntryMethodDialog({super.key, required this.isEdit, this.existing});

  @override
  State<EntryMethodDialog> createState() => _EntryMethodDialogState();
}

class _EntryMethodDialogState extends State<EntryMethodDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _descController;
  Uint8List? _iconBytes;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.existing?.name ?? '');
    _descController = TextEditingController(text: widget.existing?.description ?? '');
    _iconBytes = widget.existing?.iconBytes;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  // Placeholder for actual file picking (image_picker / file_picker package).
  Future<void> _pickIcon() async {
    // Integrate file_picker or image_picker here to set _iconBytes.
    // Left as a stub since no image-picking package is wired up in this snippet.
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isEdit ? 'Edit Entry Method' : 'Add Entry Method';
    final actionLabel = widget.isEdit ? 'Update' : 'Add';

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close, size: 20, color: Color(0xFF6B7280)),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Name field
            const Text(
              'Name',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              autofocus: true,
              style: const TextStyle(fontSize: 14),
              decoration: _fieldDecoration('e.g. Lockbox'),
            ),
            const SizedBox(height: 18),

            // Description field
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descController,
              style: const TextStyle(fontSize: 14),
              decoration: _fieldDecoration('e.g. Standard lockbox with combo code'),
            ),
            const SizedBox(height: 18),

            // Icon upload
            const Text(
              'Icon Image (Optional)',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: _pickIcon,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: double.infinity,
                height: 110,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFD5D8DD),
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                child: _iconBytes != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(_iconBytes!, fit: BoxFit.contain),
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x14000000),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.file_upload_outlined,
                          size: 18, color: Color(0xFF6B7280)),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Upload icon',
                      style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF2F9BFF),
                      side: const BorderSide(color: Color(0xFFE5E7EB)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Close',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_nameController.text.trim().isEmpty) return;
                      Navigator.of(context).pop(
                        EntryMethod(
                          name: _nameController.text.trim(),
                          description: _descController.text.trim(),
                          icon: widget.existing?.icon ?? Icons.vpn_key_outlined,
                          iconBytes: _iconBytes,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F9BFF),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(actionLabel,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFFB0B4BA), fontSize: 14),
      filled: true,
      fillColor: const Color(0xFFF7F8FA),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF2F9BFF)),
      ),
    );
  }
}