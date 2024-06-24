import 'package:flutter/material.dart';

class LessonPlanScreen extends StatefulWidget {
  @override
  _LessonPlanScreenState createState() => _LessonPlanScreenState();
}

class _LessonPlanScreenState extends State<LessonPlanScreen> {
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: Text('Lesson Plans'),
        actions: [
          Switch(
            value: isAdmin,
            onChanged: (value) {
              setState(() {
                isAdmin = value;
              });
            },
            activeColor: Colors.green,
            inactiveThumbColor: Colors.red,
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/profile_picture.jpg'),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Academic Year 2024-2025',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: <Widget>[
                  _buildTermCard('Term 1'),
                  _buildTermCard('Term 2'),
                  _buildTermCard('Term 3'),
                  _buildTermCard('Lesson Plan Archives'),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _buildBrowseCard('Browse by Curriculum'),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildBrowseCard('Browse by Grade Level'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/profile_picture.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'MR. BEN LOUIE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildDrawerItem(Icons.dashboard, 'Dashboard', context, '/'),
          _buildDrawerItem(Icons.schedule, 'Schedule', context, '/class_schedule'),
          _buildDrawerItem(Icons.assignment, 'Lesson Plan', context, '/lesson_plan'),
          _buildDrawerItem(Icons.people, 'Students', context, '/student_directory'),
          _buildDrawerItem(Icons.person, 'Profile', context, '/profile'),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, BuildContext context, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }

  Widget _buildTermCard(String term) {
    return GestureDetector(
      onTap: () {
        // Navigate to detailed term view
      },
      child: Card(
        color: Colors.pinkAccent,
        child: Center(
          child: Text(
            term,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildBrowseCard(String browseOption) {
    return GestureDetector(
      onTap: () {
        // Navigate to browse option view
      },
      child: Card(
        color: Colors.purpleAccent,
        child: Center(
          child: Text(
            browseOption,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
