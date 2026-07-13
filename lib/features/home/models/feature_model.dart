import 'package:flutter/material.dart';

class FeatureModel {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String route;

  const FeatureModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.route,
  });

  FeatureModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    IconData? icon,
    Color? color,
    String? route,
  }) {
    return FeatureModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      route: route ?? this.route,
    );
  }
}