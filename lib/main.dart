import 'package:flutter/material.dart';
import 'db_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teacher Dashboard',
      theme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Roboto',
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
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
            _buildDrawerItem(Icons.schedule, 'Schedule', context, ScheduleScreen()),
            _buildDrawerItem(Icons.assignment, 'Lesson Plan', context, LessonPlanScreen()),
            _buildDrawerItem(Icons.people, 'Students', context, StudentsScreen()),
            _buildDrawerItem(Icons.person, 'Profile', context, ProfileScreen()),
            _buildDrawerItem(Icons.checklist, 'To Do List', context, ToDoListScreen()),
          ],
        ),
      ),
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
          CircleAvatar(
            backgroundImage: AssetImage('assets/profile_picture.jpg'),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: <Widget>[
            _buildDashboardCard('Calendar', Icons.calendar_today, Colors.red, context, CalendarScreen()),
            _buildDashboardCard('Easy Access Files', Icons.folder_open, Colors.purple, context, EasyAccessFilesScreen()),
            _buildDashboardCard('Class Registry', Icons.class_, Colors.green, context, ClassRegistryScreen()),
            _buildDashboardCard('To Do List', Icons.checklist, Colors.blue, context, ToDoListScreen()),
            _buildDashboardCard('Important Dates', Icons.date_range, Colors.orange, context, ImportantDatesScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, BuildContext context, Widget screen) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
    );
  }

  Widget _buildDashboardCard(String title, IconData icon, Color color, BuildContext context, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
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
            ],
          ),
        ),
      ),
    );
  }
}

class ClassRegistryScreen extends StatefulWidget {
  @override
  _ClassRegistryScreenState createState() => _ClassRegistryScreenState();
}

class _ClassRegistryScreenState extends State<ClassRegistryScreen> {
  final DBHelper _dbHelper = DBHelper();
  List<Map<String, dynamic>> _classes = [];

  @override
  void initState() {
    super.initState();
    _refreshClassList();
  }

  void _refreshClassList() async {
    final data = await _dbHelper.queryAllClasses();
    setState(() {
      _classes = data;
    });
  }

  void _addClass() async {
    await _dbHelper.insertClass({
      'name': 'New Class',
      'description': 'Class Description',
    });
    _refreshClassList();
  }

  void _deleteClass(int id) async {
    await _dbHelper.deleteClass(id);
    _refreshClassList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Class Registry'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addClass,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _classes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_classes[index]['name']),
            subtitle: Text(_classes[index]['description']),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteClass(_classes[index]['id']),
            ),
          );
        },
      ),
    );
  }
}

class ScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
      ),
      body: Center(
        child: Text('Schedule Screen'),
      ),
    );
  }
}

class LessonPlanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lesson Plan'),
      ),
      body: Center(
        child: Text('Lesson Plan Screen'),
      ),
    );
  }
}

class StudentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
      ),
      body: Center(
        child: Text('Students Screen'),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}

class ToDoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
      ),
      body: Center(
        child: Text('To Do List Screen'),
      ),
    );
  }
}

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Center(
        child: Text('Calendar Screen'),
      ),
    );
  }
}

class EasyAccessFilesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Easy Access Files'),
      ),
      body: Center(
        child: Text('Easy Access Files Screen'),
      ),
    );
  }
}

class ImportantDatesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Important Dates'),
      ),
      body: Center(
        child: Text('Important Dates Screen'),
      ),
    );
  }
}
class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;

  static Database? _database;

  DBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'class_registry.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE class_registry (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT
      )
    ''');
  }

  Future<int> insertClass(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('class_registry', row);
  }

  Future<List<Map<String, dynamic>>> queryAllClasses() async {
    Database db = await database;
    return await db.query('class_registry');
  }

  Future<int> updateClass(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row['id'];
    return await db.update('class_registry', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteClass(int id) async {
    Database db = await database;
    return await db.delete('class_registry', where: 'id = ?', whereArgs: [id]);
  }
}
