
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'package:latlong2/latlong.dart';

 // <- your file (AppColors / AppText / etc.)

class RoutingScreen extends StatefulWidget {
  const RoutingScreen({super.key});

  @override
  State<RoutingScreen> createState() => _RoutingScreenState();
}

class _RoutingScreenState extends State<RoutingScreen> {
  String _installerFilter = 'All Installer';
  String _sortMode = 'Reorder Route';

  final MapController _mapController = MapController();

  // Marker location taken from the screenshot (Florida, US).
  static const LatLng _pin = LatLng(27.9, -81.9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            _RoutingHeader(
              installerFilter: _installerFilter,
              sortMode: _sortMode,
              onInstallerChanged: (v) => setState(() => _installerFilter = v),
              onSortChanged: (v) => setState(() => _sortMode = v),
              onGenerateRoute: () {
                // TODO: wire up route generation.
              },
            ),
            const Divider(height: 1, thickness: 1, color: AppColors.border),
            Expanded(
              child: _RoutingMap(controller: _mapController, center: _pin),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// HEADER — "Routing" title + filter dropdowns + Generate route button
// ===========================================================================

class _RoutingHeader extends StatelessWidget {
  const _RoutingHeader({
    required this.installerFilter,
    required this.sortMode,
    required this.onInstallerChanged,
    required this.onSortChanged,
    required this.onGenerateRoute,
  });

  final String installerFilter;
  final String sortMode;
  final ValueChanged<String> onInstallerChanged;
  final ValueChanged<String> onSortChanged;
  final VoidCallback onGenerateRoute;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      color: AppColors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Row 1: Title + Generate Route ──
          Row(
            children: [
              Text('Routing', style: AppText.title),
              const Spacer(),
              _GenerateRouteButton(onPressed: onGenerateRoute),
            ],
          ),
          const SizedBox(height: 8),
          // ── Row 2: Filter dropdowns ──
          Row(
            children: [
              Expanded(
                child: _FilterDropdown(
                  value: installerFilter,
                  items: const ['All Installer', 'Team A', 'Team B'],
                  onChanged: onInstallerChanged,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _FilterDropdown(
                  value: sortMode,
                  items: const ['Reorder Route', 'By Distance', 'By Priority'],
                  onChanged: onSortChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  const _FilterDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppColors.radiusSm),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isDense: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 18,
            color: AppColors.textSecondary,
          ),
          style: AppText.body.copyWith(color: AppColors.textPrimary),
          borderRadius: BorderRadius.circular(AppColors.radiusSm),
          items: items
              .map(
                (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e, style: AppText.body),
            ),
          )
              .toList(),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}

class _GenerateRouteButton extends StatelessWidget {
  const _GenerateRouteButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.bolt_rounded, size: 16, color: AppColors.white),
        label: const Text('Generate route'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          textStyle: AppText.body.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppColors.radiusSm),
          ),
        ),
      ),
    );
  }
}

// ===========================================================================
// MAP — OpenStreetMap tiles + a single "home" pin styled like the screenshot
// ===========================================================================

class _RoutingMap extends StatelessWidget {
  const _RoutingMap({required this.controller, required this.center});

  final MapController controller;
  final LatLng center;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: controller,
          options: MapOptions(
            initialCenter: center,
            initialZoom: 3,
            minZoom: 2,
            maxZoom: 18,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: center,
                  width: 40,
                  height: 40,
                  child: const _HomePinMarker(),
                ),
              ],
            ),
          ],
        ),
        // Zoom controls (+ / -) matching the top-left widget in the screenshot.
        Positioned(
          top: 16,
          left: 16,
          child: _ZoomControls(controller: controller),
        ),
      ],
    );
  }
}

/// Circular pin with a split coral/blue ring and a dark "home" glyph,
/// matching the marker in the screenshot.
class _HomePinMarker extends StatelessWidget {
  const _HomePinMarker();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white,
        border: Border.all(color: AppColors.coralRed, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white,
        ),
        child: const Icon(
          Icons.home_rounded,
          size: 18,
          color: AppColors.selectedTabColor,
        ),
      ),
    );
  }
}

class _ZoomControls extends StatelessWidget {
  const _ZoomControls({required this.controller});

  final MapController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppColors.radiusSm),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ZoomButton(
            icon: Icons.add,
            onTap: () {
              final zoom = controller.camera.zoom;
              controller.move(controller.camera.center, zoom + 1);
            },
          ),
          const Divider(height: 1, thickness: 1, color: AppColors.border),
          _ZoomButton(
            icon: Icons.remove,
            onTap: () {
              final zoom = controller.camera.zoom;
              controller.move(controller.camera.center, zoom - 1);
            },
          ),
        ],
      ),
    );
  }
}

class _ZoomButton extends StatelessWidget {
  const _ZoomButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 32,
        height: 32,
        child: Icon(icon, size: 18, color: AppColors.textPrimary),
      ),
    );
  }
}