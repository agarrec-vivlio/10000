import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/player_provider.dart';
import './screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlayerProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Score Manager - 10,000',
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}
