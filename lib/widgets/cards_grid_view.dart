import 'package:black_jack/services/game_logic.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class CardsGridView extends StatelessWidget {
  const CardsGridView({
    Key? key,
    required this.cards,
  }) : super(key: key);

  final List<String> cards;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 4.0,
      children: [
        ...cards.mapIndexed(
          (index, card) => _AnimatedCard(
            key: Key(cards[index]),
            card: cards[index],
            position: index,
          ),
        ),
      ],
    );
  }
}

class _AnimatedCard extends StatefulWidget {
  final String card;
  final int position;

  const _AnimatedCard({required this.card, required this.position, super.key});

  @override
  State<_AnimatedCard> createState() => __AnimatedCardState();
}

class __AnimatedCardState extends State<_AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late final Animation<Offset> _slideAnimation = Tween<Offset>(
    begin: const Offset(2, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInBack,
  ));

  late final Animation<double> _rotateAnimation = Tween<double>(
    begin: 1,
    end: 0,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInQuart,
  ));

  @override
  void initState() {
    super.initState();

    // _controller = AnimationController(
    //   duration: const Duration(seconds: 1),
    //   vsync: this,
    // )..forward();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    if (GameLogic.instance.baseCardsAdded) {
      _controller.forward();
    } else {
      Future.delayed(
          Duration(milliseconds: ((widget.position / 2) * 1000).toInt()), () {
        _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: RotationTransition(
        turns: _rotateAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13.0),
          child: Image.asset(scale: 10, widget.card),
        ),
      ),
    );
  }
}
