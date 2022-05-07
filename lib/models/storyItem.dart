import 'dart:io';

import 'package:flutter/material.dart';

class StoryItemm {
  final String id;
  final Color color;
  final String textStat;
  final bool isComplete;
  final File? img;

  StoryItemm({
    required this.id,
    required this.color,
    required this.textStat,
    this.isComplete = false,
    this.img,
  });

  StoryItemm copyWith(
      {String? id, Color? color, String? textStat, bool? isComplete, File? img}) {
    return StoryItemm(
      id: id ?? this.id,
      color: color ?? this.color,
      textStat: textStat ?? this.textStat,
      isComplete: isComplete ?? this.isComplete,
      img: img ?? this.img,
    );
  }
}
