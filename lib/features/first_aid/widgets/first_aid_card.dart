import 'package:flutter/material.dart';

import '../models/first_aid_model.dart';

class FirstAidCard extends StatelessWidget {
  final FirstAidModel topic;
  final VoidCallback onTap;

  const FirstAidCard({super.key, required this.topic, required this.onTap});

  Color _cardColor() {
    final colors = [
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.blue,
      Colors.purple,
      Colors.teal,
      Colors.indigo,
    ];

    return colors[topic.id.hashCode % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final color = _cardColor();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: ListTile(
          contentPadding: const EdgeInsets.all(14),
          leading: CircleAvatar(
            backgroundColor: color.withValues(alpha: .15),
            child: Icon(Icons.medical_services, color: color),
          ),
          title: Text(
            topic.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            topic.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
