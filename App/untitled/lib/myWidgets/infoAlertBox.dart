import 'package:flutter/material.dart';
import '../utilities.dart';


class InfoAlertBox extends StatelessWidget {
  final String message;

  const InfoAlertBox({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final Color primary = AppColors.primaryGreen;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primary.withOpacity(0.08),
        border: Border.all(color: primary.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: primary,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}