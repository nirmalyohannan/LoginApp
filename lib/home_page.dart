import 'package:flutter/material.dart';

import 'package:loginapp/CustomWidgets/curved_appbar.dart';

import 'package:loginapp/services/load_posts.dart';

import 'package:loginapp/services/load_story.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController scrollController = ScrollController();
  int storyCount = 10;
  int postCount = 10;
  List storyImages = [];
  List postImages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("::::initState called::::::");

    storyImages = loadStory(storyCount);
    postImages = loadposts(postCount);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // print("::::dispose called::::::");
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              CurvedAppBar(
                //Custom AppBar
                height: 200,
                color: Colors.deepPurple,
                scrollController: scrollController,
                child: const Center(
                  child: Text(
                    "Welcome Amigo",
                    style: TextStyle(
                        fontFamily: 'FontBunchBlossom',
                        fontSize: 40,
                        color: Colors.white),
                  ),
                ),
              ),
              Container(
                child: Expanded(
                  flex: 1,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: storyCount,
                    itemBuilder: (context, index) {
                      return CircleAvatar(
                        radius: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: ClipOval(
                            child: storyImages[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                //This was not able to do directly in horizontal listview's container
                height: 10,
                decoration:
                    const BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 1,
                      color: Colors.black26,
                      offset: Offset(0, 10))
                ]),
              ),
              Expanded(
                flex: 6,
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: postCount,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50)),
                                child: postImages[index],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.favorite_border,
                                      size: 40,
                                    ),
                                    SizedBox(
                                      //GAP
                                      width: 20,
                                    ),
                                    Icon(
                                      Icons.comment,
                                      size: 40,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Icon(
                                      Icons.send,
                                      size: 40,
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.bookmark_outline,
                                      size: 40,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 15),
                                width: double.maxFinite,
                                child: Text(
                                  "${postDetails['title'][index]}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
