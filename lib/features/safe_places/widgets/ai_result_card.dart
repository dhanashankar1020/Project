import 'package:flutter/material.dart';

class AIResultCard extends StatelessWidget {
  final String title;
  final String category;
  final String distance;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onViewDetails;

  const AIResultCard({
    super.key,
    required this.title,
    required this.category,
    required this.distance,
    required this.description,
    required this.icon,
    required this.color,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// AI Recommended Badge
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.auto_awesome, color: Colors.green, size: 18),
                      SizedBox(width: 6),
                      Text(
                        "AI Recommended",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: color.withValues(alpha: .15),
                  child: Icon(icon, color: color, size: 30),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        category,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),

                Chip(
                  avatar: const Icon(Icons.location_on, size: 18),
                  label: Text(distance),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Text(description, style: theme.textTheme.bodyMedium),

            const SizedBox(height: 22),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: onViewDetails,
                icon: const Icon(Icons.arrow_forward),
                label: const Text("View Details"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
