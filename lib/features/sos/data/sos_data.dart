import 'package:flutter/material.dart';

import '../models/sos_action.dart';

class SosData {
  static List<SosAction> get actions => [
        SosAction(
          title: "Emergency Call",
          description: "Call emergency services",
          icon: Icons.call,
          color: Colors.red,
          onTap: () {},
        ),
        SosAction(
          title: "Share Location",
          description: "Send your current location",
          icon: Icons.location_on,
          color: Colors.blue,
          onTap: () {},
        ),
        SosAction(
          title: "Flashlight SOS",
          description: "Blink flashlight for help",
          icon: Icons.flashlight_on,
          color: Colors.orange,
          onTap: () {},
        ),
      ];
}