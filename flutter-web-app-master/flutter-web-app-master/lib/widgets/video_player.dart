import 'package:chewie/chewie.dart';
// ignore: implementation_imports
import 'package:chewie/src/chewie_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';



class ChewieVideo extends StatefulWidget {
  final Size screenSize;
  const ChewieVideo({
    Key? key,
    required this.screenSize,
  }) : super(key: key);  @override
  State<StatefulWidget> createState() {
    return _ChewieVideoState();
  }
}

class _ChewieVideoState extends State<ChewieVideo> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 2.1,
      autoPlay: true,
      looping: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: Colors.transparent,
        bufferedColor: Colors.lightGreen,
      ),
      placeholder: Container(
        color: Colors.transparent,
      ),
      autoInitialize: true,

    );

  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(
        left:this.widget.screenSize.width/10,
        right: this.widget.screenSize.width/10,
        top:this.widget.screenSize.height/20,
      ),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: this.widget.screenSize.height/2,
                width: this.widget.screenSize.width/2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                  child: Chewie(
                    controller: _chewieController,
                  ),

              ),
              Container(
                color: Colors.redAccent,
                child:Column(
                  children: [
                    Text(
                      'Book!',
                      style: TextStyle(
                        color: Color(0xFF077bd7),
                        fontSize: 26,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w900,
                        letterSpacing: 3,
                      ),
                    ),
                Container(
                  constraints: new BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width/2 - 350),
                  child: Text("xxxSome text hereSome text hereSome text hereSome text hereSome text hereSome text hereSome text hereSome text hereSome text hereSome text hereSome text here"),
                ),


                  ],
                )

              )
            ],
          ),
    );

  }
}