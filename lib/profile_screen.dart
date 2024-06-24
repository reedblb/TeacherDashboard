import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: Text('Profile'),
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
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/profile_picture.jpg'),
            ),
            SizedBox(height: 20),
            Text(
              'Mr. Ben Louie',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Teacher',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildProfileItem('Email', 'ben.louie@example.com'),
                  _buildProfileItem('Phone', '+1 234 567 890'),
                  _buildProfileItem('Address', '1234 School St, Hometown, USA'),
                  // Add more profile items as needed
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

  Widget _buildProfileItem(String title, String content) {
    return Card(
      child: ListTile(
        title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(content, style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
