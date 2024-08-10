// Deck of cards
import 'dart:async';
import 'dart:math';

enum Winner { none, house, player }

class GameLogic {
  static final GameLogic _instance = GameLogic._();

  GameLogic._();

  // Winner
  StreamController<Winner> _controller = StreamController()..add(Winner.none);

  Stream get winnerStream => _controller.stream;

  static GameLogic get instance => _instance;

  final Map<String, int> _deckOfCards = {
    "cards/2.1.png": 2,
    "cards/2.2.png": 2,
    "cards/2.3.png": 2,
    "cards/2.4.png": 2,
    "cards/3.1.png": 3,
    "cards/3.2.png": 3,
    "cards/3.3.png": 3,
    "cards/3.4.png": 3,
    "cards/4.1.png": 4,
    "cards/4.2.png": 4,
    "cards/4.3.png": 4,
    "cards/4.4.png": 4,
    "cards/5.1.png": 5,
    "cards/5.2.png": 5,
    "cards/5.3.png": 5,
    "cards/5.4.png": 5,
    "cards/6.1.png": 6,
    "cards/6.2.png": 6,
    "cards/6.3.png": 6,
    "cards/6.4.png": 6,
    "cards/7.1.png": 7,
    "cards/7.2.png": 7,
    "cards/7.3.png": 7,
    "cards/7.4.png": 7,
    "cards/8.1.png": 8,
    "cards/8.2.png": 8,
    "cards/8.3.png": 8,
    "cards/8.4.png": 8,
    "cards/9.1.png": 9,
    "cards/9.2.png": 9,
    "cards/9.3.png": 9,
    "cards/9.4.png": 9,
    "cards/10.1.png": 10,
    "cards/10.2.png": 10,
    "cards/10.3.png": 10,
    "cards/10.4.png": 10,
    "cards/J1.png": 10,
    "cards/J2.png": 10,
    "cards/J3.png": 10,
    "cards/J4.png": 10,
    "cards/Q1.png": 10,
    "cards/Q2.png": 10,
    "cards/Q3.png": 10,
    "cards/Q4.png": 10,
    "cards/K1.png": 10,
    "cards/K2.png": 10,
    "cards/K3.png": 10,
    "cards/K4.png": 10,
    "cards/A1.png": 11,
    "cards/A2.png": 11,
    "cards/A3.png": 11,
    "cards/A4.png": 11,
  };

  List<String> get myCards => _myCards;

  List<String> get dealersCards => _dealersCards;

  // Cards (paths to assets)
  List<String> _myCards = [];
  List<String> _dealersCards = [];

  int get dealerScore => _dealerScore;

  int get playerScore => _playerScore;

  // Scores
  int _dealerScore = 0;
  int _playerScore = 0;

  Map<String, int> get playingCards => _playingCards;

  // Playing cards in this game.
  Map<String, int> _playingCards = {};

  // Cards
  String? _dealerFirstCard;
  String? _dealerSecondCard;

  String? _playersFirstCard;
  String? _playersSecondCard;

  void startGame() {
    _playingCards.addAll(_deckOfCards);
  }

  // Needed for animation!
  bool get baseCardsAdded => _baseCardsAdded;
  bool _baseCardsAdded = false;

// Reset the round and reset cards
  void startNewRound() {
    // Reset winner
    _resetWinner();

    // For animations
    _baseCardsAdded = false;
    // Start new  round with full deckOfCards
    _playingCards = {};
    _playingCards.addAll(_deckOfCards);

    // reset card images
    _myCards = [];
    _dealersCards = [];

    final Random random = Random();

    // Random card one for dealer
    final String cardOneKey = _playingCards.keys.elementAt(
      random.nextInt(_playingCards.length),
    ); // from 0 to playingCards.keys.length

    // Remove cardOneKey from playingCards
    _playingCards.removeWhere((key, value) => key == cardOneKey);

    // Random card two for dealer
    final String cardTwoKey =
        _playingCards.keys.elementAt(random.nextInt(_playingCards.length));
    _playingCards.removeWhere((key, value) => key == cardTwoKey);

    // Random card one for the player
    final String cardThreeKey =
        _playingCards.keys.elementAt(random.nextInt(_playingCards.length));
    _playingCards.removeWhere((key, value) => key == cardThreeKey);

    // Random card two for the player
    final String cardFourKey =
        _playingCards.keys.elementAt(random.nextInt(_playingCards.length));
    _playingCards.removeWhere((key, value) => key == cardFourKey);

    // Assign cards keys to dealer's cards
    _dealerFirstCard = cardOneKey;
    _dealerSecondCard = cardTwoKey;

    // Assign cards keys to player's cards
    _playersFirstCard = cardThreeKey;
    _playersSecondCard = cardFourKey;

    // Adding dealers cards images to display them in Grid View
    _dealersCards.add(_dealerFirstCard!);
    _dealersCards.add(_dealerSecondCard!);

    // Score for dealer
    _dealerScore =
        _deckOfCards[_dealerFirstCard]! + _deckOfCards[_dealerSecondCard]!;

    // Adding players card images to display them in Grid View
    _myCards.add(_playersFirstCard!);
    _myCards.add(_playersSecondCard!);

    // Score for player (my score)
    _playerScore =
        _deckOfCards[_playersFirstCard]! + _deckOfCards[_playersSecondCard]!;

    if (_dealerScore <= 14) {
      final String thirdDealersCard =
          _playingCards.keys.elementAt(random.nextInt(_playingCards.length));

      _dealersCards.add(thirdDealersCard);

      _dealerScore = _dealerScore + _deckOfCards[thirdDealersCard]!;
    }

    _checkScore();
  }

  // Add extra card to player
  void addCard() {
    _baseCardsAdded = true;
    final Random random = Random();

    final String cardKey = _playingCards.keys.elementAt(
      random.nextInt(_playingCards.length),
    );

    _playingCards.removeWhere((key, value) => key == cardKey);

    _myCards.add(cardKey);

    _playerScore = _playerScore + _deckOfCards[cardKey]!;
    _checkScore();
  }

  void _resetWinner() => _controller.add(Winner.none);

  void _checkScore() {
    if (_playerScore > _dealerScore && _playerScore <= 21) {
      _controller.add(Winner.player);
    } else if (_dealerScore > 21) {
      _controller.add(Winner.player);
    } else if (_playerScore > 21) {
      _controller.add(Winner.house);
    }
  }
}
