import 'package:dio_rest_api/features/movies/domain/entities/video_entity.dart';
import 'package:dio_rest_api/utils/app_colord.dart';
import 'package:dio_rest_api/utils/app_size.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerDialog extends StatefulWidget {
  final VideoEntity video;
  final VoidCallback onFullScreen;

  const TrailerDialog({
    super.key,
    required this.video,
    required this.onFullScreen,
  });

  @override
  State<TrailerDialog> createState() => _TrailerDialogState();
}

class _TrailerDialogState extends State<TrailerDialog> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.key,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: blackColor,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.v),
        decoration: BoxDecoration(
          color: blackColor,
          borderRadius: BorderRadius.circular(12.adaptSize),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Video Player
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: blueColor,
              progressColors: ProgressBarColors(
                playedColor: blueColor,
                handleColor: blueColor,
              ),
            ),

            SizedBox(height: 12.v),

            // Controls Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Close button
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: whiteColor,
                    size: 28.adaptSize,
                  ),
                ),

                // Video title
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.h),
                    child: Text(
                      widget.video.name,
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 14.fSize,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),

                // Fullscreen button
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    widget.onFullScreen();
                  },
                  child: Icon(
                    Icons.crop_free_rounded,
                    color: whiteColor,
                    size: 28.adaptSize,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
