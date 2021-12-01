import 'package:flutter/material.dart';
import 'package:youtube_ui/data.dart';

class VideoActionRow extends StatelessWidget {
  final Video video;
  const VideoActionRow({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _actionButton(context, Icons.thumb_up_alt_outlined, video.likes),
        _actionButton(context, Icons.thumb_down_alt_outlined, video.dislikes),
        _actionButton(context, Icons.reply, "Share"),
        _actionButton(context, Icons.download_outlined, "Download"),
        _actionButton(context, Icons.library_add_outlined, "Save"),
      ],
    );
  }

  Widget _actionButton(BuildContext context, IconData icon, String label) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Icon(icon),
          const SizedBox(
            height: 8.0,
          ),
          Text(label)
        ],
      ),
    );
  }
}
