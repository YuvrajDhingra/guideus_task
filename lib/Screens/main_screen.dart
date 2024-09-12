import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guideus_task/Screens/post_screen.dart';
import 'package:guideus_task/main.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'GuideUs',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10.sp,
              ),
            ),
            centerTitle: true,
          ),
          body: IndexedStack(
            index: appState.currentIndex,
            children: const [
              PostScreen(postType: 'text'),
              PostScreen(postType: 'video'),
              PostScreen(postType: 'image'),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: appState.currentIndex,
            onTap: (index) => appState.setIndex(index),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.text_fields), label: 'Text'),
              BottomNavigationBarItem(icon: Icon(Icons.video_library), label: 'Video'),
              BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Image'),
            ],
          ),
        );
      },
    );
  }
}