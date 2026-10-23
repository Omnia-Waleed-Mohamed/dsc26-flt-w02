
import 'package:flutter/material.dart';

class AlertMedicineInfo extends StatelessWidget {
  const AlertMedicineInfo({
    super.key,
    required this.englishName,
    required this.arabicName,
  });

  final String englishName;
  final String arabicName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          englishName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF222222),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          arabicName,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
