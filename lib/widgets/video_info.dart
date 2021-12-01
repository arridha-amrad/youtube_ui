import 'package:flutter/material.dart';
import "package:timeago/timeago.dart" as timeago;
import '../data.dart';

class VideoInfo extends StatelessWidget {
  final Video video;
  const VideoInfo({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            video.title,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 15.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8.0),
          Text("${video.viewCount} • ${timeago.format(video.timestamp)}",
              style: Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: 14.0,
                  ))
        ],
      ),
    );
  }
}
