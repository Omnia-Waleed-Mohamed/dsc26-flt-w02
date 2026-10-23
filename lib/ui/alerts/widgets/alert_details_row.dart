
import 'package:flutter/material.dart';

import 'alert_acknowledge_action.dart';

class AlertDetailsRow extends StatelessWidget {
  const AlertDetailsRow({
    super.key,
    required this.daysOfCover,
    required this.branchCode,
    required this.acknowledged,
    required this.alertId,
    required this.onAcknowledge,
  });

  final double daysOfCover;
  final String branchCode;
  final bool acknowledged;
  final String alertId;
  final VoidCallback onAcknowledge;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Days of Cover',
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
            const SizedBox(height: 2),
            Text(
              '$daysOfCover days',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Branch',
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
            const SizedBox(height: 2),
            Text(
              branchCode,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
        AlertAcknowledgeAction(
          alertId: alertId,
          acknowledged: acknowledged,
          onAcknowledge: onAcknowledge,
        ),
      ],
    );
  }
}
