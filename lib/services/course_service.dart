

import 'package:line_icons/line_icon.dart';
import 'package:randomize_me/http-client/http-client.dart';
import 'package:randomize_me/models/couse.dart';

class CourseService{
  static Future<List<Course>> getPopularCourse() async {
    return await HttpClient.makeGetRequest('courses/popular', (json) => Course.fromJson(json)) as List<Course>;
}
  static Future<List<Course>> getNewestCourses() async {
    return await HttpClient.makeGetRequest('courses/new', (json) => Course.fromJson(json)) as List<Course>;
  }
  static Future<List<Course>> searchCourses(String searchString) async {
    if(searchString.isEmpty){
      return await HttpClient.makeGetRequest('courses/popular', (json) => Course.fromJson(json)) as List<Course>;
    }
    return await HttpClient.makeGetRequest('courses/search?q=$searchString', (json) => Course.fromJson(json)) as List<Course>;
  }
}