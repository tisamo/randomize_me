import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:randomize_me/shared/course_card.dart';
import '../provider/course-provider.dart';
import '../shared/elements/BottomNav.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Courses'),
            automaticallyImplyLeading: false,
          ),
          bottomNavigationBar: const BottomNav(),
          body: Consumer<CourseProvider>(
            builder: (context, courseProvider, child) => Center(
              child: SizedBox(
                width: screenWidth < 600 ? screenWidth : 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Select Your Desired Course',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Flexible(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: courseProvider.courses.length,
                        itemBuilder: (context, index) {
                          final course = courseProvider.courses[index];
                          return CourseCard(course: course, courseProvider: courseProvider,);
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: Colors.grey,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/course/new');

                      },
                      child: const Text('Add New Course'),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        );
  }
}
