import 'dart:async';

import 'package:flutter/material.dart';

class SosCountdownDialog extends StatefulWidget {
  final VoidCallback onCompleted;

  const SosCountdownDialog({
    super.key,
    required this.onCompleted,
  });

  @override
  State<SosCountdownDialog> createState() => _SosCountdownDialogState();
}

class _SosCountdownDialogState extends State<SosCountdownDialog> {
  int countdown = 3;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown == 1) {
        timer.cancel();

        Navigator.pop(context);

        widget.onCompleted();
      } else {
        setState(() {
          countdown--;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ),
          SizedBox(width: 10),
          Text("Emergency SOS"),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Emergency actions will begin in",
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          Text(
            "$countdown",
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Press Cancel to stop.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            timer?.cancel();
            Navigator.pop(context);
          },
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}