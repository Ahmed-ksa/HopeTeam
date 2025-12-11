import 'package:flutter/material.dart';
import '../utilities.dart';
import 'missingPersonCard.dart';
import '../backend/db_helper.dart';
import '../backend/report_model.dart';

class ReportsSheet extends StatefulWidget {
  final int refreshTrigger;

  const ReportsSheet({super.key, required this.refreshTrigger});

  @override
  State<ReportsSheet> createState() => _ReportsSheetState();
}

class _ReportsSheetState extends State<ReportsSheet> {
  late Future<List<ReportModel>> _reportsFuture;

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  void _loadReports() {
    setState(() {
      _reportsFuture = DatabaseHelper.instance.getAllReports();
    });
  }

  @override
  void didUpdateWidget(covariant ReportsSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.refreshTrigger != oldWidget.refreshTrigger) {
      _loadReports();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.25,
      maxChildSize: 0.95,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.12),
                blurRadius: 10,
                offset: const Offset(0, -2),
              )
            ],
          ),
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              Expanded(
                child: FutureBuilder<List<ReportModel>>(
                  future: _reportsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    else if (snapshot.hasError) {
                      return Center(child: Text("حدث خطأ: ${snapshot.error}"));
                    }

                    else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person_off_outlined,
                                size: 60,
                                color: AppColors.black.withOpacity(0.3)),
                            const SizedBox(height: 10),
                            Text(
                              "لا يوجد مفقودين حالياً",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    }

                    final reports = snapshot.data!;

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("كل البلاغات (${reports.length})",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                  ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            controller: scrollController,
                            padding: const EdgeInsets.all(10),
                            itemCount: reports.length,
                            itemBuilder: (context, index) {
                              final report = reports[index];
                              return MissingPersonCard(
                                name: report.name,
                                description: report.description,
                                location: report.location,
                                time: report.time,
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}