import 'package:dsc26_flt_w02/domain/models/stock_alert.dart';
import 'package:dsc26_flt_w02/ui/alerts/view_models/alerts_view_model.dart';
import 'package:flutter/material.dart';


class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key, required this.viewModel});

  final AlertsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel,
      builder: (context, _) {
        if (viewModel.loading) {
          return Scaffold(
            backgroundColor: const Color(0xFFF8F9FA),
            body: Center(
              child: CircularProgressIndicator(
                key: const Key('alerts-loading'),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade800),
              ),
            ),
          );
        }

        final alerts = viewModel.visibleAlertsUnmodifiable;
        final countText = '${alerts.length} ${alerts.length == 1 ? 'alert' : 'alerts'}';

        return Scaffold(
          backgroundColor: const Color(0xFFF4F6F9),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color(0xFF1565C0),
            title: Text(
              'Branch Alerts (${viewModel.unacknowledgedCriticalCount} Critical)',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              children: [
                // Search Field (Matches key 'search-field')
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    key: const Key('search-field'),
                    decoration: const InputDecoration(
                      hintText: 'Search medicines...',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    onChanged: viewModel.setQuery,
                  ),
                ),
                const SizedBox(height: 14),

                // Severity Filters Row (Matches keys 'filter-critical', 'filter-high', etc.)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: Severity.values.map((severity) {
                      final isSelected = viewModel.activeFilters.contains(severity);
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          key: Key('filter-${severity.name}'),
                          label: Text(severity.name.toUpperCase()),
                          selected: isSelected,
                          selectedColor: Colors.blue.shade100,
                          backgroundColor: Colors.white,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.blue.shade900 : Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: isSelected ? Colors.blue.shade700 : Colors.grey.shade300,
                            ),
                          ),
                          onSelected: (_) => viewModel.toggleFilter(severity),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 14),

                // Count Header (Matches key 'alerts-count')
                Row(
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
                ),
                const SizedBox(height: 10),

                // List or Empty State
                Expanded(
                  child: alerts.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey.shade400),
                              const SizedBox(height: 12),
                              const Text(
                                '0 alerts',
                                key: Key('alerts-empty'),
                                style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          key: const Key('alerts-list'),
                          itemCount: alerts.length,
                          itemBuilder: (context, index) {
                            final alert = alerts[index];
                            return Container(
                              key: Key('alert-${alert.id}'),
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
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              alert.medicineNameEn,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF222222),
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              alert.medicineNameAr,
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Severity Badge
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: _getSeverityColor(alert.severity).withValues(alpha: 0.12),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          alert.severity.name.toUpperCase(),
                                          style: TextStyle(
                                            color: _getSeverityColor(alert.severity),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10.0),
                                    child: Divider(height: 1, color: Color(0xFFEEEEEE)),
                                  ),
                                  // Details Grid (Cover Days & Branch & Acknowledge Button)
                                  Row(
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
                                            '${alert.daysOfCover} days',
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
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
                                            alert.branchCode,
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                          ),
                                        ],
                                      ),
                                      // Acknowledge Action / Status
                                      alert.acknowledged
                                          ? Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                              decoration: BoxDecoration(
                                                color: Colors.green.shade50,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: const Row(
                                                children: [
                                                  Icon(Icons.check_circle, color: Colors.green, size: 16),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    'Acknowledged',
                                                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : ElevatedButton(
                                              key: Key('ack-${alert.id}'),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(0xFF1565C0),
                                                foregroundColor: Colors.white,
                                                elevation: 0,
                                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                              ),
                                              onPressed: () => viewModel.acknowledge(alert.id),
                                              child: const Text('Acknowledge', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
}