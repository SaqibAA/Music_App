import 'package:flutter/material.dart';
import 'package:music_app/architect.dart';

class Utils {
  static snackBarSuccessfull(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: AppColors.appColor,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      content: SelectableText(
        message,
        style: const TextStyle(color: AppColors.whiteColor),
      ),
    ));
  }

  static snackBarError(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      content: SelectableText(
        message,
        style: const TextStyle(color: AppColors.whiteColor),
      ),
    ));
  }

  static String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = twoDigits(duration.inHours);
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, twoDigitMinutes, twoDigitSeconds]
        .join(':');
  }

  static musicDetails(context, MusicModel details) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Music Information'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Song     : ${details.title}'),
                Text('Artist    : ${details.artist}'),
                Text('Album   : ${details.album}'),
                Text('Genre    : ${details.genre}'),
                const Text('Format  : MP3'),
                Text(
                    'Duration: ${formatTime(Duration(seconds: details.duration!))}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
