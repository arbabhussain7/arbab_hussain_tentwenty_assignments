import 'package:dio_rest_api/features/movies/domain/entities/video_entity.dart';
import 'package:dio_rest_api/utils/app_colord.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FullMovieScreen extends StatefulWidget {
  const FullMovieScreen({super.key});

  @override
  State<FullMovieScreen> createState() => _FullMovieScreenState();
}

class _FullMovieScreenState extends State<FullMovieScreen> {
  late YoutubePlayerController _controller;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      final video = ModalRoute.of(context)?.settings.arguments as VideoEntity?;

      if (video != null) {
        _controller = YoutubePlayerController(
          initialVideoId: video.key,
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
            enableCaption: true,
            isLive: false,
            forceHD: false,
          ),
        );
        _isInitialized = true;
      }
    }
  }

  @override
  void dispose() {
    if (_isInitialized) {
      _controller.dispose();
    }
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Scaffold(
        backgroundColor: blackColor,
        body: const Center(
          child: Text(
            'No video available',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      backgroundColor: blackColor,
      body: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: blueColor,
          progressColors: ProgressBarColors(
            playedColor: blueColor,
            handleColor: blueColor,
          ),
          onReady: () {
            _controller.addListener(() {});
          },
        ),
        builder: (context, player) {
          return Column(
            children: [
              SafeArea(
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),

              Expanded(child: Center(child: player)),
            ],
          );
        },
      ),
    );
  }
}
