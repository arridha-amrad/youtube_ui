import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_ui/data.dart';
import 'package:youtube_ui/widgets/custom_sliver_appbar.dart';
import 'package:youtube_ui/widgets/video_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      const CustomSliverAppBar(),
      SliverPadding(
        padding: const EdgeInsets.only(
            bottom: 60.0), // since min-heihgt miniplayer is set to 60,
        sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            final video = videos[index];
            return VideoCard(video: video);
          },
          childCount: videos.length,
        )),
      )
    ]));
  }
}
