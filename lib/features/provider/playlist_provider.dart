import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:music_app/architect.dart';
import 'package:http/http.dart' as http;

class PlaylistProvider extends ChangeNotifier {
  List<MusicModel> musicData = [];
  List<MusicModel> searchMusicData = [];
  int musicIndex = 0;

  TextEditingController searchController = TextEditingController();
  bool isSearch = false;
  bool isLoading = false;

  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool isShuffle = false;
  bool isLoop = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  Future<void> setAudio() async {
    // Repeat song when completed
    audioPlayer.setReleaseMode(ReleaseMode.stop);
    await audioPlayer.setSourceUrl(musicData[musicIndex].source!);

    audioPlayer.onPlayerStateChanged.listen(
      (state) {
        isPlaying = state == PlayerState.playing;
      },
    );

    audioPlayer.onPlayerComplete.listen(
      (event) {},
    );

// listen to audio duration
    audioPlayer.onDurationChanged.listen((newDuration) {
      duration = newDuration;
    });

    // listen to audio position
    audioPlayer.onPositionChanged.listen((newPosition) {
      position = newPosition;
    });
    notifyListeners();
  }

  void setLoopMode() {
    isLoop = !isLoop;
    if (isLoop) {
      audioPlayer.setReleaseMode(ReleaseMode.loop);
    } else {
      audioPlayer.setReleaseMode(ReleaseMode.stop);
    }
    notifyListeners();
  }

  void setIndex(int index) {
    musicIndex = index;
    print("object  $index");
    notifyListeners();
  }

  void setShuffle() {
    isShuffle = !isShuffle;
    // if (isShuffle) {
    //   musicData.shuffle();
    // } else {}

    notifyListeners();
  }

  void resetData() {
    isPlaying = false;
    duration = Duration.zero;
    position = Duration.zero;
  }

  void setSearch() {
    isSearch = !isSearch;
    notifyListeners();
  }

  void setLoading() {
    isLoading = !isLoading;
  }

  void setSearchData(List<MusicModel> data) {
    musicData = data;
    notifyListeners();
  }

  Future<void> getMusicData() async {
    setLoading();
    const url = "https://storage.googleapis.com/uamp/catalog.json";
    Uri uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);
        final result = json['music'] as List<dynamic>;
        musicData = result.map((e) {
          return MusicModel.fromJson(e);
        }).toList();
        searchMusicData = musicData;
      }
      setLoading();
      notifyListeners();
    } catch (e) {
      setLoading();
      notifyListeners();
      if (kDebugMode) {
        print(e);
      }
      throw ("Error on Data fetching");
    }
  }

  onSerachMusic(String text) {
    final List<MusicModel> filter = [];
    searchMusicData.map((value) {
      if (value.title!.toLowerCase().contains(text.toString().toLowerCase()) ||
          value.album!.toLowerCase().contains(text.toString().toLowerCase()) ||
          value.artist!.toLowerCase().contains(text.toString().toLowerCase())) {
        filter.add(value);
      }
    }).toList();
    setSearchData(filter);
  }
}
