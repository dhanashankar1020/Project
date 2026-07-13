import 'package:flutter/material.dart';


import '../data/sos_data.dart';
import '../models/sos_action.dart';
import '../services/sos_service.dart';
import '../widgets/sos_action_card.dart';
import '../widgets/sos_button.dart';
import '../widgets/sos_countdown_dialog.dart';
import '../../contacts/services/contacts_service.dart';


class SosScreen extends StatelessWidget {
  SosScreen({super.key});
      final ContactsService contactsService = ContactsService();

  @override
  Widget build(BuildContext context) {
    final List<SosAction> actions = SosData.actions;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          "SOS Emergency",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),

            const Text(
              "Emergency Assistance",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Press the SOS button or Click the power button in 3 times only in a real emergency ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

           Center(
          child: SosButton(
           onPressed: () {
           showDialog(
           context: context,
         barrierDismissible: false,
        builder: (_) => SosCountdownDialog(
         onCompleted: () async {
  try {
    await SosService().requestPermissions();

    await SosService().callEmergency();

    String location = await SosService().getCurrentLocation();

    await contactsService.loadContacts();

final phoneNumbers = await contactsService.getAllPhoneNumbers();
    await SosService().sendSOSMessage(
      phoneNumbers,
      location,
    );

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("📍 Location Retrieved Successfully"),
        ),
      );
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
}
        ),
      );
    },
  ),
),
            const SizedBox(height: 30),

            Expanded(
              child: ListView.builder(
                itemCount: actions.length,
                itemBuilder: (context, index) {
                  return SosActionCard(
                    action: actions[index],
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