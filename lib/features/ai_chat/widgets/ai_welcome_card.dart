import 'package:flutter/material.dart';

class AIWelcomeCard extends StatelessWidget {
  const AIWelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.support_agent_rounded,
              size: 32,
              color: theme.colorScheme.primary,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SafePlace AI",
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Your intelligent emergency safety assistant.\n"
                  "I'll help you find safe places and provide disaster guidance.",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 18),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    _FeatureChip(
                      icon: Icons.local_hospital_rounded,
                      label: "Hospitals",
                    ),
                    _FeatureChip(
                      icon: Icons.home_work_rounded,
                      label: "Shelters",
                    ),
                    _FeatureChip(
                      icon: Icons.local_police_rounded,
                      label: "Police",
                    ),
                    _FeatureChip(
                      icon: Icons.local_fire_department_rounded,
                      label: "Fire Station",
                    ),
                    _FeatureChip(
                      icon: Icons.route_rounded,
                      label: "Safe Route",
                    ),
                    _FeatureChip(
                      icon: Icons.warning_amber_rounded,
                      label: "Emergency Tips",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
