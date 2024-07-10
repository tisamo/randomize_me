
import 'package:flutter/material.dart';
import 'package:randomize_me/shared/layout/simple_layout.dart';

class CourseBrowser  extends StatefulWidget {
  const CourseBrowser ({Key? key}) : super(key: key);

  @override
  State<CourseBrowser> createState() => _State();
}

class _State extends State<CourseBrowser> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleLayout(customAppBar: AppBar(
      title: Text('Tabbar'),
      bottom: TabBar(
        controller: _tabController,
        tabs: const[
          Tab(icon: Icon(Icons.directions_car), text: "Car"),
          Tab(icon: Icon(Icons.directions_transit), text: "Transit"),
          Tab(icon: Icon(Icons.directions_bike), text: "Bike"),
        ],
      ),
    ),title: 'Course Browser',
      layout: TabBarView(
        controller: _tabController,
        children: const [
          Center(child: Text('Car Tab')),
          Center(child: Text('Transit Tab')),
          Center(child: Text('Bike Tab')),
        ],
      ),
    );
  }
}
