import 'package:flutter/material.dart';

class AlertsLoading extends StatelessWidget {
  const AlertsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Center(
        child: CircularProgressIndicator(
          key: const Key('alerts-loading'),
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.blue.shade800,
          ),
        ),
      ),
    );
  }
}
