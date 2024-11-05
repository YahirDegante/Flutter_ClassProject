import 'package:flutter/material.dart';

Padding buildColumn({required String title, required String description}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        const Icon(Icons.add),
        Text(title),
        Text(description),
      ],
    ),
  );
}