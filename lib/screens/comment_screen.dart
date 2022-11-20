// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/resources/firestore_methods.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../widgets/comments_card.dart';

class CommentScreen extends StatefulWidget {
  final snap;
  const CommentScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentcontroller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _commentcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User_model user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text('Comments'),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('post')
            .doc(widget.snap['postId'])
            .collection('comments')
            .orderBy('datePublished', descending: true)
            .snapshots(),
        builder: (context , snapshot)
        {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else{
            return ListView.builder(
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context, index) => CommentsCard(
                snap: (snapshot.data! as dynamic).docs[index].data()
              ),
              
              );
          }
        }
      ),
      
      bottomNavigationBar: SafeArea(
          child: Container(
        height: kToolbarHeight,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: EdgeInsets.only(left: 16, right: 8),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.photoUrl),
              radius: 18,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 18),
              child: TextField(
                controller: _commentcontroller,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {
                      FireStoreMethods().postComment(
                          widget.snap['postId'],
                          _commentcontroller.text,
                          user.uid,
                          user.username,
                          user.photoUrl);

                        setState(() {
                          _commentcontroller.text = "";
                        });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 8, top: 14),
                      child: Text(
                        'Post',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  hintText: 'Comment as ${user.username}',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
              ),
            )),
          ],
        ),
      )),
    );
  }
}
