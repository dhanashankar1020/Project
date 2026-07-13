import 'package:flutter/material.dart';
import 'dart:convert';

class ContactModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String relationship;
  final IconData icon;
  final Color color;
  final bool isPrimary;

  const ContactModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.relationship,
    required this.icon,
    required this.color,
    this.isPrimary = false,
  });

  ContactModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? relationship,
    IconData? icon,
    Color? color,
    bool? isPrimary,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      relationship: relationship ?? this.relationship,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      isPrimary: isPrimary ?? this.isPrimary,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'relationship': relationship,
      'isPrimary': isPrimary,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      relationship: map['relationship'],
      isPrimary: map['isPrimary'] ?? false,
      icon: Icons.person,
      color: Colors.blue,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory ContactModel.fromJson(String source) =>
      ContactModel.fromMap(jsonDecode(source));
}