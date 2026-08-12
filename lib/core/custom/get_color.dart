import 'package:flutter/material.dart';

LinearGradient getGradient(String id) {
  final gradients = [
    [Color(0xFF4FACFE), Color(0xFF00F2FE)],
    [Color(0xFF43E97B), Color(0xFF38F9D7)],
    [Color(0xFFFF9966), Color(0xFFFF5E62)],
    [Color(0xFFA18CD1), Color(0xFFFBC2EB)],
    [Color(0xFF667EEA), Color(0xFF764BA2)],
    [Color(0xFF11998E), Color(0xFF38EF7D)],
  ];

  final pair = gradients[id.hashCode.abs() % gradients.length];

  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: pair,
  );
}
