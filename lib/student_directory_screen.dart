import 'package:flutter/material.dart';

class StudentDirectoryScreen extends StatefulWidget {
  @override
  _StudentDirectoryScreenState createState() => _StudentDirectoryScreenState();
}

class _StudentDirectoryScreenState extends State<StudentDirectoryScreen> {
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: Text('Student Directory'),
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
              'Year 12',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: <Widget>[
                  _buildClassCard('Class 12 A', Colors.amber),
                  _buildClassCard('Class 12 B', Colors.pinkAccent),
                  _buildClassCard('Class 12 C', Colors.greenAccent),
                  _buildClassCard('Class 12 D', Colors.blueAccent),
                  _buildClassCard('Consolidated Class Record', Colors.orangeAccent),
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

  Widget _buildClassCard(String className, Color color) {
    return GestureDetector(
      onTap: () {
        // Navigate to detailed class view
      },
      child: Card(
        color: color,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Text(
                  className.split(' ')[1],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Text(
                className,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
