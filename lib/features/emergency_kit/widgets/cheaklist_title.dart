import 'package:flutter/material.dart';

import '../models/emergency_item_model.dart';

class ChecklistTile extends StatelessWidget {
  final EmergencyItemModel item;
  final ValueChanged<bool?>? onChanged;

  const ChecklistTile({
    super.key,
    required this.item,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: CheckboxListTile(
        value: item.isPacked,
        onChanged: onChanged,
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.green,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        title: Text(
          item.name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            decoration: item.isPacked
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              item.description,
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  size: 18,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 4),
                Text(
                  "Qty: ${item.quantity}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                if (item.isEssential)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Essential",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}