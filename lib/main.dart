import 'package:flutter/material.dart';
import 'package:guideus_task/Screens/main_screen.dart';
import 'package:guideus_task/Screens/post_screen.dart';
import 'package:guideus_task/Screens/unknown_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MyApp(),
    ),
  );
}

class AppState extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GuideUs',
        theme: ThemeData(
          primaryColor: const Color(0xFF4CAF50),
          hintColor: const Color(0xFF2196F3),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF4CAF50),
            elevation: 0,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Color(0xFF4CAF50),
            unselectedItemColor: Colors.grey,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF2196F3),
            ),
          ),
        ),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          if (settings.name == '/') {
            return MaterialPageRoute(builder: (context) => const MainScreen());
          }

          final uri = Uri.parse(settings.name!);
          final postType = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : 'unknown';
          if (['text', 'video', 'image'].contains(postType)) {
            return MaterialPageRoute(
              builder: (context) => PostScreen(postType: postType),
            );
          }

          return MaterialPageRoute(builder: (context) => const UnknownScreen());
        },
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

