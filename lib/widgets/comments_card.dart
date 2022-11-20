// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentsCard extends StatefulWidget {
  final snap;
  const CommentsCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<CommentsCard> createState() => _CommentsCardState();
}

class _CommentsCardState extends State<CommentsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Row(children: [
        CircleAvatar(
          backgroundImage: NetworkImage(widget.snap['profilePic']),
          radius: 18,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: widget.snap['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '   ${widget.snap['text']}')
                ])),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    DateFormat.yMMMd()
                        .format(widget.snap['datePublished'].toDate()),
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(40, 8, 8, 8),
          child: Icon(
            Icons.favorite,
            size: 16,
          ),
        ),
      ]),
    );
  }
}
