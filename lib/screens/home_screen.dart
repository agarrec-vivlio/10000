// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/player_provider.dart';
import '../models/player.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _customScoreController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkForWinner();
    });
  }

  void _checkForWinner() {
    final winner =
        Provider.of<PlayerProvider>(context, listen: false).getWinner();
    if (winner is Player) {
      _showWinnerDialog(winner);
    }
  }

  void _showWinnerDialog(Player winner) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: AnimationController(
              duration: const Duration(milliseconds: 500),
              vsync: this,
            )..forward(),
            curve: Curves.elasticOut,
          ),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: Center(
              child: Text(
                "🎉 Félicitations ! 🎉",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${winner.name} a gagné !",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Bravo !"),
                ),
              ],
            ),
          ),
        );
      },
    ).then((_) {
      Provider.of<PlayerProvider>(context, listen: false).resetGame();
    });
  }

  void _addPlayer(BuildContext context) {
    final name = _nameController.text.trim();
    if (name.isNotEmpty) {
      Provider.of<PlayerProvider>(context, listen: false).addPlayer(name);
      _nameController.clear();
      Navigator.of(context).pop();
    }
  }

  void _showAddPlayerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Ajouter un joueur"),
          content: TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: "",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () => _addPlayer(context),
              child: Text("Ajouter"),
            ),
          ],
        );
      },
    );
  }

  void _addPoints(Player player, int points) {
    Provider.of<PlayerProvider>(context, listen: false)
        .addPoints(player, points);
    _checkForWinner();
  }

  void _subtractPoints(Player player, int points) {
    Provider.of<PlayerProvider>(context, listen: false)
        .addPoints(player, -points);
    _checkForWinner();
  }

  @override
  Widget build(BuildContext context) {
    final playerProvider = Provider.of<PlayerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logo.png',
          height: 70,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddPlayerDialog(context),
          ),
        ],
      ),
      body: playerProvider.players.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png', // Logo en plein milieu
                    height: 200, // Ajuste la taille selon tes besoins
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _showAddPlayerDialog(context),
                    child: Text('Ajouter un joueur pour commencer'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: playerProvider.players.length,
                    itemBuilder: (ctx, index) {
                      final player = playerProvider.players[index];
                      return Dismissible(
                        key: ValueKey(player.name),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          playerProvider.removePlayer(index);
                        },
                        child: ListTile(
                          title: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '${player.name} - ',
                                            style: TextStyle(
                                              fontSize: 21,
                                              color: Colors.white,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '${player.score}',
                                            style: TextStyle(
                                              fontSize: 21,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' points',
                                            style: TextStyle(
                                              fontSize: 21,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        TextButton(
                                          onPressed: () =>
                                              _subtractPoints(player, 50),
                                          child: Text('-50'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              _addPoints(player, 50),
                                          child: Text('+50'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              _addPoints(player, 100),
                                          child: Text('+100'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              _addPoints(player, 200),
                                          child: Text('+200'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.add_circle_outline),
                                    onPressed: () =>
                                        _showCustomScoreDialog(player),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: ElevatedButton(
                    onPressed: playerProvider.resetGame,
                    child: Text('Reset Game'),
                  ),
                ),
              ],
            ),
    );
  }

  void _showCustomScoreDialog(Player player) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter custom score"),
          content: TextField(
            controller: _customScoreController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter points",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final points = int.tryParse(_customScoreController.text) ?? 0;
                _addPoints(player, points);
                _customScoreController.clear();
                Navigator.of(context).pop();

                setState(() {
                  _checkForWinner();
                });
              },
              child: Text("Add Score"),
            ),
          ],
        );
      },
    );
  }
}
