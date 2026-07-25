import 'package:flutter/material.dart';

class AISearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final bool isLoading;

  const AISearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: .15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: theme.colorScheme.primary,
                child: const Icon(
                  Icons.smart_toy_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "SafePlace AI",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            "Describe your emergency and I'll recommend the safest nearby place.",
            style: theme.textTheme.bodyMedium,
          ),

          const SizedBox(height: 16),

          TextField(
            controller: controller,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => onSearch(),
            decoration: InputDecoration(
              hintText: "e.g. Nearest flood shelter",
              prefixIcon: const Icon(Icons.search),
              suffixIcon: isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : IconButton(
                      icon: const Icon(Icons.send_rounded),
                      onPressed: onSearch,
                    ),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _SuggestionButton(title: "Flood Shelter", onTap: () {}),
              _SuggestionButton(title: "Nearest Hospital", onTap: () {}),
              _SuggestionButton(title: "Police Station", onTap: () {}),
              _SuggestionButton(title: "Fire Station", onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

class _SuggestionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _SuggestionButton({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ActionChip(label: Text(title), onPressed: onTap);
  }
}
