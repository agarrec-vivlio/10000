import 'package:flutter/material.dart';
import '../../models/player.dart';

class PlayerProvider with ChangeNotifier {
  List<Player> _players = [];
  int targetScore = 10000;

  List<Player> get players => _players;

  void addPlayer(String name) {
    _players.add(Player(name: name));
    notifyListeners();
  }

  void addPoints(Player player, int points) {
    player.addScore(points);
    notifyListeners();
  }

  void resetGame() {
    for (var player in _players) {
      player.resetScore();
    }
    notifyListeners();
  }

  void removePlayer(int index) {
    _players.removeAt(index);
    notifyListeners();
  }

  dynamic getWinner() {
    try {
      return _players.firstWhere(
        (player) => player.score >= targetScore,
      );
    } catch (e) {
      return false;
    }
  }
}
