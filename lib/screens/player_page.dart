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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    player,
                    const SizedBox(height: 25),
                    Text(
                      Global.data!.title,
                      style: const TextStyle(fontSize: 17),
                    ),
                    const SizedBox(height: 10),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          buttons(Icons.thumb_up_outlined, "Like"),
                          buttons(Icons.thumb_down_alt_outlined, "Dislike"),
                          buttons(Icons.share_outlined, "Share"),
                          buttons(Icons.slow_motion_video, "Create"),
                          buttons(Icons.download_outlined, "Download"),
                          buttons(Icons.add_box_outlined, "Save"),
                        ],
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Text(
                          Global.data!.channelTitle,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Subscribe",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notifications),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    Text(
                      "${Global.data!.publishedAt}",
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "${Global.data!.description}",
                      style: const TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    //some other widgets
                  ],
                ),
              );
            }),
      ),
    );
  }

  buttons(icon, String text) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          IconButton(onPressed: () {}, icon: Icon(icon)),
          Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 11),
            ),
          )
        ],
      ),
    );
  }
}
