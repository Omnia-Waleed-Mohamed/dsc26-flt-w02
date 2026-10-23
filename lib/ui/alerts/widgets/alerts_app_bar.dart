import 'package:flutter/material.dart';

class AlertsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AlertsAppBar({
    super.key,
    required this.criticalCount,
  });

  final int criticalCount;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFF1565C0),
      title: Text(
        'Branch Alerts ($criticalCount Critical)',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
