import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:randomize_me/models/couse.dart';
import 'package:randomize_me/provider/course-provider.dart';

class NewCoursePage extends StatefulWidget {
  final String courseId;

  const NewCoursePage({Key? key, required this.courseId}) : super(key: key);

  @override
  _NewCourseState createState() => _NewCourseState();
}

class _NewCourseState extends State<NewCoursePage> {
  final courseNameController = TextEditingController();
  final courseDescription = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _controllers = [];
  final List<Widget> _formFields = [];
  late Course courseToEdit;


  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    courseNameController.dispose();
    courseDescription.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if(widget.courseId != 'new'){
      CourseProvider courseProvider = Provider.of<CourseProvider>(context, listen: false);
      Course? course = courseProvider.getSpecificCourse(widget.courseId);
      if(course != null){
        courseToEdit = course;
        courseNameController.value = TextEditingValue(text: course.courseName);
        courseDescription.value = TextEditingValue(text: course.description);
        for (var element in course.courseTasks) {
          _addFormField(element);
        }
      }

    }

  }


  void _removeFormField(int index) {
    setState(() {
      if (index >= 0 && index < _controllers.length) {
        _controllers[index].dispose();
        _controllers.removeAt(index);
        _formFields.removeAt(index);
        for (int i = 0; i < _formFields.length; i++) {
          final controller = _controllers[i];
          _formFields[i] = Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(labelText: 'Field ${i + 1}'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                IconButton(
                  onPressed: () => _removeFormField(i),
                  icon: const Icon(Icons.remove),
                ),
              ],
            ),
          );
        }
      }
    });
  }

  void _addFormField([initialValue = '']) {
    final controller = TextEditingController();
    controller.value = TextEditingValue(text: initialValue);
    final index = _controllers.length;

    setState(() {
      _controllers.add(controller);
      _formFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(labelText: 'Description of the task ${index + 1}'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            IconButton(
              onPressed: () => _removeFormField(index),
              icon: const Icon(Icons.remove),
            ),
          ],
        ),
      ));
    });
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
       Course course = Course(id: '2' , courseName: courseNameController.text, description: courseDescription.text, type: 'workout', difficulty: 'basic', courseTasks: []);
      for (var controller in _controllers) {
        course.courseTasks.add(controller.text);
      }
      CourseProvider courseProvider = Provider.of<CourseProvider>(context, listen: false);
      late String text;
      if(widget.courseId == 'new'){
        final courseId = courseProvider.courses.length;
        course.id = courseId.toString();
        courseProvider.addCourse(course);
        text = 'New Course Has Been created';
      } else{
        course.id = widget.courseId;
        courseProvider.overrideCourse(widget.courseId, course);
        text = 'Course Has Been modified';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:  Text(text)),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Builder'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: courseNameController,
                  decoration: const InputDecoration(labelText: 'Course Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (value.length < 10) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: courseDescription,
                  decoration: const InputDecoration(labelText: 'Description of course'),
                  validator: (value) {
                    if (value == null || value.length < 10) {
                      return 'Must be at least 20 characters!';
                    }
                    return null;
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _formFields.length,
                  itemBuilder: (context, index) {
                    return _formFields[index];
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _addFormField,
                child: const Text('Add Field'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
