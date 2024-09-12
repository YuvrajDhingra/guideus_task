import 'package:flutter/material.dart';
import 'package:guideus_task/Screens/video_post_content.dart';
import 'package:guideus_task/main.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Post {
  final String type;
  final String content;

  Post({required this.type, required this.content});
}

class PostScreen extends StatelessWidget {
  final String postType;

  const PostScreen({super.key, required this.postType});

  @override
  Widget build(BuildContext context) {
    Post post = _getPost(postType);
    return _buildPostContent(context, post);
  }

  Post _getPost(String type) {
    switch (type) {
      case 'text':
        return Post(type: 'text', content: 'This is a sample text post for GuideUs. It demonstrates how text content would appear in the app.');
      case 'video':
        return Post(type: 'video', content: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
      case 'image':
        return Post(type: 'image', content: 'assets/sample.jpg');
      default:
        return Post(type: 'unknown', content: 'Unknown post type');
    }
  }

  Widget _buildPostContent(BuildContext context, Post post) {
    Widget content;
    switch (post.type) {
      case 'text':
        content = Text(post.content, style: TextStyle(fontSize: 16.sp));
        break;
      case 'video':
        content = VideoPostContent(videoUrl: post.content);
        break;
      case 'image':
        content = Image.network(post.content, fit: BoxFit.cover);
        break;
      default:
        content = const Text('Unknown post type');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${post.type.capitalize()} Post'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                content,
                SizedBox(height: 20.h),
                ElevatedButton.icon(
                  icon: const Icon(Icons.share),
                  label: const Text('Share'),
                  onPressed: () => _sharePost(post),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _sharePost(Post post) {
    final String customUrl = 'guideus://${post.type}';
    final String vercelUrl = 'https://guide-us-task-website.vercel.app/${post.type}';
    final String shareMessage = 'Check out this ${post.type} post on GuideUs: $customUrl\n\nIf the app is not installed, visit: $vercelUrl';
    Share.share(shareMessage);
  }
}
