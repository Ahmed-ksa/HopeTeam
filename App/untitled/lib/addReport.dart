import 'package:flutter/material.dart';
import 'myWidgets/customTextField.dart';
import 'myWidgets/imageUploadBox.dart';
import 'myWidgets/infoAlertBox.dart';
import 'myWidgets/sectionTitle.dart';
import 'utilities.dart';
import 'backend/db_helper.dart';
import 'backend/report_model.dart';

class AddReport extends StatefulWidget {
  const AddReport({super.key});

  @override
  State<AddReport> createState() => _AddReportState();
}

class _AddReportState extends State<AddReport> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _healthController = TextEditingController();
  final _locationController = TextEditingController();
  final _timeController = TextEditingController();
  final _relationshipController = TextEditingController();
  final _reporterIdController = TextEditingController();
  final _descController = TextEditingController();

  String? _selectedImagePath;

  String? _selectedCity;
  String? _selectedRelationship;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _healthController.dispose();
    _locationController.dispose();
    _timeController.dispose();
    _relationshipController.dispose();
    _reporterIdController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _saveReport() async {
    if (_nameController.text.isEmpty ||
        _ageController.text.isEmpty ||
        _healthController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _timeController.text.isEmpty ||
        _relationshipController.text.isEmpty ||
        _reporterIdController.text.isEmpty ||
        _descController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يرجى تعبئة البيانات كاملة")),
      );
      return;
    }

    final report = ReportModel(
      name: _nameController.text,
      age: _ageController.text,
      healthStatus: _healthController.text,
      location: _locationController.text,
      time: _timeController.text,
      relationship: _relationshipController.text,
      reporterID: _reporterIdController.text,
      description: _descController.text,
      imagePath: _selectedImagePath,
    );

    await DatabaseHelper.instance.createReport(report);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.green,
            content: Text("تم أشعار جميع المستخدمين المتواجدين بالقرب من أخر موقع شوهد فيه المفقود!")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إضافة بلاغ جديد"),
        centerTitle: true,
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: _saveReport,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryGreen,
            foregroundColor: AppColors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
          ),
          icon: const Icon(Icons.send_rounded),
          label: const Text(
            "إرسال البلاغ للنشر",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100), // مسافة سفلية
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const InfoAlertBox(
              message: "يرجى تعبئة البيانات بدقة لضمان سرعة المساعدة.",
            ),
            const SizedBox(height: 20),

            const SectionTitle(title: "بيانات المفقود الأساسية", icon: Icons.person_pin),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomTextField(
                      label: "اسم المفقود الرباعي",
                      icon: Icons.person,
                      controller: _nameController,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: "العمر",
                            icon: Icons.cake,
                            isNumeric: true,
                            controller: _ageController,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: "الحالة الصحية",
                      icon: Icons.medical_services_outlined,
                      // maxLines: 2,
                      controller: _healthController,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            const SectionTitle(title: "تفاصيل الفقدان ومقدم البلاغ", icon: Icons.location_on_outlined),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomTextField(
                      label: "موقع الفقدان",
                      icon: Icons.location_city,
                      controller: _locationController,
                      items: cities,
                      initialValue: _selectedCity,
                      onChanged: (value) {
                        setState(() {
                          _selectedCity = value;
                          _locationController.text = value ?? "";
                        });
                      },
                    ),
                    const SizedBox(height: 15),

                    CustomTextField(
                      label: "وقت الفقدان التقريبي",
                      icon: Icons.access_time_filled,
                      controller: _timeController,
                      isTimePicker: true,
                    ),
                    const SizedBox(height: 15),

                    CustomTextField(
                      label: "صلة القرابة",
                      icon: Icons.family_restroom,
                      controller: _relationshipController,
                      items: family,
                      initialValue: _selectedRelationship,
                      onChanged: (value) {
                        setState(() {
                          _selectedRelationship = value;
                          _relationshipController.text = value ?? "";
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: "رقم هوية مقدم البلاغ",
                      icon: Icons.credit_card,
                      isNumeric: true,
                      controller: _reporterIdController,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            const SectionTitle(title: "الوصف والمرفقات", icon: Icons.description_outlined),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomTextField(
                      label: "وصف دقيق للمفقود",
                      icon: Icons.short_text,
                      maxLines: 1,
                      controller: _descController,
                    ),
                    const SizedBox(height: 20),
                    ImageUploadBox(
                      onTap: () {
                        debugPrint("هنا يتم استدعاء ImagePicker لاحقاً");
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}