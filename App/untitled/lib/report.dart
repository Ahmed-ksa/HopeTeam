import 'package:flutter/material.dart';
import 'utilities.dart';

class Report extends StatelessWidget {
  final String name;
  final String description;
  final String location;
  final String time;
  const Report({
    super.key,
    required this.name,
    required this.description,
    required this.location,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: AppColors.white.withOpacity(0.9),
            child: const BackButton(color: AppColors.black),
          ),
        ),
        actions: [],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.black.withOpacity(0.1),
              ),
              child: Center(
                child: Icon(Icons.person, size: 120, color: AppColors.black.withOpacity(0.3),
                ),
              ),
            ),

            Container(
              transform: Matrix4.translationValues(0.0, -30.0, 0.0),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: AppColors.black.withOpacity(0.5)),
                      const SizedBox(width: 4),
                      Text(
                        location,
                        style: TextStyle(color: AppColors.black.withOpacity(0.6)),
                      ),
                      const SizedBox(width: 20),
                      Icon(Icons.access_time, size: 16, color: AppColors.black.withOpacity(0.5)),
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: TextStyle(color: AppColors.black.withOpacity(0.6)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Divider(thickness: 1, height: 1, color: AppColors.black.withOpacity(0.1)),
                  const SizedBox(height: 25),
                  const Text(
                    "تفاصيل البلاغ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                   Text(
                    description,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(color: AppColors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  debugPrint("تم الضغط على إبلاغ");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                icon: const Icon(Icons.report_problem),
                label: const Text(
                  "إبلاغ عن حالة",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}