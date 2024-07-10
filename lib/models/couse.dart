import 'dart:convert';

class Course {
  String id;
  String courseName;
  String description;
  String type;
  String difficulty;
  List<String> courseTasks;

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
      id: json['id'],
      courseName: json['courseName'],
      description: json['description'],
      type: json['type'],
      difficulty: json['difficulty'],
      courseTasks: List<String>.from(
        json['courseTasks'].map((task) => CourseTask.fromJson(task)),
      ),
    );
  }


  Map<String, dynamic> toJson() => {
    'id': id,
    'courseName': courseName,
    'description': description,
    'type': type,
    'difficulty': difficulty,
    'courseTasks': List<String>.from(courseTasks.map((task) => task)),
  };

  static String listToJson(List<Course> courses) => json.encode(List<dynamic>.from(courses.map((course) => course.toJson())));
  static List<Course> listFromJson(String str) => List<Course>.from(json.decode(str).map((x) => Course.fromJson(x)));
}

class CourseTask {
  CourseTask({
    required this.description,
  });

  String description;

  factory CourseTask.fromJson(Map<String, dynamic> json) {
    return CourseTask(
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
    'description': description,
  };
}