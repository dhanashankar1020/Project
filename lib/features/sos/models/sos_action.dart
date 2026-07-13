import 'package:flutter/material.dart';

class SosAction {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const SosAction({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    this.onTap,
  });

  SosAction copyWith({
    String? title,
    String? description,
    IconData? icon,
    Color? color,
    VoidCallback? onTap,
  }) {
    return SosAction(
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      onTap: onTap ?? this.onTap,
    );
  }
}