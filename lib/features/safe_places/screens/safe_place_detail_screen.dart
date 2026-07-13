import 'package:flutter/material.dart';

import '../models/safe_place_model.dart';
import '../widgets/info_tile.dart';

class SafePlaceDetailScreen extends StatelessWidget {
  final SafePlaceModel place;

  const SafePlaceDetailScreen({
    super.key,
    required this.place,
  });

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
              backgroundColor: _getColor(place.category).withOpacity(0.15),
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
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              place.category,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16,
              ),
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
              value: place.isGovernment
                  ? "Government"
                  : "Private",
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
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Navigation feature will be added in Phase 2.2",
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.navigation),
                label: const Text("Navigate"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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