import 'package:flutter/material.dart';
import 'package:loginapp/login_page.dart';
import 'dart:io';

import 'package:loginapp/services/login_validation.dart';

class CurvedAppBar extends StatefulWidget {
  final Color color;
  double height;
  double initialHeight = 150;
  final ScrollController scrollController;
  final Widget child;
  double firstAppBarOpacity = 1;
  Color finalAppBarColor = Colors.blue;
  Color finalAppBarFontColor = Colors.white;

  CurvedAppBar({
    Key? key,
    this.height = 150,
    this.color = Colors.blue,
    required this.scrollController,
    required this.child,
  }) : super(key: key) {
    initialHeight = height;
    finalAppBarColor = color;
  }

  @override
  State<CurvedAppBar> createState() => _CurvedAppBarState();
}

class _CurvedAppBarState extends State<CurvedAppBar> {
  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(() {
      if (widget.scrollController.offset < widget.initialHeight &&
          0 < widget.initialHeight - widget.scrollController.offset) {
        setState(() {
          widget.height = widget.initialHeight - widget.scrollController.offset;
          widget.firstAppBarOpacity = widget.height / widget.initialHeight;
          widget.finalAppBarColor = widget.color;
          widget.finalAppBarFontColor = Colors.white;
        });
      } else {
        setState(() {
          widget.finalAppBarColor = Colors.white;
          widget.height = 0;
          widget.finalAppBarFontColor = Colors.black;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          //FinalAppbar
          duration: const Duration(milliseconds: 400),
          color: widget.finalAppBarColor,

          height: 50,
          child: Row(
            children: [
              BackButton(
                color: widget.finalAppBarFontColor,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Exit"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                exit(exitCode);
                              },
                              child: const Text("Yes")),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("No"))
                        ],
                      );
                    },
                  );
                },
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: 1 - widget.firstAppBarOpacity,
                child: Text(
                  "Trendings",
                  style: TextStyle(
                      fontSize: 20, color: widget.finalAppBarFontColor),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () async {
                  // print("Logging out");
                  await setLoginStatusFalse();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: ((context) => const LoginPage())),
                      (route) => false);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (BuildContext context) {
                  //   return LoginPage();
                  // }));
                },
                // child: Text(
                //   "Log Out",
                //   style: TextStyle(color: widget.finalAppBarFontColor),
                // ),
                child: Icon(
                  Icons.logout,
                  color: widget.finalAppBarFontColor,
                ),
              )
            ],
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: MediaQuery.of(context).size.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.elliptical(300, 100),
            ),
          ),
          child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: widget.firstAppBarOpacity,
              child: widget.child),
        ),
      ],
    );
  }
}
