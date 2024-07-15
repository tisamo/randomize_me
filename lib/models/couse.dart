import 'dart:convert';

class Course {
  late final String id;
  final String courseName;
  final String description;
  final String type;
  final String difficulty;
  final List<String> courseTasks;

  Course({
    required this.id,
    required this.courseName,
    required this.description,
    required this.type,
    required this.difficulty,
    required this.courseTasks,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'].toString(),
      courseName: json['courseName'],
      description: json['description'],
      type: json['type'],
      difficulty: json['difficulty'],
      courseTasks: List<String>.from(json['courseTasks']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'courseName': courseName,
    'description': description,
    'type': type,
    'difficulty': difficulty,
    'courseTasks': courseTasks,
  };
  static String listToJson(List<Course> courses) => json.encode(List<dynamic>.from(courses.map((course) => course.toJson())));
  static List<Course> listFromJson(String str) => List<Course>.from(json.decode(str).map((x) => Course.fromJson(x)));
}
