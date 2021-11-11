import 'dart:math';

class Cards {
  final Map<String, int> playingCards = {
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

  // Card images
  List<String> myCards = [];
  List<String> dealersCards = [];

  // Cards
  String? dealerFirstCard;
  String? dealerSecondCard;

  String? playersFirstCard;
  String? playersSecondCard;

  void startNewRound() {
    // reset card images
    myCards = [];
    dealersCards = [];

    Random random = Random();

    // Random card one for dealer
    String cardOneKey = playingCards.keys.elementAt(random
        .nextInt(playingCards.length)); // from 0 to playingCards.keys.length

    // Remove cardOneKey from playingCards
    playingCards.removeWhere((key, value) => key == cardOneKey);

    // Random card two for dealer
    String cardTwoKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardTwoKey);

    // Random card one for the player
    String cardThreeKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardThreeKey);

    // Random card two for the player
    String cardFourKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardFourKey);

    // Assign cards keys to dealer's cards
    dealerFirstCard = cardOneKey;
    dealerSecondCard = cardTwoKey;

    // Assign cards keys to player's cards
    playersFirstCard = cardThreeKey;
    playersSecondCard = cardFourKey;

    // Adding dealers cards images to display them in Grid View
    dealersCards.add(dealerFirstCard!);
    dealersCards.add(dealerSecondCard!);

    // Adding players card images to display them in Grid View
    myCards.add(playersFirstCard!);
    myCards.add(playersSecondCard!);
  }

  void addCard() {
    Random random = Random();

    if (playingCards.length > 0) {
      String cardKey =
          playingCards.keys.elementAt(random.nextInt(playingCards.length));

      playingCards.removeWhere((key, value) => key == cardKey);

      myCards.add(cardKey);
    }
  }
}
