import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:music_app/architect.dart';
import 'package:http/http.dart' as http;

class PlaylistProvider extends ChangeNotifier {
  List<MusicModel> musicData = [];
  List<MusicModel> searchMusicData = [];

  TextEditingController searchController = TextEditingController();
  bool isSearch = false;
  bool isLoading = false;

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

  void resetData() {
    isPlaying = false;
    duration = Duration.zero;
    position = Duration.zero;
  }

  void setSearch(bool val) {
    isSearch = val;
    notifyListeners();
  }

  void setLoading(bool val) {
    isLoading = val;
  }

  void setSearchData(List<MusicModel> data) {
    musicData = data;
    notifyListeners();
  }

  Future<void> getMusicData() async {
    setLoading(true);
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
      setLoading(false);
      notifyListeners();
    } catch (e) {
      setLoading(false);
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
