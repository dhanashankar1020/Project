import 'package:flutter/material.dart';
import 'package:shankar2/shared/widgets/emergency_card.dart';
import '../../contacts/screens/contacts_screen.dart';
import '../../disaster_guide/screens/disaster_guide_screen.dart';
import '../../emergency_kit/screens/emergency_kit_screen.dart';
import '../../first_aid/screens/first_aid_screen.dart';
import '../../safe_places/screens/safe_places_screen.dart';
import '../../sos/screens/sos_screens.dart';
import '../../ai_chat/screens/ai_chat_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> emergencyFeatures = [
      {
        "title": "SOS",
        "subtitle": "Emergency Help",
        "icon": Icons.sos,
        "color": Colors.red,
      },
      {
        "title": "First Aid",
        "subtitle": "Medical Guide",
        "icon": Icons.medical_services,
        "color": Colors.green,
      },
      {
        "title": "Contacts",
        "subtitle": "Emergency Numbers",
        "icon": Icons.contact_phone,
        "color": Colors.blue,
      },
      {
        "title": "Safe Places",
        "subtitle": "Shelters",
        "icon": Icons.location_on,
        "color": Colors.orange,
      },
      {
        "title": "Kit",
        "subtitle": "Emergency Checklist",
        "icon": Icons.backpack,
        "color": Colors.purple,
      },
      {
        "title": "Disaster Guide",
        "subtitle": "Safety Tips",
        "icon": Icons.menu_book,
        "color": Colors.teal,
      },
     
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          "Offline Disaster Helper",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.health_and_safety,
                    color: Colors.white,
                    size: 50,
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      "Stay Safe!\nYour emergency tools are always available offline.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        height: 1.4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Emergency Services",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            GridView.builder(
              itemCount: emergencyFeatures.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final item = emergencyFeatures[index];

                return EmergencyCard(
                  title: item["title"],
                  subtitle: item["subtitle"],
                  icon: item["icon"],
                  color: item["color"],
                  onTap: () {
                    switch (item["title"]) {
                      case "SOS":
                       Navigator.push(
                       context,
                       MaterialPageRoute(
                       builder: (_) =>  SosScreen(),
                    ),
                  );
                      break;

                      case "First Aid":
                       Navigator.push(
                       context,
                       MaterialPageRoute(
                       builder: (_) => const FirstAidScreen(),
                    ),
                  );
                      break;

                      case "Contacts":
                       Navigator.push(
                       context,
                       MaterialPageRoute(
                       builder: (_) => const ContactsScreen(),
                    ),
                  );
                      break;

                       case "Safe Places":
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (_) =>  const SafePlacesScreen(),
                    ),
                  );
                      break;

                       case "Kit":
                       Navigator.push(
                       context,
                       MaterialPageRoute(
                       builder: (_) => const EmergencyKitScreen(),
                    ),
                  );
                       break;

                       case "Disaster Guide":
                       Navigator.push(
                       context,
                       MaterialPageRoute(
                       builder: (_) => const DisasterGuideScreen(),
                    ),
                  );
                        break;
                       case "SafePlace AI":
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const AIChatScreen(),
    ),
  );
  break;
  }
},
                );
              },
            ),

            const SizedBox(height: 30),

            const Center(
              child: Text(
                "Version 1.0",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}