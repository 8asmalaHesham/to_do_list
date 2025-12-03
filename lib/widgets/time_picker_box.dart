import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';

class TimePickerBox extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const TimePickerBox({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: kSpacingSmall),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(kInputRadius),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(value),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
