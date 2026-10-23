import 'package:dsc26_flt_w02/core/mock_data/demo_alerts.dart';
import 'package:dsc26_flt_w02/data/repositories/alert_repository.dart';
import 'package:dsc26_flt_w02/ui/alerts/alerts_screen.dart';
import 'package:dsc26_flt_w02/ui/alerts/view_models/alerts_view_model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    NourShelfApp(
      repository: InMemoryAlertRepository(demoAlerts),
    ),
  );
}

class NourShelfApp extends StatefulWidget {
  const NourShelfApp({
    super.key,
    required this.repository,
  });

  final AlertRepository repository;

  @override
  State<NourShelfApp> createState() => _NourShelfAppState();
}

class _NourShelfAppState extends State<NourShelfApp> {
  late final AlertsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AlertsViewModel(repository: widget.repository);
    _viewModel.load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nour Shelf',
      home: AlertsScreen(viewModel: _viewModel),
    );
  }
}
