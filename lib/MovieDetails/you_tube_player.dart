import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:project/api/api.dart';
import 'package:flutter/services.dart';

class MovieTrailerWidget extends StatefulWidget {
  final int movieID;
  final String? posterPath;

  const MovieTrailerWidget({super.key, required this.movieID, required this.posterPath});

  @override
  MovieTrailerWidgetState createState() => MovieTrailerWidgetState();
}

class MovieTrailerWidgetState extends State<MovieTrailerWidget>


  with SingleTickerProviderStateMixin {
  YoutubePlayerController? _controller;
  String _videoKey = "";
  bool _isControllerInitialized = false;
  bool _isVideoEnded = false;

  @override
  void initState() {
    super.initState();
    loadKey();
  }

  Future<void> loadKey() async {
    try {
      final String? videoKey = await getKey();
      if (videoKey != null) {
        if (mounted) {
          setState(() {
            _videoKey = videoKey;
            _controller = YoutubePlayerController(
              initialVideoId: _videoKey,
              flags: const YoutubePlayerFlags(
                enableCaption: true,
                autoPlay: false,
                mute: false,
                forceHD: true,
              ),
            )..addListener(_videoListener);
            _isControllerInitialized = true;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _isControllerInitialized = true;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isControllerInitialized = true;
        });
      }
    }
  }

  void _videoListener() {
    if (_controller != null &&
        _controller!.value.playerState == PlayerState.ended) {
      if (mounted) {
        setState(() {
          _isVideoEnded = true;
        });
      }
    } else if (_controller != null &&
        _controller!.value.playerState == PlayerState.playing) {
      if (mounted) {
        setState(() {
          _isVideoEnded = false;
        });
      }
    }
  }

  Future<String?> getKey() async {
    return await API().fetchTrailerKey(widget.movieID);
  }

  @override
  Widget build(BuildContext context) {
    return _isControllerInitialized
        ? _videoKey.isNotEmpty
            ? YoutubePlayer(
                thumbnail: Image.network(
                  'https://image.tmdb.org/t/p/w500${widget.posterPath}}',
                  fit: BoxFit.cover,
                ),
                controlsTimeOut: const Duration(milliseconds: 1800),
                aspectRatio: 16 / 9,
                controller: _controller!,
                showVideoProgressIndicator: true,
                bufferIndicator: Container(
                  color: Colors.black,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                progressIndicatorColor: Theme.of(context).primaryColor,
                bottomActions: [
                  CurrentPosition(),
                  ProgressBar(
                    isExpanded: true,
                    colors: ProgressBarColors(
                      playedColor: Colors.white,
                      handleColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  RemainingDuration(),
                  if (_isVideoEnded)
                    IconButton(
                      icon: const Icon(Icons.replay),
                      onPressed: () {
                        _controller!.seekTo(Duration.zero);
                        _controller!.play();
                      },
                    )
                  else
                    FullScreenButton(),
                ],
              )
            : Container(
                height: 200,
                color: Colors.black,
                child: const Center(
                  child: Text(
                    "Este vídeo no está disponible..",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              )
        : Container(
            height: 200,
            color: Colors.black,
          );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _controller?.dispose();
    super.dispose();
  }
}
