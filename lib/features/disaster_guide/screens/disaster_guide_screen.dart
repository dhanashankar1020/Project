import 'package:flutter/material.dart';
import 'disaster_details_screen.dart';
import '../models/disaster_model.dart';
import '../services/disaster_service.dart';

class DisasterGuideScreen extends StatefulWidget {
  const DisasterGuideScreen({super.key});

  @override
  State<DisasterGuideScreen> createState() => _DisasterGuideScreenState();
}

class _DisasterGuideScreenState extends State<DisasterGuideScreen> {
  final DisasterService _service = DisasterService.instance;
  final TextEditingController _searchController = TextEditingController();

  late List<DisasterModel> disasters;

  @override
  void initState() {
    super.initState();
    disasters = _service.getAllDisasters();
  }

  void _search(String value) {
    setState(() {
      disasters = _service.searchDisasters(value);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Color _getCardColor(int index) {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.orange,
      Colors.green,
      Colors.purple,
      Colors.teal,
    ];

    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),

      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Disaster Guide",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _search,
              decoration: InputDecoration(
                hintText: "Search disaster...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 15),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${disasters.length} Disaster Guides",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: ListView.builder(
                itemCount: disasters.length,
                itemBuilder: (context, index) {
                  final disaster = disasters[index];

                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.only(bottom: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                DisasterDetailsScreen(disaster: disaster),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: _getCardColor(
                                index,
                              ).withValues(alpha: .15),
                              child: Icon(
                                Icons.warning_amber_rounded,
                                color: _getCardColor(index),
                                size: 30,
                              ),
                            ),

                            const SizedBox(width: 15),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    disaster.title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  Text(
                                    disaster.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: Colors.grey),
                                  ),

                                  const SizedBox(height: 10),

                                  Text(
                                    "Emergency: ${disaster.emergencyNumber}",
                                    style: TextStyle(
                                      color: _getCardColor(index),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const Icon(Icons.arrow_forward_ios, size: 18),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
