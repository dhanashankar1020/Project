import 'package:flutter/material.dart';

import '../models/emergency_item_model.dart';
import '../screens/emergency_kit_detail_screen.dart';
import '../services/emergency_kit_service.dart';
import '../widgets/emergency_item_card.dart';

class EmergencyKitScreen extends StatefulWidget {
  const EmergencyKitScreen({super.key});

  @override
  State<EmergencyKitScreen> createState() => _EmergencyKitScreenState();
}

class _EmergencyKitScreenState extends State<EmergencyKitScreen> {
  final EmergencyKitService service = EmergencyKitService.instance;
  final TextEditingController searchController = TextEditingController();

  late List<EmergencyItemModel> items;

  @override
  void initState() {
    super.initState();
    items = service.getAllItems();
  }

  void search(String value) {
    setState(() {
      items = service.searchItems(value);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        title: const Text("Emergency Kit"),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: search,
              decoration: InputDecoration(
                hintText: "Search emergency items...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(
                  Icons.inventory_2,
                  color: Colors.deepOrange,
                ),
                const SizedBox(width: 8),
                Text(
                  "${items.length} Items",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: EmergencyItemCard(
                    item: item,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              EmergencyKitDetailScreen(item: item),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}