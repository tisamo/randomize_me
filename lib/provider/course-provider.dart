import 'package:flutter/cupertino.dart';
import 'package:randomize_me/models/couse.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourseProvider with ChangeNotifier {
  List<Course> _courses = [];
  Course? selectedCourse;
  List<Course> get courses => _courses;

  CourseProvider() {
    loadCourses();
  }
  


  Future<void> loadCourses() async {
    final prefs = await SharedPreferences.getInstance();
    String? coursesJson = prefs.getString('courses');
    if (coursesJson != null) {
      _courses = Course.listFromJson(coursesJson);
      notifyListeners();
    }
  }

 Course? getSpecificCourse(id) {
   return _courses.singleWhere((Course element) => element.id == id);
  }

   overrideCourse(id, Course course){
    final index = _courses.indexWhere((Course element) => element.id == id);
    _courses[index] = course;
    notifyListeners();
  }

  void selectCourse(selectedCourse){
    this.selectedCourse = selectedCourse;
    notifyListeners();
  }

  Future<void> saveCourses() async {
    final prefs = await SharedPreferences.getInstance();
    String coursesJson = Course.listToJson(_courses);
    await prefs.setString('courses', coursesJson);
  }

  void addCourse(Course course) {
    _courses.add(course);
    saveCourses();
    notifyListeners();
  }

  void removeCourse(Course course) {
    _courses.remove(course);
    saveCourses();
    notifyListeners();
  }
}
