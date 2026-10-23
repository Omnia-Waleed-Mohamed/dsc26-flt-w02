import 'package:dsc26_flt_w02/domain/models/stock_alert.dart';
import 'package:dsc26_flt_w02/ui/alerts/widgets/alert_details_row.dart';
import 'package:dsc26_flt_w02/ui/alerts/widgets/alert_severity_badge.dart';
import 'package:flutter/material.dart';
import 'alert_medicine_info.dart';


class AlertCard extends StatelessWidget {
  const AlertCard({
    super.key,
    required this.alert,
    required this.onAcknowledge,
  });

  final StockAlert alert;
  final VoidCallback onAcknowledge;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AlertMedicineInfo(
                  englishName: alert.medicineNameEn,
                  arabicName: alert.medicineNameAr,
                ),
              ),
              AlertSeverityBadge(severity: alert.severity),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Divider(
              height: 1,
              color: Color(0xFFEEEEEE),
            ),
          ),
          AlertDetailsRow(
            daysOfCover: alert.daysOfCover,
            branchCode: alert.branchCode,
            acknowledged: alert.acknowledged,
            alertId: alert.id,
            onAcknowledge: onAcknowledge,
          ),
        ],
      ),
    );
  }
}
