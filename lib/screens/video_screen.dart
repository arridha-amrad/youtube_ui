import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:youtube_ui/data.dart';
import 'package:youtube_ui/screens/nav_screen.dart';
import 'package:youtube_ui/widgets/video_action.dart';
import 'package:youtube_ui/widgets/video_author.dart';
import 'package:youtube_ui/widgets/video_card.dart';
import 'package:youtube_ui/widgets/video_info.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  ScrollController? _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context
          .read(miniPlayerControllerProvider)
          .state
          .animateToHeight(state: PanelState.MAX),
      child: Scaffold(
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Consumer(builder: (context, watch, _) {
                  final selectedVideo = watch(selectedVideoProvider).state;
                  return SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Image.network(
                              selectedVideo!.thumbnailUrl,
                              height: 220.0,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            IconButton(
                                onPressed: () => context
                                    .read(miniPlayerControllerProvider)
                                    .state
                                    .animateToHeight(state: PanelState.MIN),
                                icon: const Icon(Icons.keyboard_arrow_down))
                          ],
                        ),
                        const LinearProgressIndicator(
                          value: 0.4,
                          valueColor: AlwaysStoppedAnimation(Colors.red),
                        ),
                        VideoInfo(video: selectedVideo),
                        const SizedBox(
                          height: 10.0,
                        ),
                        VideoActionRow(
                          video: selectedVideo,
                        ),
                        const SizedBox(
                          height: 7.0,
                        ),
                        VideoAuthor(video: selectedVideo)
                      ],
                    ),
                  );
                }),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                final video = suggestedVideos[index];
                return VideoCard(
                    video: video,
                    isHasPadding: true,
                    onTap: () => _scrollController!.animateTo(0,
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.easeIn));
              }, childCount: suggestedVideos.length))
            ],
          ),
        ),
      ),
    );
  }
}
