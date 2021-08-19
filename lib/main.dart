import 'package:flutter/material.dart';

import 'screens/search_screen.dart';

void main() {
  runApp(GithubSearchApp());
}

class GithubSearchApp extends StatelessWidget {
  const GithubSearchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Search',
      debugShowCheckedModeBanner: false,
      home: SearchScreen(
        searchText: '',
      ),
    );
  }
}
