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
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(key: Key('alerts-loading')),
            ),
          );
        }

        final alerts = viewModel.visibleAlertsUnmodifiable;
        final countString = '${alerts.length} ${alerts.length == 1 ? 'alert' : 'alerts'}';

        return Scaffold(
          appBar: AppBar(
            title: Text('Branch alerts (Critical: ${viewModel.unacknowledgedCriticalCount})'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                // Search Field
                TextField(
                  key: const Key('search-field'),
                  decoration: const InputDecoration(
                    labelText: 'Search medicine...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: viewModel.setQuery,
                ),
                const SizedBox(height: 10),

                // Filters
                Wrap(
                  spacing: 8,
                  children: Severity.values.map((severity) {
                    final isSelected = viewModel.activeFilters.contains(severity);
                    return FilterChip(
                      key: Key('filter-${severity.name}'),
                      label: Text(severity.name.toUpperCase()),
                      selected: isSelected,
                      onSelected: (_) => viewModel.toggleFilter(severity),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),

                // Count
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    countString,
                    key: const Key('alerts-count'),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),

                // List or Empty
                Expanded(
                  child: alerts.isEmpty
                      ? const Center(
                          child: Text(
                            '0 alerts',
                            key: Key('alerts-empty'),
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          key: const Key('alerts-list'),
                          itemCount: alerts.length,
                          itemBuilder: (context, index) {
                            final alert = alerts[index];
                            return Card(
                              key: Key('alert-${alert.id}'),
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: ListTile(
                                title: Text('${alert.medicineNameEn} (${alert.medicineNameAr})'),
                                subtitle: Text(
                                  'Severity: ${alert.severity.name} | Cover: ${alert.daysOfCover} days | Branch: ${alert.branchCode}',
                                ),
                                trailing: alert.acknowledged
                                    ? const Text('Acknowledged', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))
                                    : ElevatedButton(
                                        key: Key('ack-${alert.id}'),
                                        onPressed: () => viewModel.acknowledge(alert.id),
                                        child: const Text('Acknowledge'),
                                      ),
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
}