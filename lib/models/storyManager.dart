import 'package:flutter/material.dart';
import 'storyItem.dart';

class StoryManager extends ChangeNotifier {
  final _storyItems = <StoryItemm>[];

  List<StoryItemm> get storyItems => List.unmodifiable(_storyItems);

  void deleteItem(int index) {
    _storyItems.removeAt(index);
    notifyListeners();
  }

  void addItem(StoryItemm item) {
    _storyItems.add(item);
    notifyListeners();
  }

  void updateItem(StoryItemm item, int index) {
    _storyItems[index] = item;
    notifyListeners();
  }

  void completeItem(int index, bool change) {
    final item = _storyItems[index];
    _storyItems[index] = item.copyWith(isComplete: change);
    notifyListeners();
  }
}
