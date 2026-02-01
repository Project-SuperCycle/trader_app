import 'package:flutter/material.dart';
import 'package:trader_app/core/utils/app_styles.dart';

/// Reusable header widget displayed at the top of every step.
class StepHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final int stepNumber;

  const StepHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.stepNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade50, Colors.green.shade100],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withAlpha(50),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildIconBadge(),
          const SizedBox(width: 16),
          Expanded(child: _buildText(context)),
        ],
      ),
    );
  }

  Widget _buildIconBadge() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withAlpha(100),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Center(child: Icon(icon, color: Colors.green.shade700, size: 28)),
          Positioned(
            top: 4,
            right: 4,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.green.shade700,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$stepNumber',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.styleSemiBold18(
            context,
          ).copyWith(color: Colors.green.shade900),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: AppStyles.styleMedium12(
            context,
          ).copyWith(color: Colors.green.shade700),
        ),
      ],
    );
  }
}
