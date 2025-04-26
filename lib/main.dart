import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:garbage_noti_app/pages/userRole.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:garbage_noti_app/pages/userReg.dart'; // Your user registration page
// import 'package:garbage_noti_app/pages/role_selection.dart'; // Your RoleSelectionScreen
// import 'package:garbage_noti_app/pages/userHome.dart'; // Create this
// import 'package:garbage_noti_app/pages/driverHome.dart'; // Create this

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  final role = prefs.getString('role');
  final userId = prefs.getString('userId');

  Widget _defaultHome = RoleSelectionScreen();

  if (isLoggedIn) {
    if (role == 'user' && userId != null) {
      _defaultHome = UserProfileScreen(userId: userId);
    }
    // else {
    //   _defaultHome = UserHomePage();
    // }
  } else {
    _defaultHome = RoleSelectionScreen();
  }

  runApp(MyApp(defaultHome: _defaultHome));
}

class MyApp extends StatelessWidget {
  final Widget defaultHome;

  const MyApp({required this.defaultHome, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Garbage Truck Notifier',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: defaultHome,
    );
  }
}
