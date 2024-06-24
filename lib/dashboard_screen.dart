import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'package:csv/csv.dart';
import 'dart:io';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isAdmin = false;

  final List<String> toDoList = [
    'Check assignments',
    'Prepare lesson plan',
    'Update grades',
    'Attend meeting',
  ];

  final List<String> importantDates = [
    'Parent-Teacher meeting - 3rd July',
    'Science fair - 10th July',
    'Sports day - 15th July',
  ];

  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  List<List<dynamic>> studentRecords = [];

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    monthController.text = DateFormat.MMMM().format(now);
    yearController.text = DateFormat.y().format(now);
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      final input = file.openRead();
      final fields = await input.transform(utf8.decoder).transform(CsvToListConverter()).toList();
      setState(() {
        studentRecords = fields;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.search),
          ),
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
            if (isAdmin)
              ElevatedButton(
                onPressed: _pickFile,
                child: Text("Upload CSV"),
              ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _buildDashboardCard(
                      'Calendar',
                      Icons.calendar_today,
                      Colors.red,
                      context,
                      child: _buildCalendar(),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDashboardCard(
                      'Easy Access Files',
                      Icons.folder_open,
                      Colors.purple,
                      context,
                      child: Container(), // Add relevant content here
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _buildDashboardCard(
                      'To Do List',
                      Icons.checklist,
                      Colors.blue,
                      context,
                      child: _buildToDoList(toDoList),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDashboardCard(
                      'Important Dates',
                      Icons.date_range,
                      Colors.orange,
                      context,
                      child: _buildImportantDates(importantDates),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDashboardCard(
                      'Class Registry',
                      Icons.class_,
                      Colors.green,
                      context,
                      child: _buildClassRegistry(),
                    ),
                  ),
                ],
              ),
            ),
            if (studentRecords.isNotEmpty)
              Expanded(
                child: _buildStudentRecordsTable(),
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

  Widget _buildDashboardCard(String title, IconData icon, Color color, BuildContext context, {Widget? child}) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              if (child != null) ...[
                SizedBox(height: 20),
                Expanded(child: child),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: isAdmin
                  ? TextField(
                      controller: monthController,
                      decoration: InputDecoration(hintText: 'Month'),
                    )
                  : Text(monthController.text),
            ),
            SizedBox(width: 8),
            Expanded(
              child: isAdmin
                  ? TextField(
                      controller: yearController,
                      decoration: InputDecoration(hintText: 'Year'),
                    )
                  : Text(yearController.text),
            ),
          ],
        ),
        SizedBox(height: 16),
        Expanded(
          child: Table(
            border: TableBorder.all(color: Colors.red),
            children: List.generate(6, (index) {
              return TableRow(
                children: List.generate(7, (index) {
                  return Container(
                    height: 40,
                    child: Center(child: Text('')),
                  );
                }),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildToDoList(List<String> toDoList) {
    return ListView.builder(
      itemCount: toDoList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.check_circle_outline, color: Colors.white),
          title: isAdmin
              ? TextField(
                  decoration: InputDecoration(hintText: toDoList[index]),
                  onChanged: (value) {
                    setState(() {
                      toDoList[index] = value;
                    });
                  },
                )
              : Text(toDoList[index], style: TextStyle(color: Colors.white)),
        );
      },
    );
  }

  Widget _buildImportantDates(List<String> importantDates) {
    return ListView.builder(
      itemCount: importantDates.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.event, color: Colors.white),
          title: isAdmin
              ? TextField(
                  decoration: InputDecoration(hintText: importantDates[index]),
                  onChanged: (value) {
                    setState(() {
                      importantDates[index] = value;
                    });
                  },
                )
              : Text(importantDates[index], style: TextStyle(color: Colors.white)),
        );
      },
    );
  }

  Widget _buildClassRegistry() {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(backgroundImage: AssetImage('assets/profile_picture.jpg')),
          title: isAdmin
              ? TextField(
                  decoration: InputDecoration(hintText: 'Grade 12A'),
                  onChanged: (value) {
                    setState(() {
                      // Logic to update Grade 12A text
                    });
                  },
                )
              : Text('Grade 12A', style: TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: CircleAvatar(backgroundImage: AssetImage('assets/profile_picture.jpg')),
          title: isAdmin
              ? TextField(
                  decoration: InputDecoration(hintText: 'Grade 12B'),
                  onChanged: (value) {
                    setState(() {
                      // Logic to update Grade 12B text
                    });
                  },
                )
              : Text('Grade 12B', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildStudentRecordsTable() {
    return ListView.builder(
      itemCount: studentRecords.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Row(
            children: studentRecords[index].map<Widget>((item) {
              return Expanded(
                child: Text(
                  item.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
