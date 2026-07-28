import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/safe_place_model.dart';
import '../widgets/info_tile.dart';

class SafePlaceDetailScreen extends StatelessWidget {
  final SafePlaceModel place;

  const SafePlaceDetailScreen({super.key, required this.place});

  Future<void> _openGoogleMapsDirections(BuildContext context) async {
    final lat = place.latitude;
    final lng = place.longitude;

    // Build Google Maps navigation URL
    // Use https: scheme which opens Google Maps in browser or app
    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving',
    );

    // Fallback to Google Maps app intent if available
    final appUri = Uri.parse(
      'geo:0,0?q=$lat,$lng(${Uri.encodeComponent(place.name)})',
    );

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        // Fallback to geo URI
        await launchUrl(
          appUri,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open maps: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text(place.name),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 45,
              backgroundColor: _getColor(
                place.category,
              ).withValues(alpha: 0.15),
              child: Icon(
                _getIcon(place.category),
                color: _getColor(place.category),
                size: 50,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              place.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              place.category,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
            ),

            const SizedBox(height: 25),

            InfoTile(
              icon: Icons.location_on,
              title: "Address",
              value: place.address,
              color: Colors.red,
            ),

            InfoTile(
              icon: Icons.phone,
              title: "Contact Number",
              value: place.contactNumber,
              color: Colors.green,
            ),

            InfoTile(
              icon: Icons.account_balance,
              title: "Ownership",
              value: place.isGovernment ? "Government" : "Private",
              color: Colors.blue,
            ),

            InfoTile(
              icon: Icons.access_time,
              title: "Availability",
              value: place.isOpen24Hours
                  ? "Open 24 Hours"
                  : "Limited Working Hours",
              color: Colors.orange,
            ),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Description",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                place.description,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),

            const SizedBox(height: 30),

            // Google Maps Directions Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => _openGoogleMapsDirections(context),
                icon: const Icon(Icons.navigation),
                label: const Text("Get Directions on Google Maps"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Alternative travel modes row
            Row(
              children: [
                Expanded(
                  child: _TravelModeButton(
                    icon: Icons.directions_car,
                    label: "Drive",
                    onPressed: () => _openMapsWithMode(context, 'driving'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _TravelModeButton(
                    icon: Icons.directions_walk,
                    label: "Walk",
                    onPressed: () => _openMapsWithMode(context, 'walking'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _TravelModeButton(
                    icon: Icons.directions_bus,
                    label: "Transit",
                    onPressed: () => _openMapsWithMode(context, 'transit'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Copy coordinates row
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '📍 ${place.latitude.toStringAsFixed(4)}, ${place.longitude.toStringAsFixed(4)}',
                          ),
                          backgroundColor: Colors.indigo,
                        ),
                      );
                    },
                    icon: const Icon(Icons.copy, size: 18),
                    label: Text(
                      '${place.latitude.toStringAsFixed(4)}, ${place.longitude.toStringAsFixed(4)}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.indigo,
                      side: const BorderSide(color: Colors.indigo),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openMapsWithMode(BuildContext context, String mode) async {
    final lat = place.latitude;
    final lng = place.longitude;
    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=$mode',
    );
    final geoUri = Uri.parse(
      'geo:0,0?q=$lat,$lng(${Uri.encodeComponent(place.name)})',
    );

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        // Fallback to geo URI
        final geoLaunched = await launchUrl(
          geoUri,
          mode: LaunchMode.externalApplication,
        );
        if (!geoLaunched && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not open maps. Please install Google Maps.'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  IconData _getIcon(String category) {
    switch (category) {
      case "Hospital":
        return Icons.local_hospital;
      case "Police Station":
        return Icons.local_police;
      case "Fire Station":
        return Icons.local_fire_department;
      case "Shelter":
        return Icons.home;
      case "Relief Center":
        return Icons.volunteer_activism;
      default:
        return Icons.location_on;
    }
  }

  Color _getColor(String category) {
    switch (category) {
      case "Hospital":
        return Colors.red;
      case "Police Station":
        return Colors.blue;
      case "Fire Station":
        return Colors.orange;
      case "Shelter":
        return Colors.green;
      case "Relief Center":
        return Colors.purple;
      default:
        return Colors.indigo;
    }
  }
}

class _TravelModeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _TravelModeButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label, style: const TextStyle(fontSize: 12)),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.indigo,
        side: BorderSide(color: Colors.indigo.shade200),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
      ),
    );
  }
}
