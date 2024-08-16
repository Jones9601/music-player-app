import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:samplemusicapp/utils/container_extention.dart';
import 'package:samplemusicapp/utils/sized_box_extentions.dart';

import '../models/music_item_model.dart';
import '../utils/color_resource.dart';
import '../utils/image_resource.dart';
import 'custom_image.dart';

class MusicDetailsView extends StatelessWidget {
  final bool isPlay;
  final MusicItem musicItem;
  final GestureTapCallback clickLike;
  final GestureTapCallback clickPlay;

  const MusicDetailsView({
    super.key,
    required this.isPlay,
    required this.musicItem,
    required this.clickLike,
    required this.clickPlay,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          InkWell(
            onTap: clickLike,
            child: Icon(
              Icons.heart_broken,
              size: 30,
              color: musicItem.isLike ? Colors.red : Colors.white,
            ),
          ),
          8.width,
          InkWell(
            onTap: clickPlay,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: Container().getLinearGradient(),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Icon(
                (isPlay) ? Icons.pause : Icons.play_arrow_rounded,
                size: 30,
                color: ColorResource.colorFFF,
              ),
            ),
          ),
          8.width,
          const CustomImage(image: ImageResource.menu),
        ],
      ),
    );
  }
}
