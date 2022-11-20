import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/screens/add_post_screen.dart';
import 'package:insta_clone/screens/feeds_screen.dart';

import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';

const webScreenSize = 600;


List<Widget> Homescreens =[
 
          FeedScreen(),
          SearchScreen(),
          AddPostScreen(),
          Text('notify'),
          ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,),

];
