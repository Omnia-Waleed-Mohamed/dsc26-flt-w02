import 'package:flutter/material.dart';

class AlertCountHeader extends StatelessWidget {
  const AlertCountHeader({
    super.key,
    required this.countText,
  });

  final String countText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          countText,
          key: const Key('alerts-count'),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xFF333333),
          ),
        ),
      ],
    );
  }
}
