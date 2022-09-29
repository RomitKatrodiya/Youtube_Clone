import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';

import '../global.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool typing = false;
  static String key = "AIzaSyAypUx1EfcnBZqMnqi35CpF1ggrve3WyVM";
  String header = "What are You looking for?";

  YoutubeAPI youtube = YoutubeAPI(key);
  List<YouTubeVideo> videoResult = [];

  Future<void> callAPI() async {
    videoResult = await youtube.search(
      TextBox.ytsearch.text,
      order: 'relevance',
      videoDuration: 'any',
    );
    videoResult = await youtube.nextPage();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    callAPI();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            children: const [
              Icon(
                Icons.play_circle_filled,
                color: Colors.red,
                size: 30,
              ),
              SizedBox(width: 5),
              Text(
                "YouTube",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
          actions: [
            const Icon(
              Icons.cast,
              color: Colors.black,
              size: 23,
            ),
            const SizedBox(width: 12),
            const Icon(
              Icons.notifications_none_outlined,
              color: Colors.black,
              size: 27,
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed("search_page");
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.grey.withOpacity(0.5),
              backgroundImage: const NetworkImage(
                "https://avatars.githubusercontent.com/u/111499361?v=4",
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: videoResult.map<Widget>(listItem).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listItem(YouTubeVideo video) {
    return GestureDetector(
      onTap: () {
        Global.id = video.id.toString();
        Navigator.of(context).pushNamed("player_page");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              image: DecorationImage(
                image: NetworkImage("${video.thumbnail.high.url}" ?? ''),
                fit: BoxFit.cover,
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.25,
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 20),
            child: Column(
              children: [
                Text(
                  video.title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                Text(
                  video.channelTitle,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TextBox extends StatelessWidget {
  static TextEditingController ytsearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.grey[850],
      child: Padding(
        padding: const EdgeInsets.only(right: 50),
        child: TextField(
          decoration: const InputDecoration(
              border: InputBorder.none, hintText: 'Search'),
          controller: ytsearch,
        ),
      ),
    );
  }
}
