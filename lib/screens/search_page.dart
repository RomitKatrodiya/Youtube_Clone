import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';

import '../global.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  static String key = "AIzaSyAypUx1EfcnBZqMnqi35CpF1ggrve3WyVM";
  YoutubeAPI youtube = YoutubeAPI(key);
  List<YouTubeVideo> videoResult = [];

  Future<void> callAPI() async {
    videoResult = await youtube.search(
      searchController.text,
      order: 'relevance',
      videoDuration: 'any',
    );
    videoResult = await youtube.nextPage();
    setState(() {});
  }

  bool on = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const SizedBox(height: 5),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back)),
                Expanded(
                  child: TextField(
                    onTap: () {
                      on = !on;
                    },
                    controller: searchController,
                    onSubmitted: (val) {
                      Global.searchList.add(searchController.text);
                      callAPI();
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      hintText: "Search YouTube",
                      contentPadding: EdgeInsets.zero,
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.mic),
                ),
              ],
            ),
            Expanded(
              child: (on)
                  ? ListView.builder(
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Icon(Icons.history),
                              const Spacer(),
                              Text(
                                "${Global.searchList[i]}",
                                style: const TextStyle(fontSize: 18),
                              ),
                              const Spacer(),
                              const Icon(Icons.arrow_upward_outlined),
                            ],
                          ),
                        );
                      },
                      itemCount: Global.searchList.length,
                    )
                  : ListView(
                      children: videoResult.map<Widget>(listItem).toList(),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget listItem(YouTubeVideo video) {
    return GestureDetector(
      onTap: () {
        Global.data = video;
        Global.id = video.id.toString();
        setState(() {});
        Navigator.of(context).pushNamed("player_page");
      },
      child: Card(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 7.0),
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Image.network(
                  video.thumbnail.small.url ?? '',
                  width: 120.0,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      video.title,
                      softWrap: true,
                      style: TextStyle(fontSize: 18.0, color: Colors.grey[500]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: Text(
                        video.channelTitle,
                        softWrap: true,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
