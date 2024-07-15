import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:randomize_me/provider/course-provider.dart';
import 'package:randomize_me/provider/theme-provider.dart';
import 'package:randomize_me/services/course_service.dart';
import 'package:randomize_me/shared/layout/simple_layout.dart';

import '../models/couse.dart';
import '../shared/Texts/themes.dart';
import '../shared/course_card.dart';

class CourseBrowser extends StatefulWidget {
  const CourseBrowser({Key? key}) : super(key: key);

  @override
  State<CourseBrowser> createState() => _CourseBrowserState();
}

class _CourseBrowserState extends State<CourseBrowser>
    with TickerProviderStateMixin {
  Timer? _debounce;

  late TabController _tabController;
  late Future<List<Course>> popularCourses;
  late Future<List<Course>> recentCourses;
  Future<void>? debounce;

  final searchInput = TextEditingController();
  var searchString = '';

  @override
  void initState() {
    super.initState();
    popularCourses = CourseService.getNewestCourses();
    recentCourses = CourseService.getNewestCourses();
    searchInput.addListener(() {
      _onSearchChanged();
    });
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  _onSearchChanged() {
    if (_debounce?.isActive == true ) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      setState(() {
        searchString = searchInput.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    CourseProvider courseProvider =
        Provider.of<CourseProvider>(context, listen: false);
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return SimpleLayout(
      customAppBar: AppBar(
        title: const Text('Course Browser'),
        actions: [
          IconButton(
              onPressed: () => {themeProvider.changeTheme()},
              icon: themeProvider.themeDataStyle == lightTheme
                  ? const Icon(Icons.dark_mode)
                  : const Icon(Icons.sunny)),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
                icon: Icon(Icons.star, color: Colors.white),
                text: "Most liked"),
            Tab(icon: Icon(Icons.timer, color: Colors.white), text: "Recent"),
            Tab(
                icon: Icon(Icons.search, color: Colors.white),
                text: "Search Course"),
          ],
        ),
      ),
      title: 'Course Browser',
      layout: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: TabBarView(
          controller: _tabController,
          children: [
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600),
                child: Column(
                  children: [
                    Expanded(
                      child: FutureBuilder<List<dynamic>>(
                        future: popularCourses,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<dynamic>> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext context, int index) {
                                final course = snapshot.data?[index];
                                if (course != null) {
                                  return CourseCard(
                                    course: course,
                                    courseProvider: courseProvider,
                                    type: 'browser',
                                  );
                                } else {
                                  return const Placeholder();
                                }
                              },
                            );
                          } else if (snapshot.hasError) {
                            print(snapshot.error);
                            return const Icon(Icons.error_outline);
                          } else {
                            return const Center(
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600),
                child: Column(
                  children: [
                    Expanded(
                      child: FutureBuilder<List<dynamic>>(
                        future: recentCourses,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<dynamic>> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext context, int index) {
                                final course = snapshot.data?[index];
                                if (course != null) {
                                  return CourseCard(
                                    course: course,
                                    courseProvider: courseProvider,
                                    type: 'browser',
                                  );
                                } else {
                                  return const Placeholder();
                                }
                              },
                            );
                          } else if (snapshot.hasError) {
                            print(snapshot.error);
                            return const Icon(Icons.error_outline);
                          } else {
                            return const Center(
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 0, bottom: 10),
                        child: TextFormField(
                          controller: searchInput,
                          decoration:
                              InputDecoration(labelText: 'Type here to search'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        )),
                    Expanded(
                      child: FutureBuilder<List<dynamic>>(
                        future: CourseService.searchCourses(searchString),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<dynamic>> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext context, int index) {
                                final course = snapshot.data?[index];
                                if (course != null) {
                                  return CourseCard(
                                    course: course,
                                    courseProvider: courseProvider,
                                    type: 'browser',
                                  );
                                } else {
                                  return const Placeholder();
                                }
                              },
                            );
                          } else if (snapshot.hasError) {
                            print(snapshot.error);
                            return const Icon(Icons.error_outline);
                          } else {
                            return const Center(
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
