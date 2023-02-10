import 'package:flutter/material.dart';
import 'package:flutter_parralax_ui/src/videoParralax/video_card.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.8);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final videos = [
    'assets/videos/video_1.mp4',
    'assets/videos/video_2.mp4',
    'assets/videos/video_3.mp4',
    'assets/videos/video_4.mp4',
    'assets/videos/video_5.mp4',
    'assets/videos/video_6.mp4',
  ];

  final images = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/5.jpg',
    'assets/images/6.jpg',
    'assets/images/7.jpg',
    'assets/images/8.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: PageView.builder(
              controller: _pageController,
              itemCount: videos.length,
              onPageChanged: (index) => setState(() => _selectedIndex = index),
              itemBuilder: (context, index) {
                return VideoCard(
                  assetPath: videos[index],
                  isSelected: _selectedIndex == index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
