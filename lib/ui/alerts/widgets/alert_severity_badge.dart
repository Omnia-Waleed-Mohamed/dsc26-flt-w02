
import 'package:dsc26_flt_w02/domain/models/stock_alert.dart';
import 'package:flutter/material.dart';

class AlertSeverityBadge extends StatelessWidget {
  const AlertSeverityBadge({
    super.key,
    required this.severity,
  });

  final Severity severity;

  Color _getSeverityColor(Severity severity) {
    switch (severity) {
      case Severity.critical:
        return Colors.red.shade700;
      case Severity.high:
        return Colors.deepOrange;
      case Severity.medium:
        return Colors.amber.shade800;
      case Severity.low:
        return Colors.green.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    final severityColor = _getSeverityColor(severity);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: severityColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        severity.name.toUpperCase(),
        style: TextStyle(
          color: severityColor,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }
}
