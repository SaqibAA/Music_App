import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:music_app/architect.dart';
import 'package:http/http.dart' as http;

class PlaylistProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  bool isSearch = false;

  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  Future<void> setAudio(String url) async {
    // Repeat song when completed
    audioPlayer.setReleaseMode(ReleaseMode.stop);
    await audioPlayer.setSourceUrl(url);

    audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
    });

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

  void setPlayState() {
    audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
    });
    notifyListeners();
  }

  void setDuration() {
// listen to audio duration
    audioPlayer.onDurationChanged.listen((newDuration) {
      duration = newDuration;
    });
    notifyListeners();
  }

  void setPosition() {
    // listen to audio position
    audioPlayer.onPositionChanged.listen((newPosition) {
      position = newPosition;
    });
    notifyListeners();
  }

  void setSearch(bool val) {
    isSearch = val;
    notifyListeners();
  }

  Future<List<MusicModel>> getMusicData() async {
    const url = "https://storage.googleapis.com/uamp/catalog.json";
    Uri uri = Uri.parse(url);
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);
        final result = json['music'] as List<dynamic>;
        final musicList = result.map((e) {
          return MusicModel.fromJson(e);
        }).toList();
        return musicList;
      } else {
        return throw ("Error on Data fetching");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return throw ("Error on Data fetching");
    }
  }
}
