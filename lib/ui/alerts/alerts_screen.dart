import 'package:dsc26_flt_w02/ui/alerts/view_models/alerts_view_model.dart';
import 'package:flutter/material.dart';
import 'widgets/alerts_loading.dart';
import 'widgets/alerts_app_bar.dart';
import 'widgets/alerts_search_field.dart';
import 'widgets/severity_filter_list.dart';
import 'widgets/alert_count_header.dart';
import 'widgets/alerts_empty_state.dart';
import 'widgets/alert_card.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key, required this.viewModel});

  final AlertsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel,
      builder: (context, _) {
        if (viewModel.loading) {
          return const AlertsLoading();
        }

        final alerts = viewModel.visibleAlertsUnmodifiable;
        final countText =
            '${alerts.length} ${alerts.length == 1 ? 'alert' : 'alerts'}';

        return Scaffold(
          backgroundColor: const Color(0xFFF4F6F9),
          appBar: AlertsAppBar(
            criticalCount: viewModel.unacknowledgedCriticalCount,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Column(
              children: [
                AlertsSearchField(
                  onChanged: viewModel.setQuery,
                ),
                const SizedBox(height: 14),
                SeverityFilterList(
                  activeFilters: viewModel.activeFilters,
                  onFilterSelected: viewModel.toggleFilter,
                ),
                const SizedBox(height: 14),
                AlertCountHeader(countText: countText),
                const SizedBox(height: 10),
                Expanded(
                  child: alerts.isEmpty
                      ? const AlertsEmptyState()
                      : ListView.builder(
                          key: const Key('alerts-list'),
                          itemCount: alerts.length,
                          itemBuilder: (context, index) {
                            final alert = alerts[index];

                            return AlertCard(
                              key: Key('alert-${alert.id}'),
                              alert: alert,
                              onAcknowledge: () {
                                viewModel.acknowledge(alert.id);
                              },
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
