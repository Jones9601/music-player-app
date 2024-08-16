import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:samplemusicapp/constants/music_constant.dart';
import 'package:samplemusicapp/constants/tab_view_constant.dart';
import 'package:samplemusicapp/models/music_item_model.dart';
import 'package:samplemusicapp/utils/color_resource.dart';
import 'package:samplemusicapp/utils/container_extention.dart';
import 'package:samplemusicapp/utils/sized_box_extentions.dart';

import 'models/bottom_tab_model.dart';
import 'utils/image_resource.dart';
import 'widgets/custom_image.dart';
import 'widgets/music_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int tabIndex = 0;

  bool isPlaying = false;
  int selectedIndex = -1;
  AudioPlayer? player;
  AssetSource? path;
  Duration _duration = const Duration();
  Duration _position = const Duration();
  List<MusicItem> musicData = MusicConstant.musicDummyData;

  Future initPlayer(String url) async {
    player?.dispose();
    player = AudioPlayer();
    path = AssetSource(url);

    player?.onDurationChanged.listen((Duration d) {
      setState(() => _duration = d);
    });
    player?.onPositionChanged.listen((Duration p) {
      setState(() => _position = p);
    });
    player?.onPlayerComplete.listen((_) {
      setState(() => _position = _duration);
    });
    player?.play(path ?? AssetSource(""));
    isPlaying = true;
  }

  void playPause() async {
    if (isPlaying) {
      player?.pause();
      isPlaying = false;
    } else {
      player?.play(path ?? AssetSource(""));
      isPlaying = true;
    }
    setState(() {});
  }

  @override
  void dispose() {
    player?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerView(),
      body: bodyView(),
      bottomNavigationBar: navigationBarItem(),
    );
  }

  Column bodyView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: musicData.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    initPlayer(musicData[index].url);
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ImageResource.musicBg),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        if (selectedIndex != -1) playerDetailsView()
      ],
    );
  }

  Container playerDetailsView() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorResource.color76878F,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          musicData[selectedIndex].artist,
                          style: const TextStyle(
                              fontSize: 14, color: ColorResource.colorFFF),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          musicData[selectedIndex].title,
                          style: const TextStyle(
                              fontSize: 12, color: ColorResource.color42AD9E),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                MusicDetailsView(
                  isPlay: isPlaying,
                  musicItem: musicData[selectedIndex],
                  clickLike: () {
                    musicData[selectedIndex].isLike =
                        !musicData[selectedIndex].isLike;
                    setState(() {});
                  },
                  clickPlay: playPause,
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
            child: Slider(
              value: _position.inSeconds.toDouble(),
              onChanged: (value) async {
                await player?.seek(Duration(seconds: value.toInt()));
                setState(() {});
              },
              min: 0,
              max: _duration.inSeconds.toDouble(),
              activeColor: ColorResource.color42AD9E,
              inactiveColor: ColorResource.color2B3A3E,
            ),
          )
        ],
      ),
    );
  }

  AppBar headerView() {
    return AppBar(
      backgroundColor: ColorResource.color76878F,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
      ),
      leading: const Padding(
        padding: EdgeInsets.only(left: 12.0),
        child: CustomImage(
          image: ImageResource.arreVoiceHeader,
          width: 55,
          height: 35,
        ),
      ),
      actions: [
        const CustomImage(
          image: ImageResource.notificationHeader,
          width: 32,
          height: 32,
        ),
        12.width,
        const CustomImage(
          image: ImageResource.chatHeader,
          width: 32,
          height: 32,
        ),
        12.width,
      ],
    );
  }

  Widget navItem(BottomTabBarModel item, int index) {
    return GestureDetector(
      onTap: () => setState(() => tabIndex = index),
      child: (item.isProfile ?? false)
          ? Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                color: ColorResource.colorFFF,
              ),
              child: const Icon(Icons.person),
            )
          : Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: (item.isCenter ?? false) ? Colors.red : null,
                borderRadius: const BorderRadius.all(
                  Radius.circular(24),
                ),
                gradient: (item.isCenter ?? false)
                    ? Container().getLinearGradient()
                    : null,
              ),
              padding:
                  (item.isCenter ?? false) ? const EdgeInsets.all(10) : null,
              child: Center(
                child: CustomImage(
                  image: item.tabName,
                  width: 28,
                  height: 28,
                  color: tabIndex == index || index == 2
                      ? ColorResource.colorFFF
                      : ColorResource.color1E1E1E,
                ),
              ),
            ),
    );
  }

  Widget navigationBarItem() {
    return Container(
      margin: EdgeInsets.only(
        bottom: Platform.isAndroid ? 16 : 0,
      ),
      child: ClipRRect(
        borderRadius: selectedIndex != -1
            ? BorderRadius.zero
            : const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
        child: BottomAppBar(
          color: ColorResource.color76878F,
          shape: const CircularNotchedRectangle(),
          elevation: 0.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  TabViewConstant.tabData.length,
                  (index) {
                    return navItem(TabViewConstant.tabData[index], index);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
