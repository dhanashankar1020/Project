import 'package:flutter/material.dart';

import '../models/emergency_item_model.dart';

class EmergencyKitDetailScreen extends StatelessWidget {
  final EmergencyItemModel item;

  const EmergencyKitDetailScreen({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        title: Text(item.name),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item Icon
            Center(
              child: CircleAvatar(
                radius: 55,
                backgroundColor: item.isEssential
                    ? Colors.red.shade100
                    : Colors.orange.shade100,
                child: Icon(
                  item.isEssential
                      ? Icons.priority_high
                      : Icons.inventory_2,
                  size: 55,
                  color: item.isEssential
                      ? Colors.red
                      : Colors.deepOrange,
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              item.name,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Chip(
              avatar: const Icon(
                Icons.category,
                color: Colors.white,
                size: 18,
              ),
              backgroundColor: Colors.deepOrange,
              label: Text(
                item.category,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Description",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              item.description,
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 25),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.inventory,
                  color: Colors.deepOrange,
                ),
                title: const Text("Recommended Quantity"),
                subtitle: Text("${item.quantity}"),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: Icon(
                  item.isEssential
                      ? Icons.star
                      : Icons.check_circle_outline,
                  color: item.isEssential
                      ? Colors.red
                      : Colors.green,
                ),
                title: const Text("Priority"),
                subtitle: Text(
                  item.isEssential
                      ? "Essential Item"
                      : "Recommended Item",
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Packing feature will be available in Phase 2.2",
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.check_box_outlined),
                label: const Text(
                  "Mark as Packed",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
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
}