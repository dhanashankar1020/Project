import 'package:flutter/material.dart';

class SuggestionChip extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const SuggestionChip({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ActionChip(
        elevation: 1,
        pressElevation: 3,
        backgroundColor: theme.colorScheme.surface,
        side: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.25),
        ),
        avatar: Icon(icon, size: 18, color: theme.colorScheme.primary),
        label: Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: onTap,
      ),
    );
  }
}
