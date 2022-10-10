import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_flutter/tools/commom/win_media.dart';

class VideoPlayPage extends StatefulWidget {
  final String url;

  VideoPlayPage(this.url);

  @override
  State<VideoPlayPage> createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  final FijkPlayer player = FijkPlayer();

  @override
  void initState() {
    super.initState();
    player.setOption(FijkOption.hostCategory, "enable-snapshot", 1);
    player.setOption(FijkOption.playerCategory, "mediacodec-all-videos", 1);
    startPlay();
  }

  void startPlay() async {
    await player.setOption(FijkOption.hostCategory, "request-screen-on", 1);
    await player.setOption(FijkOption.hostCategory, "request-audio-focus", 1);
    await player.setDataSource(widget.url, autoPlay: true).catchError((e) {
      print("setDataSource error: $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// 视频播放器位置
          SizedBox(
            width: winWidth(context),
            height: winHeight(context),
            child: Center(
              child: FijkView(
                player: player,
                panelBuilder: fijkPanel2Builder(snapShot: true),
                fsFit: FijkFit.fill,
                // panelBuilder: simplestUI,
                // panelBuilder: (FijkPlayer player, BuildContext context,
                //     Size viewSize, Rect texturePos) {
                //   return CustomFijkPanel(
                //       player: player,
                //       buildContext: context,
                //       viewSize: viewSize,
                //       texturePos: texturePos);
                // },
              ),
            ),
          ),

          /// 控件位置
          SafeArea(
            child: Text(
              '我是空间',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }
}