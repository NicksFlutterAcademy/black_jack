part of 'package:black_jack/screens/black_jack_screen.dart';

class _GameSection extends StatelessWidget {
  final String scoreLabel;
  final int score;
  final List<String> cards;

  const _GameSection({
    required this.scoreLabel,
    required this.score,
    required this.cards,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "${scoreLabel}: $score",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: score <= 21 ? Colors.green[900] : Colors.red[900],
          ),
        ),
        CardsGridView(cards: cards),
      ],
    );
  }
}
