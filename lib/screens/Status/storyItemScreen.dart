import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:uuid/uuid.dart';
import '../../models/models.dart';
import '../../components/story_tile.dart';


class StoryItemScreen extends StatefulWidget {
  final Function(StoryItemm) onCreate;

  final Function(StoryItemm) onUpdate;

  final StoryItemm? originalItem;

  final bool isUpdating;

  const StoryItemScreen({
    Key? key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
  })  : isUpdating = (originalItem != null),
        super(key: key);

  @override
  State<StoryItemScreen> createState() => _StoryItemScreenState();
}

class _StoryItemScreenState extends State<StoryItemScreen> {
  final _textStatController = TextEditingController();
  String _textStat = '';
  Color _currentColor = Colors.green;

  @override
  void initState() {
    final originalItem = widget.originalItem;
    if (originalItem != null) {
      _textStatController.text = originalItem.textStat;
      _textStat = originalItem.textStat;
      _currentColor = originalItem.color;
    }
    _textStatController.addListener(() {
      setState(() {
        _textStat = _textStatController.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _textStatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        alignment: Alignment.center,
        color: _currentColor,
        padding: const EdgeInsets.all(6.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildNamedField(),
                const SizedBox(height: 8.0),
              ],
            ),
            Positioned(
              bottom: 10,
              left: 0,
              child: buildColorPicker(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNamedField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          controller: _textStatController,
          //cursorHeight: 60,
          cursorColor: _currentColor,
          textAlign: TextAlign.center,
          style: GoogleFonts.italiana(),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Type a status',
            hintStyle: TextStyle(fontSize: 50,),
          ),
        ),
      ],
    );
  }

  Widget buildColorPicker(BuildContext context) {


    return Container(
      padding: const EdgeInsets.only(right: 20.0),
      width: MediaQuery.of(context).size.width * 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.emoji_emotions_outlined,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  //GoogleFonts gFont = Random().nextInt(GoogleFonts)
                },
                icon: const Icon(
                  Icons.title_outlined,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _currentColor = Colors
                        .primaries[Random().nextInt(Colors.primaries.length)];
                  });
                },
                icon: const Icon(
                  Icons.palette_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.teal,
            child: IconButton(
              icon: _textStatController.text == ''
                  ? const Icon(
                      Icons.send,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
              onPressed: () {
                final storyItem = StoryItemm(
                  id: widget.originalItem?.id ?? const Uuid().v1(),
                  color: _currentColor,
                  textStat: _textStatController.text,
                );
                if (widget.isUpdating) {
                  widget.onUpdate(storyItem);
                } else {
                  widget.onCreate(storyItem);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
