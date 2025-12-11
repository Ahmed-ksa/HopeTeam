class ReportModel {
  final int? id;
  final String name;
  final String age;
  final String healthStatus;
  final String location;
  final String time;
  final String relationship;
  final String reporterID;
  final String description;
  final String? imagePath;

  ReportModel({
    this.id,
    required this.name,
    required this.age,
    required this.healthStatus,
    required this.location,
    required this.time,
    required this.relationship,
    required this.reporterID,
    required this.description,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'healthStatus': healthStatus,
      'location': location,
      'time': time,
      'relationship': relationship,
      'reporterID': reporterID,
      'description': description,
      'imagePath': imagePath,
    };
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      healthStatus: map['healthStatus'],
      location: map['location'],
      time: map['time'],
      relationship: map['relationship'],
      reporterID: map['reporterID'],
      description: map['description'],
      imagePath: map['imagePath'],
    );
  }

}

