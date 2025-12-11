import 'package:flutter/material.dart';
import '../utilities.dart';

class ImageUploadBox extends StatelessWidget {
  final VoidCallback onTap;

  const ImageUploadBox({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final Color primary = AppColors.primaryGreen;
    final Color secondary = AppColors.primaryGreen.withOpacity(0.1);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 150,
        width: 300,
        decoration: BoxDecoration(
          color: secondary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: primary.withOpacity(0.3), width: 2, style: BorderStyle.solid,),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_a_photo_outlined, size: 40, color: primary),
            const SizedBox(height: 10),
            Text("إرفاق صورة حديثة للمفقود",
                style: TextStyle(color: primary, fontWeight: FontWeight.bold,),),
            const SizedBox(height: 5),
            Text("(اختياري)",
                style: TextStyle(
                    color: AppColors.black.withOpacity(0.5), fontSize: 12,),),
          ],
        ),
      ),
    );
  }
}