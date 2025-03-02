import 'package:flutter/material.dart';
import 'package:good_food/features/auth_modul/screen/auth_fill_info_page.dart';
import 'package:good_food/features/auth_modul/screen/first_page.dart';
import 'package:good_food/features/driver%20modul/driver_main_page.dart';
import 'package:good_food/features/free_food_module/screen/free_food_detail_page.dart';
import 'package:good_food/features/free_food_module/screen/free_food_main.dart';
import 'package:good_food/features/customer_module/customer_main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_food/features/setting_module/setting_main_page.dart';
import 'package:provider/provider.dart';
import 'features/free_food_module/provider/addFreeFoodProvider.dart';
import 'features/auth_modul/provider/auth_provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => addFreeFoodProvider()),
        ChangeNotifierProvider(create: (_) => authProvider()),
      ],
      child: MyApp(), 
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jom Makan!',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => first_page(),
        '/home': (context) => MyHomePage(),
        '/signup': (context) => auth_fill_info_page(),
      },
      // home: AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Show loading
        }
        if (snapshot.hasData) {
          return MyHomePage(); // 🔥 User is logged in, go to main app
        } else {
          return first_page(); // 🔥 User NOT logged in, go to login page
        }
      },
    );
  }
}


class MyHomePage extends StatefulWidget {

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    customer_main_page(),
    FreeFoodHome(),
    driver_main_page(),
    setting_main_page()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home, 
                color: _selectedIndex == 0 ? Colors.blue : Colors.grey),
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: Icon(Icons.search, 
                color: _selectedIndex == 1 ? Colors.blue : Colors.grey),
              onPressed: () => _onItemTapped(1),
            ),
            IconButton(
              icon: Icon(Icons.map, 
                color: _selectedIndex == 2 ? Colors.blue : Colors.grey),
              onPressed: () => _onItemTapped(2),
            ),
            IconButton(
              icon: Icon(Icons.person, 
                color: _selectedIndex == 3 ? Colors.blue : Colors.grey),
              onPressed: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}
