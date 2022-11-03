import 'package:flutter/material.dart';

List loadposts(int count) {
  List postImagesList = [];
  for (int index = 0; index < count; index++) {
    postImagesList.add(Image.network("https://picsum.photos/400?$index"));
  }
  print("Posts Load completed");
  return postImagesList;
}

Map postDetails = {
  'title': [
    'Alison Park, USA',
    'Harvard institute, USA',
    'Mumbai City, India',
    'London, United Kingdom',
    'Chennai, India',
    'Perth, Australia',
    'Kochi, India',
    'Torronto, Canada',
    'Columbo, SriLanka',
    'Paris, France',
    'Ontario, Canada'
  ]
};
