
// import 'package:firebase_auth_demo/model/problems.dart';
import 'package:flutter/material.dart';

import '../model/problems.dart';
//Grid Item
class MyGridItem extends StatelessWidget {
  final Chapters? chapters;
  final Future<void> Function() onPressed;
  final Future<void> Function()? onLongPress;

  MyGridItem(
      {Key? key,
      required this.chapters,
      required this.onPressed,
      this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int primaryColor = int.parse("0xFF${chapters?.primaryColor}");
    int secondaryColor = int.parse("0xFF${chapters?.secondaryColor}");
    return Container(
      color: Color(primaryColor).withOpacity(0.95),
      child: InkWell(
        onTap: onPressed,
        onLongPress: onLongPress,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Color(secondaryColor).withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Text(
                chapters?.id ?? 'X',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                alignment: Alignment.topCenter,
                child: Text(
                  chapters?.title ?? 'X',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal),
                )),
            Container(
                alignment: Alignment.center,
                color: Color(secondaryColor),
                padding: const EdgeInsets.all(4),
                child: Text(
                  'TOTAL PROBLEM[${chapters?.questions?.length.toString()}]' ??
                      'X',
                  style:
                      const TextStyle(color: Colors.white, fontFamily: 'mono'),
                )),
          ],
        ),
      ),
    );
  }
}
// List  item



class MyListItem extends StatelessWidget {
  final Chapters? chapters;
  final Future<void> Function() onPressed;
  final Future<void> Function()? onLongPress;

  MyListItem(
      {Key? key,
      required this.chapters,
      required this.onPressed,
      this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int primaryColor = int.parse("0xFF${chapters?.primaryColor}");
    int secondaryColor = int.parse("0xFF${chapters?.secondaryColor}");

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      margin: const EdgeInsets.all(0),
      color: Color(primaryColor).withOpacity(0.95),
      child: InkWell(
        onTap: onPressed,
        onLongPress: onLongPress,
        child: Container(
          color: Colors.red.withOpacity(0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: MediaQuery.of(context).size.height * 0.1,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(secondaryColor).withOpacity(0.5),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(0),
                      ),
                    ),
                    child: Text(
                      chapters?.id ?? 'X',
                      style: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),

                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            chapters?.title?.replaceAll("\n", ' ') ?? 'X',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                              shadows: [
                                Shadow(
                                  color: Colors.white,
                                  offset: Offset(2, 2),
                                  blurRadius: 2.0
                                )
                              ]
                            ),
                          )),
                    ),
                  ),
                ],
              ),
              Container(
                  alignment: Alignment.bottomCenter,
                  color: Color(secondaryColor),
                  padding: const EdgeInsets.all(4),
                  child: Center(
                    child: Text(
                      'TOTAL PROBLEM[${chapters?.questions?.length.toString()}]' ??
                          'X',
                      style:
                          const TextStyle(color: Colors.white, fontFamily: 'mono'),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
