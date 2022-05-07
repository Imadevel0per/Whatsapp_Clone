import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import '../models/models.dart';
import '../screens/Status/progressBar.dart';

class StoryTile extends StatelessWidget {
  final StoryItemm item;

  final Function(bool?)? onComplete;

  final TextDecoration textDecoration;

  StoryTile({
    Key? key,
    required this.item,
    this.onComplete,
  })  : textDecoration =
            item.isComplete ? TextDecoration.lineThrough : TextDecoration.none,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      padding: const EdgeInsets.only(top: 50.0),
      height: MediaQuery.of(context).size.height * 1,
      color: item.color,
      child: Column(
        children: [
          MyProgressBar(),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.4.toDouble()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    item.textStat,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

