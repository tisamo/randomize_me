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





}
