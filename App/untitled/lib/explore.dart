import 'package:flutter/material.dart';
import 'addReport.dart';
import 'myWidgets/mapWidget.dart';
import 'myWidgets/reportsSheet.dart';
import 'utilities.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  int _refreshId = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MapWidget(),
          ReportsSheet(refreshTrigger: _refreshId),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddReport(),
            ),
          );

          setState(() {
            _refreshId++;
          });

          debugPrint("تم العودة للصفحة الرئيسية وتحديث القائمة");
        },
        label: const Text('إضافة بلاغ'),
        icon: const Icon(Icons.add_alert),
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: AppColors.white,
      ),
    );
  }
}