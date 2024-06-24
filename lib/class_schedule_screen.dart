import 'package:flutter/material.dart';

class ClassScheduleScreen extends StatefulWidget {
  @override
  _ClassScheduleScreenState createState() => _ClassScheduleScreenState();
}

class _ClassScheduleScreenState extends State<ClassScheduleScreen> {
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: Text('Class Schedule & Lesson'),
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
              'Reminders:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              '- Writing Task #1\n- Evaluation Demo Period 4',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _buildDayColumn('MON', Colors.red),
                      _buildDayColumn('TUE', Colors.blue),
                      _buildDayColumn('WED', Colors.green),
                      // Add more days as needed
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      _buildPeriodCard('Period 1: 7:00 - 8:00\nGrade 12A', Colors.yellow),
                      _buildPeriodCard('Period 2: 8:00 - 9:00\nGrade 12B', Colors.orange),
                      // Add more periods as needed
                    ],
                  ),
                ),
              ],
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

  Widget _buildDayColumn(String day, Color color) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.only(bottom: 16.0),
      child: Center(
        child: Text(
          day,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildPeriodCard(String periodInfo, Color color) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.only(bottom: 16.0),
      child: Center(
        child: Text(
          periodInfo,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
