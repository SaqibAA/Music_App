import 'package:flutter/material.dart';
import 'package:music_app/architect.dart';
import 'package:provider/provider.dart';

import '../../global.dart';

class MusicDetail extends StatelessWidget {
  const MusicDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(builder: (context, music, child) {
      music.setAudio();
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
                  onPressed: () {
                    Utils.musicDetails(
                        context, music.musicData[music.musicIndex]);
                  },
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
                    music.musicData[music.musicIndex].image.toString(),
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
                  music.musicData[music.musicIndex].title.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  music.musicData[music.musicIndex].artist.toString(),
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
                      Text(Utils.formatTime(music.position)),
                      Text(Utils.formatTime(music.duration)),
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
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () async {
                        music.setLoopMode();
                      },
                      icon: const Icon(Icons.loop_rounded),
                      iconSize: 34,
                      color: music.isLoop ? AppColors.appColor : null,
                    ),
                    IconButton(
                      onPressed: () async {
                        music.setShuffle();
                      },
                      icon: Icon(Icons.shuffle_rounded,
                          color: music.isShuffle ? AppColors.appColor : null),
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
}
