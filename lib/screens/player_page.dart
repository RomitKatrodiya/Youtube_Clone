import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../global.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({Key? key}) : super(key: key);

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: Global.id,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      onReady: () {
        _controller.addListener(() {});
      },
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller,
            ),
            builder: (context, player) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    player,
                    const SizedBox(height: 25),
                    Text(
                      "${Global.data!.title}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${Global.data!.description}",
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${Global.data!.description}",
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    //some other widgets
                  ],
                ),
              );
            }),
      ),
    );
  }
}
