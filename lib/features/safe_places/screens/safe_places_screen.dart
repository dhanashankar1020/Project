import 'package:flutter/material.dart';

import '../models/safe_place_model.dart';
import '../screens/safe_place_detail_screen.dart';
import '../services/safe_places_service.dart';
import '../widgets/safe_place_card.dart';

class SafePlacesScreen extends StatefulWidget {
  const SafePlacesScreen({super.key});

  @override
  State<SafePlacesScreen> createState() => _SafePlacesScreenState();
}

class _SafePlacesScreenState extends State<SafePlacesScreen> {
  final SafePlacesService service = SafePlacesService.instance;
  final TextEditingController searchController = TextEditingController();

  late List<SafePlaceModel> places;

  @override
  void initState() {
    super.initState();
    places = service.getAllPlaces();
  }

  void search(String query) {
    setState(() {
      places = service.searchPlaces(query);
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
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        title: const Text("Safe Places"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
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
                hintText: "Search safe places...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
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
                  Icons.location_on,
                  color: Colors.indigo,
                ),
                const SizedBox(width: 8),
                Text(
                  "${places.length} Safe Places",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: places.length,
              itemBuilder: (context, index) {
                final place = places[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SafePlaceCard(
                    place: place,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              SafePlaceDetailScreen(place: place),
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