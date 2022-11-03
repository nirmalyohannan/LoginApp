import 'package:flutter/material.dart';

List loadStory(int count) {
  List storyList = [];
  for (int index = 0; index < count; index++) {
    storyList.add(Image.network("https://picsum.photos/200?$index"));
  }
  print("Story Load completed");
  return storyList;
}
