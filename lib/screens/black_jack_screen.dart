import 'package:black_jack/services/game_logic.dart';
import 'package:black_jack/widgets/board_button.dart';
import 'package:black_jack/widgets/cards_grid_view.dart';
import "package:flutter/material.dart";

part 'package:black_jack/widgets/game_section.dart';

class BlackJackScreen extends StatefulWidget {
  BlackJackScreen({Key? key}) : super(key: key);

  @override
  _BlackJackScreenState createState() => _BlackJackScreenState();
}

class _BlackJackScreenState extends State<BlackJackScreen> {
  // Another comment
  // This Comment in currently available test-branch
  bool _isGameStarted = false;

  @override
  void initState() {
    super.initState();
    GameLogic.instance.startGame();
  }

  @override
  Widget build(BuildContext context) {
    final dealerScore = GameLogic.instance.dealerScore;
    final dealerCards = GameLogic.instance.dealersCards;
    final playerScore = GameLogic.instance.playerScore;
    final myCards = GameLogic.instance.myCards;

    return Scaffold(
      body: _isGameStarted
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    _GameSection(
                      scoreLabel: 'Dealer\'s score',
                      score: dealerScore,
                      cards: dealerCards,
                    ),
                    _GameSection(
                      scoreLabel: 'Player\'s score',
                      score: playerScore,
                      cards: myCards,
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: ElevatedButton(
                onPressed: () {
                  GameLogic.instance.startNewRound();
                  _isGameStarted = true;
                  setState(() {});
                },
                child: Text("Start Game"),
              ),
            ),
      bottomNavigationBar: _isGameStarted ? Row(
        children: [
          BoardButton(
            onPressed: () {
              GameLogic.instance.addCard();
              setState(() {});
            },
            label: "Add Card",
          ),
          BoardButton(
            onPressed: () {
              GameLogic.instance.startNewRound();
              setState(() {});
            },
            label: "Next Round",
          ),
        ],
      ) : null,
    );
  }
}
