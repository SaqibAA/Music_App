import 'package:flutter/material.dart';
import 'package:music_app/architect.dart';
import 'package:music_app/global.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlaylistProvider>(context, listen: false);
    provider.getMusicData();

    return Consumer<PlaylistProvider>(builder: (context, playlist, child) {
      return Scaffold(
        appBar: AppBar(
          title: playlist.isSearch
              ? TextFormField(
                  cursorColor: AppColors.whiteColor,
                  style: textStyle(null, AppColors.whiteColor),
                  onChanged: playlist.onSerachMusic,
                  decoration: InputDecoration(
                    hintText: "Search Song",
                    hintStyle: textStyle(null, AppColors.whiteColor),
                    border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.whiteColor)),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.whiteColor)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.whiteColor)),
                  ),
                )
              : const Text("My Music Playlist"),
          actions: [
            IconButton(
                onPressed: () {
                  if (playlist.isSearch) {
                    playlist.setSearch(false);
                  } else {
                    playlist.setSearch(true);
                  }
                },
                icon: Icon(
                    playlist.isSearch ? Icons.cancel_rounded : Icons.search))
          ],
        ),
        body: playlist.isLoading
            ? const Center(child: CircularProgressIndicator())
            : playlist.musicData.isEmpty
                ? Center(
                    child: Text(
                      'Data Not Available',
                      style: textStyle(16),
                    ),
                  )
                : ListView.builder(
                    itemCount: playlist.musicData.length,
                    itemBuilder: (context, index) {
                      final data = playlist.musicData;
                      return InkWell(
                        onTap: () {
                          swithScreenPush(
                              context, MusicDetail(response: data[index]));
                        },
                        child: Container(
                          height: height * 0.1,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.appColorFull.shade100
                                  .withOpacity(0.1)),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  "${data[index].image}",
                                  height: height * 0.07,
                                  width: height * 0.07,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                    "assets/images/icon.png",
                                    height: height * 0.07,
                                    width: height * 0.07,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: width * 0.06),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${data[index].title}",
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          textStyle(20, null, FontWeight.w500),
                                    ),
                                    SizedBox(height: height * 0.01),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          "${data[index].artist}",
                                          overflow: TextOverflow.ellipsis,
                                          style: textStyle(16),
                                        )),
                                        SizedBox(width: width * 0.02),
                                        Expanded(
                                            child: Text(
                                          "${data[index].album}",
                                          overflow: TextOverflow.ellipsis,
                                          style: textStyle(16),
                                        )),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
      );
    });
  }
}
