import 'dart:convert';
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:randomize_me/models/couse.dart';
import 'package:randomize_me/provider/nav-provider.dart';
import 'package:randomize_me/provider/course-provider.dart';
import 'package:randomize_me/resoursces/init-courses.dart';
import 'package:randomize_me/screens/course-view.dart';
import 'package:randomize_me/screens/courses.dart';
import 'package:randomize_me/screens/home.dart';
import 'package:randomize_me/screens/new-course.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final courses = prefs.getString('courses');
  if(courses.isUndefinedOrNull){
    String coursesJson = Course.listToJson(initCourses);
    await prefs.setString('courses', coursesJson);
  }
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => NavProvider()),
          ChangeNotifierProvider(create: (_) => CourseProvider()),
        ],
        child: MaterialApp(
        onGenerateRoute: RouteGenerator.generateRoute));
  }
  }

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Uri uri = Uri.parse(settings.name ?? '');
    switch (uri.path) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Home());
      case '/courses':
        return MaterialPageRoute(builder: (_) => const CourseScreen());
      default:
        if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'course') {
          final id = uri.pathSegments[1];
          return MaterialPageRoute(
            builder: (_) => NewCoursePage(courseId: id),
          );
        }
        if (uri.pathSegments.length == 3 && uri.pathSegments[1] == 'train' && uri.pathSegments[0] == 'courses') {
          final id = uri.pathSegments.last;
          return MaterialPageRoute(
            builder: (_) => CourseViewer(courseId: id),
          );
        }

        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR: Route not found!'),
        ),
      );
    });
  }
}



