import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'student_directory_screen.dart';
import 'class_schedule_screen.dart';
import 'lesson_plan_screen.dart';
import 'profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teacher Dashboard',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => DashboardScreen(),
        '/student_directory': (context) => StudentDirectoryScreen(),
        '/class_schedule': (context) => ClassScheduleScreen(),
        '/lesson_plan': (context) => LessonPlanScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}
