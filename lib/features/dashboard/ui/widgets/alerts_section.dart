import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../constants/constants.dart';
import '../../../../core/state/providers/dashboard_provider.dart';

/// Alerts section showing important notifications and warnings
class AlertsSection extends ConsumerWidget {
  const AlertsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alerts = ref.watch(alertsProvider);

    if (alerts.isEmpty) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alerts',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...alerts.map((alert) => AlertItem(alert: alert)),
          ],
        ),
      ),
    );
  }
}

/// Individual alert item widget
class AlertItem extends StatelessWidget {
  const AlertItem({super.key, required this.alert});

  final Map<String, dynamic> alert;

  @override
  Widget build(BuildContext context) {
    final type = alert['type'] as String;
    final message = alert['message'] as String;

    Color color;
    IconData icon;

    switch (type) {
      case 'error':
        color = AppColors.destructive;
        icon = Icons.error;
        break;
      case 'warning':
        color = AppColors.warning;
        icon = Icons.warning;
        break;
      default:
        color = AppColors.info;
        icon = Icons.info;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
