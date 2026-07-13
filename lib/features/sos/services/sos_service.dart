import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';


class SosService {
  Future<void> requestPermissions() async {
  await Permission.location.request();
  await Permission.sms.request();
  await Permission.phone.request();
}
  // Activate SOS
  Future<void> activateSOS(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("🚨 SOS Activated"),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Emergency Call
 Future<void> callEmergency() async {
  final Uri phoneUri = Uri(
    scheme: 'tel',
    path: '112',
  );

  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    throw Exception("Unable to open phone dialer.");
  }
}
  // Share Current Location
  Future<void> shareLocation(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("📍 Sharing Current Location..."),
      ),
    );
  }

  // Flashlight SOS
  Future<void> flashlightSOS(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("🔦 Flashlight SOS Activated"),
      ),
    );
  }

  // Play Emergency Alarm
  Future<void> playAlarm(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("🔊 Emergency Alarm Started"),
      ),
    );
  }

  // Stop Alarm
  Future<void> stopAlarm(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("🔇 Alarm Stopped"),
      ),
    );
  }
  
  Future<void> sendSOSMessage(
  List<String> phoneNumbers,
  String location,
) async {
  if (phoneNumbers.isEmpty) {
    throw Exception("No emergency contacts found.");
  }

  final String message = '''
🚨 EMERGENCY SOS 🚨

I need immediate help.

My Location:
$location

Please reach me immediately.
''';

  final Uri smsUri = Uri(
    scheme: 'sms',
    path: phoneNumbers.join(','),
    queryParameters: {
      'body': message,
    },
  );

  await launchUrl(
    smsUri,
    mode: LaunchMode.externalApplication,
  );
}
  // GPS location
  Future<String> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check whether location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    throw Exception("Location services are disabled.");
  }

  // Check permission
  permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      throw Exception("Location permission denied.");
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception("Location permission permanently denied.");
  }

  // Get current position
  Position position = await Geolocator.getCurrentPosition(
  locationSettings: const LocationSettings(
    accuracy: LocationAccuracy.high,
  ),
);

  return "https://maps.google.com/?q=${position.latitude},${position.longitude}";
}
}