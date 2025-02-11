import '../models/item.dart';

List<Item> items = [
  Item(
      title: 'Browse',
      lottie: lotties[0],
      description: desc),
  Item(
      title: 'Compare', lottie: lotties[1], description: desc1),
  Item(
      title: 'Move in',
      lottie: lotties[2],
      description: desc2),
];

const String desc =
    "Looking for a home, shop or office?";
const String desc1 =
    "Browse and compare our options to find the space that suits your need";
const String desc2 =
    "Book for viewing while you still can";
List<String> lotties = [
  'assets/Animation - 1718800549400.json',
  'assets/Animation - 1707344777453.json',
  'assets/Animation - 1718801216700.json',

];