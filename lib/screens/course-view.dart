import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:randomize_me/shared/layout/simple_layout.dart';
import '../provider/course-provider.dart';

class CourseViewer extends StatefulWidget {
  final String courseId;

  CourseViewer({Key? key, required this.courseId}) : super(key: key);

  @override
  _CourseViewerState createState() => _CourseViewerState();
}

class _CourseViewerState extends State<CourseViewer> {
  int indexOfSelectedTask = -1;
  Timer? _timer;
  int _counter = 0;


  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final course = Provider.of<CourseProvider>(context).getSpecificCourse(
        widget.courseId);
    return SimpleLayout(layout: Center(
      child: Container(
        alignment: Alignment.topCenter,
        width: 500,
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (indexOfSelectedTask == -1) {
                    startTimer();
                  }
                  indexOfSelectedTask++;
                  if (indexOfSelectedTask >
                      course!.courseTasks.length - 1) {
                    indexOfSelectedTask = -1;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'You Successfully Finished the Course in $_counter seconds')),
                    );
                    _timer?.cancel();
                    _counter = 0;
                  }
                });
              },
              child: indexOfSelectedTask == -1
                  ? const Text('Start')
                  : const Text('Next Task'),
            ),
            const SizedBox(height: 30),
            Text(
              '$_counter seconds',
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueAccent),
            ),
            const SizedBox(height: 30),
            ListView.separated(
              shrinkWrap: true,
              itemCount: course!.courseTasks.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    course.courseTasks[index],
                    style: indexOfSelectedTask == index
                        ? const TextStyle(fontWeight: FontWeight.bold)
                        : null,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
            ),
          ],
        ),
      ),
    ), title: course.courseName);
  }
}
