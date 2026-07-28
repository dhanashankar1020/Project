import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/safe_place_model.dart';
import '../services/safe_places_service.dart';
import '../screens/safe_place_detail_screen.dart';
import '../../../services/location_service.dart';

class SafePlacesMapView extends StatefulWidget {
  final SafePlacesService service;

  const SafePlacesMapView({super.key, required this.service});

  @override
  State<SafePlacesMapView> createState() => _SafePlacesMapViewState();
}

class _SafePlacesMapViewState extends State<SafePlacesMapView> {
  late List<SafePlaceModel> _places;
  String _selectedCategory = 'All';
  final MapController _mapController = MapController();
  LatLng? _userLocation;

  // Center coordinates for Delhi NCR fallback
  static const double _defaultLat = 28.6139;
  static const double _defaultLng = 77.2090;
  static const double _defaultZoom = 11.0;

  @override
  void initState() {
    super.initState();
    _places = widget.service.getAllPlaces();
    _initUserLocation();
  }

  Future<void> _initUserLocation() async {
    try {
      final pos = await LocationService.getCurrentLocation();
      if (!mounted) return;

      if (pos != null) {
        final userLatLng = LatLng(pos.latitude, pos.longitude);
        setState(() {
          _userLocation = userLatLng;
        });
        _mapController.move(userLatLng, 13.0);
        final realPlaces = await widget.service.fetchRealTimeNearbyPlaces(
          lat: pos.latitude,
          lng: pos.longitude,
          category: _selectedCategory,
        );
        if (mounted && realPlaces.isNotEmpty) {
          setState(() {
            _places = realPlaces;
          });
        }
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _places = widget.service.getPlacesByCategory(_selectedCategory);
        });
      }
    }
  }

  /// Opens Google Maps directions with a geo URI fallback
  Future<void> _openDirectionsForPlace(SafePlaceModel place) async {
    final lat = place.latitude;
    final lng = place.longitude;
    final googleMapsUri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving',
    );
    final geoUri = Uri.parse(
      'geo:0,0?q=$lat,$lng(${Uri.encodeComponent(place.name)})',
    );

    try {
      final launched = await launchUrl(
        googleMapsUri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        await launchUrl(geoUri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open maps. Please install Google Maps.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  void _filterByCategory(String category) {
    setState(() {
      _selectedCategory = category;
      if (category == 'All') {
        _places = widget.service.getAllPlaces();
      } else {
        _places = widget.service.getPlacesByCategory(category);
      }
    });

    if (_places.isNotEmpty) {
      _fitMarkers();
    }
  }

  void _fitMarkers() {
    if (_places.isEmpty) return;

    double minLat = _places.first.latitude;
    double maxLat = _places.first.latitude;
    double minLng = _places.first.longitude;
    double maxLng = _places.first.longitude;

    for (final place in _places) {
      if (place.latitude < minLat) minLat = place.latitude;
      if (place.latitude > maxLat) maxLat = place.latitude;
      if (place.longitude < minLng) minLng = place.longitude;
      if (place.longitude > maxLng) maxLng = place.longitude;
    }

    final center = LatLng(
      (minLat + maxLat) / 2,
      (minLng + maxLng) / 2,
    );

    final latDiff = (maxLat - minLat).abs();
    final lngDiff = (maxLng - minLng).abs();
    final maxDiff = latDiff > lngDiff ? latDiff : lngDiff;

    double zoom = 12.0;
    if (maxDiff > 0.1) {
      zoom = 10.0;
    } else if (maxDiff > 0.05) {
      zoom = 11.0;
    } else if (maxDiff > 0.02) {
      zoom = 12.0;
    } else {
      zoom = 13.0;
    }

    _mapController.move(center, zoom);
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Hospital':
        return Colors.red;
      case 'Shelter':
        return Colors.green;
      case 'Police Station':
        return Colors.blue;
      case 'Fire Station':
        return Colors.orange;
      case 'Relief Center':
        return Colors.purple;
      default:
        return Colors.indigo;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Hospital':
        return Icons.local_hospital;
      case 'Shelter':
        return Icons.home;
      case 'Police Station':
        return Icons.local_police;
      case 'Fire Station':
        return Icons.local_fire_department;
      case 'Relief Center':
        return Icons.volunteer_activism;
      default:
        return Icons.location_on;
    }
  }

  void _showPlaceDetails(BuildContext context, SafePlaceModel place) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return _PlaceBottomSheet(
          place: place,
          color: _getCategoryColor(place.category),
          icon: _getCategoryIcon(place.category),
          onViewDetails: () {
            Navigator.pop(sheetContext);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SafePlaceDetailScreen(place: place),
              ),
            );
          },
          onGetDirections: () {
            Navigator.pop(sheetContext);
            _openDirectionsForPlace(place);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      'All',
      'Hospital',
      'Shelter',
      'Police Station',
      'Fire Station',
      'Relief Center',
    ];

    return Column(
      children: [
        // Category filter chips
        Container(
          height: 48,
          margin: const EdgeInsets.only(top: 8),
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: categories.map((category) {
              final isSelected = _selectedCategory == category;
              final color = category == 'All'
                  ? Colors.indigo
                  : _getCategoryColor(category);
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.white : color,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: color,
                  backgroundColor: Colors.white,
                  checkmarkColor: Colors.white,
                  showCheckmark: false,
                  side: BorderSide(color: color, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onSelected: (_) => _filterByCategory(category),
                ),
              );
            }).toList(),
          ),
        ),

        // Place count and fit controls
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Row(
            children: [
              Icon(Icons.location_on, size: 16, color: Colors.indigo.shade300),
              const SizedBox(width: 6),
              Text(
                _places.isEmpty
                    ? 'No places found'
                    : '${_places.length} place${_places.length == 1 ? '' : 's'} on map',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),
              if (_places.isNotEmpty) ...[
                const Spacer(),
                GestureDetector(
                  onTap: _fitMarkers,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.zoom_out_map,
                          size: 14,
                          color: Colors.indigo.shade400,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Fit all',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.indigo.shade400,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),

        // Map area
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: const LatLng(_defaultLat, _defaultLng),
                    initialZoom: _defaultZoom,
                    minZoom: 5,
                    maxZoom: 18,
                    interactionOptions: const InteractionOptions(
                      flags: InteractiveFlag.all,
                    ),
                    onTap: (_, _) {},
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c', 'd'],
                      userAgentPackageName:
                          'com.shankar2.offline_disaster_helper',
                      maxZoom: 19,
                    ),
                    MarkerLayer(
                      markers: [
                        if (_userLocation != null)
                          Marker(
                            point: _userLocation!,
                            width: 44,
                            height: 44,
                            child: Tooltip(
                              message: 'Your Current Location',
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue.withValues(alpha: 0.25),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Container(
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 3),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.blue.withValues(alpha: 0.5),
                                          blurRadius: 8,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.my_location,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ..._places.map((place) {
                          final color = _getCategoryColor(place.category);
                          return Marker(
                            point: LatLng(place.latitude, place.longitude),
                            width: 40,
                            height: 40,
                            child: GestureDetector(
                              onTap: () => _showPlaceDetails(context, place),
                              behavior: HitTestBehavior.opaque,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: color.withValues(alpha: 0.15),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          color: color,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2.5,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withValues(alpha: 0.2),
                                              blurRadius: 6,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          _getCategoryIcon(place.category),
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),

                    // Empty state overlay
                    if (_places.isEmpty)
                      Positioned.fill(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.search_off_rounded,
                                size: 56,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'No places found',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Try selecting a different category',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextButton.icon(
                                onPressed: () => _filterByCategory('All'),
                                icon: const Icon(Icons.refresh, size: 18),
                                label: const Text('Show all places'),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),

                // Attribution label
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '© OpenStreetMap contributors',
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Legend bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 28,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _LegendItem(color: Colors.red, label: 'Hospital'),
                  const SizedBox(width: 12),
                  _LegendItem(color: Colors.green, label: 'Shelter'),
                  const SizedBox(width: 12),
                  _LegendItem(color: Colors.blue, label: 'Police'),
                  const SizedBox(width: 12),
                  _LegendItem(color: Colors.orange, label: 'Fire'),
                  const SizedBox(width: 12),
                  _LegendItem(color: Colors.purple, label: 'Relief'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _PlaceBottomSheet extends StatelessWidget {
  final SafePlaceModel place;
  final Color color;
  final IconData icon;
  final VoidCallback onViewDetails;
  final VoidCallback onGetDirections;

  const _PlaceBottomSheet({
    required this.place,
    required this.color,
    required this.icon,
    required this.onViewDetails,
    required this.onGetDirections,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),

          // Header with icon
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: color.withValues(alpha: 0.15),
                child: Icon(icon, color: color, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            place.category,
                            style: TextStyle(
                              fontSize: 11,
                              color: color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: place.isOpen24Hours
                              ? Colors.green
                              : Colors.orange,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          place.isOpen24Hours ? '24/7' : 'Limited',
                          style: TextStyle(
                            fontSize: 11,
                            color: place.isOpen24Hours
                                ? Colors.green
                                : Colors.orange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Address
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: Colors.grey.shade500),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  place.address,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Contact
          Row(
            children: [
              Icon(Icons.phone, size: 16, color: Colors.grey.shade500),
              const SizedBox(width: 8),
              Text(
                place.contactNumber,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Description
          Text(
            place.description,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 18),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onViewDetails,
                  icon: const Icon(Icons.info_outline, size: 18),
                  label: const Text('Details'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.indigo,
                    side: BorderSide(color: Colors.indigo.shade200),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onGetDirections,
                  icon: const Icon(Icons.directions, size: 18),
                  label: const Text('Directions'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
