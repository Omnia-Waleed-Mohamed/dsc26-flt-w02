
import 'package:dsc26_flt_w02/domain/models/stock_alert.dart';
import 'package:flutter/material.dart';

class SeverityFilterList extends StatelessWidget {
  const SeverityFilterList({
    super.key,
    required this.activeFilters,
    required this.onFilterSelected,
  });

  final Set<Severity> activeFilters;
  final ValueChanged<Severity> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: Severity.values.map((severity) {
          final isSelected = activeFilters.contains(severity);

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilterChip(
              key: Key('filter-${severity.name}'),
              label: Text(severity.name.toUpperCase()),
              selected: isSelected,
              selectedColor: Colors.blue.shade100,
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                color: isSelected
                    ? Colors.blue.shade900
                    : Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected
                      ? Colors.blue.shade700
                      : Colors.grey.shade300,
                ),
              ),
              onSelected: (_) => onFilterSelected(severity),
            ),
          );
        }).toList(),
      ),
    );
  }
}
