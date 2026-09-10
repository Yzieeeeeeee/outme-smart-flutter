import 'package:flutter/material.dart';
import '../../controllers/home_controller.dart';
import '../../core/constants/app_colors.dart';

class SectionStateView extends StatelessWidget {
  final LoadStatus status;
  final String errorMessage;
  final String emptyMessage;
  final VoidCallback onRetry;
  final Widget child;
  final double height;

  const SectionStateView({
    super.key,
    required this.status,
    required this.errorMessage,
    required this.child,
    required this.onRetry,
    this.emptyMessage = 'Nothing to show right now.',
    this.height = 180,
  });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case LoadStatus.loading:
        return SizedBox(height: height, child: const Center(child: CircularProgressIndicator()));
      case LoadStatus.error:
        return SizedBox(
          height: height,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, color: AppColors.error, size: 28),
                const SizedBox(height: 8),
                Text(errorMessage, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
                TextButton(onPressed: onRetry, child: const Text('Retry')),
              ],
            ),
          ),
        );
      case LoadStatus.empty:
        return SizedBox(
          height: height,
          child: Center(child: Text(emptyMessage, style: TextStyle(color: Colors.grey[600]))),
        );
      case LoadStatus.success:
        return child;
    }
  }
}