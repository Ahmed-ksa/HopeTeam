import 'package:flutter/material.dart';
import '../utilities.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final int maxLines;
  final bool isNumeric;
  final TextEditingController? controller;
  final List<String>? items;
  final void Function(String?)? onChanged;
  final String? initialValue;
  final bool isTimePicker;

  const CustomTextField({
    super.key,
    required this.label,
    required this.icon,
    this.maxLines = 1,
    this.isNumeric = false,
    this.controller,
    this.items,
    this.onChanged,
    this.initialValue,
    this.isTimePicker = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = AppColors.primaryGreen;
    final Color borderColor = AppColors.black.withOpacity(0.2);

    final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: borderColor),
    );
    final focusedBorderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: primaryColor, width: 2),
    );

    final inputDecoration = InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: primaryColor),
      border: borderStyle,
      enabledBorder: borderStyle,
      focusedBorder: focusedBorderStyle,
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
    );

    if (items != null && items!.isNotEmpty) {
      return DropdownButtonFormField<String>(
        value: initialValue,
        decoration: inputDecoration,
        icon: Icon(Icons.arrow_drop_down, color: primaryColor),
        isExpanded: true,
        items: items!.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged ?? (val) {},
      );
    }
    if (maxLines > 1) {
      return Stack(
        alignment: Alignment.topRight,
        children: [
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            textAlignVertical: TextAlignVertical.top,
            keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
            decoration: inputDecoration.copyWith(
              prefixIcon: null,
              contentPadding: const EdgeInsets.fromLTRB(15, 15, 45, 15),
              alignLabelWithHint: true,
            ),
          ),
          Positioned(
            top: 15,
            right: 12,
            child: Icon(icon, color: primaryColor),
          ),
        ],
      );
    }
    return TextFormField(
      controller: controller,
      maxLines: 1,
      readOnly: isTimePicker,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      decoration: inputDecoration,
      onTap: isTimePicker
          ? () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: primaryColor,
                  onPrimary: AppColors.white,
                  onSurface: AppColors.black,
                ),
              ),
              child: child!,
            );
          },
        );

        if (pickedTime != null && controller != null) {
          final localizations = MaterialLocalizations.of(context);
          String formattedTime =
          localizations.formatTimeOfDay(pickedTime);
          controller!.text = formattedTime;
        }
      }
          : null,
    );
  }
}