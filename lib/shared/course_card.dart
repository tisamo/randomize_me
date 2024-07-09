import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:randomize_me/models/couse.dart';
import 'package:randomize_me/provider/course-provider.dart';
import 'package:randomize_me/shared/text_styles.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final CourseProvider courseProvider;

  const CourseCard({
    super.key,
    required this.courseProvider,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left side image
        Expanded(
          flex: 2,
          child: Image.network(
            'https://cdn.iconscout.com/icon/premium/png-512-thumb/bicep-muscle-2121276-1785235.png?f=webp&w=256',
            fit: BoxFit.contain,
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.courseName,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Text('Difficulty:' + course.difficulty),
                    SizedBox(width: 8.0),
                    Text('Type:' + course.type),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  course.description,
                  maxLines: 2, // Adjust as needed
                  overflow: TextOverflow.ellipsis,
                ),
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, '/courses/train/${course.id}');
                }, child: const Padding(padding: EdgeInsets.only(top: 20),child: Align(alignment:Alignment.centerLeft,child: Text('Train', style: AppTextStyles.mediumBold )), ))
              ],
            ),
          ),
        ),
        Expanded(flex: 1,
          child: Column(
            children: [
              IconButton(onPressed: () {
                Navigator.pushNamed(context, '/course/${course.id}');
              }, icon: const Icon(Icons.edit)),
              course.id == courseProvider.selectedCourse?.id ? const Text ('Selected', style: AppTextStyles.simpleBold,)
                  :IconButton(onPressed: () {
                Course courseToSet = courseProvider.getSpecificCourse(course.id);
                courseProvider.selectCourse(courseToSet);
              }, icon: const Icon(Icons.check))
            ],
          ),)
      ],
    ),
    ]
    );

  }
}
