import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:youtube_ui/screens/home_screen.dart';
import 'package:youtube_ui/screens/video_screen.dart';

import '../data.dart';

final selectedVideoProvider = StateProvider<Video?>((ref) => null);

final miniPlayerControllerProvider =
    StateProvider.autoDispose((ref) => MiniplayerController());

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;
  static const double _playerMinHeight = 60.0;

  final _screens = [
    const HomeScreen(),
    const Scaffold(
      body: Center(
        child: Text("Explorer"),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text("Add"),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text("Subscriptions"),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text("Library"),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, watch, _) {
          final selectedVideo = watch(selectedVideoProvider).state;
          final miniPlayerController =
              watch(miniPlayerControllerProvider).state;
          return Stack(
              children: _screens
                  .asMap()
                  .map(
                    (key, value) => MapEntry(
                      key,
                      Offstage(
                        offstage: _selectedIndex != key,
                        child: value,
                      ),
                    ),
                  )
                  .values
                  .toList()
                ..add(Offstage(
                  offstage: selectedVideo ==
                      null, // this view is hidden if selected video = null
                  child: Miniplayer(
                    controller: miniPlayerController,
                    minHeight: _playerMinHeight,
                    maxHeight: MediaQuery.of(context).size.height,
                    builder: (height, percentage) {
                      if (selectedVideo == null) {
                        return const SizedBox.shrink();
                      }
                      if (height <= _playerMinHeight + 50.0) {
                        return MinimizedVideo(
                            selectedVideo: selectedVideo,
                            playerMinHeight: _playerMinHeight);
                      }
                      return const VideoScreen();
                    },
                  ),
                )));
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        selectedFontSize: 10,
        unselectedFontSize: 10,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_filled),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore),
              label: "Explore"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              activeIcon: Icon(Icons.add_circle),
              label: "Add"),
          BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions_outlined),
              activeIcon: Icon(Icons.subscriptions),
              label: "Subcriptions"),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_library_outlined),
              activeIcon: Icon(Icons.video_library),
              label: "Library"),
        ],
      ),
    );
  }
}

class MinimizedVideo extends StatelessWidget {
  const MinimizedVideo({
    Key? key,
    required this.selectedVideo,
    required double playerMinHeight,
  })  : _playerMinHeight = playerMinHeight,
        super(key: key);

  final Video selectedVideo;
  final double _playerMinHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(children: [
          Row(
            children: [
              Image.network(
                selectedVideo.thumbnailUrl,
                width: 120.0,
                height: _playerMinHeight - 4.0,
                fit: BoxFit.cover,
              ),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                                child: Text(selectedVideo.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis)),
                            const SizedBox(height: 4.0),
                            Flexible(
                                child: Text(selectedVideo.author.username,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400)))
                          ]))),
              IconButton(onPressed: () {}, icon: const Icon(Icons.play_arrow)),
              IconButton(
                  onPressed: () =>
                      context.read(selectedVideoProvider).state = null,
                  icon: const Icon(Icons.close))
            ],
          ),
          const LinearProgressIndicator(
            value: 0.4,
            valueColor: AlwaysStoppedAnimation(Colors.red),
          )
        ]));
  }
}
