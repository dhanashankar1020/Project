import 'package:flutter/material.dart';

import '../models/safe_place_model.dart';

class SafePlaceCard extends StatelessWidget {
  final SafePlaceModel place;
  final VoidCallback? onTap;

  const SafePlaceCard({
    super.key,
    required this.place,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  color: _getColor(place.category).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  _getIcon(place.category),
                  color: _getColor(place.category),
                  size: 32,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      place.category,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      place.address,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        if (place.isGovernment)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "Government",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                        const SizedBox(width: 8),

                        if (place.isOpen24Hours)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "24 Hours",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 18,
              ),
            ],
          ),
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
        return Colors.teal;
    }
  }
}