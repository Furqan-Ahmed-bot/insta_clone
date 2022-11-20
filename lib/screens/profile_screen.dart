// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/resources/firestore_methods.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:insta_clone/widgets/follow_button.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLength = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      var postSnap = await FirebaseFirestore.instance
          .collection('post')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      postLength = postSnap.docs.length;
      userData = userSnap.data()!;
      print(userData['uid']);
      print(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final User_model user = Provider.of<UserProvider>(context).getUser;
    isFollowing =
        user.followers.contains(FirebaseAuth.instance.currentUser!.uid);
    return isLoading ? Center(child: CircularProgressIndicator(),) : 
    Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text(userData['username']),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(userData['photoUrl']),
                      radius: 40,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildColumn(postLength, 'Posts'),
                              buildColumn(user.followers.length, 'followers'),
                              buildColumn(user.following.length, 'Following'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FirebaseAuth.instance.currentUser!.uid == widget.uid? FollowButton(
                                backgroundColor: mobileBackgroundColor,
                                borderColor: primaryColor,
                                text: 'Edit Profile',
                                textColor: Color.fromRGBO(158, 158, 158, 1),
                                function: () {},
                                
                              ): isFollowing ? FollowButton(
                                backgroundColor: Colors.white,
                                borderColor: primaryColor,
                                text: 'Unfollow',
                                textColor: Colors.black,
                                function: () async{
                                  await FireStoreMethods().followUser(FirebaseAuth.instance.currentUser!.uid, userData['uid']);
                                },
                              ): FollowButton(
                                backgroundColor: Colors.blue,
                                borderColor: Colors.blue,
                                text: 'Follow',
                                textColor: Colors.white,
                                function: () async {
                                  await FireStoreMethods().followUser(FirebaseAuth.instance.currentUser!.uid, userData['uid']);
                                  
                                },
                              ), 
                            
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    userData['username'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    userData['bio'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          FutureBuilder(
            future: FirebaseFirestore.instance.collection('post').where('uid' , isEqualTo: widget.uid).get(),
            builder: (context , snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
                
              }
              return GridView.builder(
               shrinkWrap: true,
               itemCount: (snapshot.data! as dynamic).docs.length,
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                childAspectRatio: 1,
                mainAxisSpacing: 1.5 ),
               itemBuilder: (context , index){
                DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];
                return Container(
                  child: Image(image: NetworkImage(snap['postUrl']), fit: BoxFit.cover,),);
               });
            })
        ],
      ),
    );
  }

  Column buildColumn(int num, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          num.toString(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Container(
            margin: EdgeInsets.only(top: 4),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.grey,
              ),
            ))
      ],
    );
  }
}
