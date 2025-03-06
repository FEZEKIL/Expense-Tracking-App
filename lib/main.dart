import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import 'providers/expense_provider.dart';
import 'screens/category_management_screen.dart';
import 'screens/home_screen.dart';
import 'screens/tag_management.dart'; // Ensure this import is correct

// Declare the localStorage variable
late LocalStorage localStorage;

// Define the initLocalStorage function
Future<void> initLocalStorage() async {
  localStorage = LocalStorage('expense_app');
  await localStorage.ready;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage(); // Initialize localStorage

  runApp(MyApp(localStorage: localStorage));
}

class MyApp extends StatelessWidget {
  final LocalStorage localStorage;

  const MyApp({Key? key, required this.localStorage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExpenseProvider(localStorage)),
      ],
      child: MaterialApp(
        title: 'Expense Tracker',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(), // Main entry point, HomeScreen
          '/manage_categories': (context) =>
              const CategoryManagementScreen(), // Route for managing categories
          '/manage_tags': (context) =>
              const TagManagementScreen(), // Route for managing tags
        },
        // Removed 'home:' since 'initialRoute' is used to define the home route
      ),
    );
  }
}