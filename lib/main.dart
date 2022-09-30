import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viva_1_master_flutter/screens/home_page.dart';
import 'package:viva_1_master_flutter/screens/player_page.dart';
import 'package:viva_1_master_flutter/screens/search_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => HomePage(),
        "search_page": (context) => const SearchPage(),
        "player_page": (context) => const PlayerPage(),
      },
    ),
  );
}
