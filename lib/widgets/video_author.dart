import 'package:flutter/material.dart';
import 'package:youtube_ui/data.dart';

class VideoAuthor extends StatelessWidget {
  final Video video;
  const VideoAuthor({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        foregroundImage: NetworkImage(video.author.profileImageUrl),
      ),
      title: Text(
        video.author.username,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
      ),
      subtitle: Text(video.author.subscribers),
      trailing: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: TextButton(
            onPressed: () {},
            child: Text(
              "subscribe".toUpperCase(),
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w500),
            )),
      ),
    );
  }
}
