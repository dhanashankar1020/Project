import 'package:flutter/material.dart';

class FirstAidStepTile extends StatelessWidget {
  final int stepNumber;
  final String step;

  const FirstAidStepTile({
    super.key,
    required this.stepNumber,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.green,
            child: Text(
              "$stepNumber",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              step,
              style: const TextStyle(
                fontSize: 16,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}