import 'package:flutter/material.dart';
import 'package:music_app/architect.dart';
import 'package:provider/provider.dart';

import '../../global.dart';

class MusicDetail extends StatelessWidget {
  const MusicDetail({Key? key, required this.response}) : super(key: key);
  final MusicModel response;
  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(builder: (context, music, child) {
      music.setAudio(response.source.toString());
      return WillPopScope(
        onWillPop: () async {
          music.resetData();
          music.audioPlayer.stop();
          Navigator.pop(context);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Music Playing"),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.info_outline_rounded))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    height: height / 2.75,
                    response.image.toString(),
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      "assets/images/icon.png",
                      height: height / 2.75,
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Text(
                  response.title.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  response.artist.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Slider(
                    value: music.position.inSeconds.toDouble(),
                    min: 0,
                    activeColor: AppColors.appColor,
                    max: music.duration.inSeconds.toDouble(),
                    onChanged: (value) async {
                      final position = Duration(seconds: value.toInt());
                      await music.audioPlayer.seek(position);
                      await music.audioPlayer.resume();
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(formatTime(music.position)),
                      Text(formatTime(music.duration - music.position)),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () async {
                        music.audioPlayer
                            .seek(music.position - const Duration(seconds: 10));
                      },
                      icon: const Icon(Icons.replay_10_rounded),
                      iconSize: 34,
                    ),
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: AppColors.appColor,
                      child: IconButton(
                        onPressed: () async {
                          if (music.isPlaying) {
                            await music.audioPlayer.pause();
                          } else {
                            await music.audioPlayer.resume();
                          }
                        },
                        icon: Icon(
                            music.isPlaying ? Icons.pause : Icons.play_arrow),
                        iconSize: 50,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        music.audioPlayer
                            .seek(music.position + const Duration(seconds: 10));
                      },
                      icon: const Icon(Icons.forward_10_rounded),
                      iconSize: 34,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = twoDigits(duration.inHours);
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, twoDigitMinutes, twoDigitSeconds]
        .join(':');
  }
}
