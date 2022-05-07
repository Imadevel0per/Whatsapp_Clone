import 'package:flutter/material.dart';
import '../../components/story_tile.dart';
import '../../models/models.dart';
import 'storyItemScreen.dart';

class StoryListScreen extends StatelessWidget {
  final StoryManager manager;

  const StoryListScreen({Key? key, required this.manager}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final storyItems = manager.storyItems;

    return Scaffold(
      body: Container(
        //padding: const EdgeInsets.all(6.0),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: storyItems.length,
          itemBuilder: (context, index) {
            final item = storyItems[index];
            //TODO 28: Wrap in a Dismissable
            //TODO 27: Wrap in an InkWell
            return Stack(
              children: [
                StoryTile(
                  key: Key(item.id),
                  item: item,
                  onComplete: (change) {
                    if (change != null) {
                      manager.completeItem(index, change);
                    }
                  },
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16.0,);
          },
        ),
      ),
    );
  }
}
