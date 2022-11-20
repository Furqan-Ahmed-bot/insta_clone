// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/dimensions.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import 'package:insta_clone/models/user.dart' as model;


class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout ({ Key? key }) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  
  // @override
  // void initState() {
    
  //   super.initState();
  //   g
  // }
  
  // void getusername() async{
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //   .collection('users')
  //   .doc(FirebaseAuth.instance.currentUser!.uid)
  //   .get();
  //   setState(() {
  //     username = (snap.data() as Map<String , dynamic>)['username'];
  //   });
  // }

  int _page = 0;
  late PageController pagecontroller;

  @override
  void initState() {
    // TODO: implement initState
    pagecontroller = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pagecontroller.dispose();
  }
 

  void navigationTapped(int page){
    pagecontroller.jumpToPage(page);

  }
  void onchanges(int page){
    setState(() {
      _page = page;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    model.User_model user = Provider.of<UserProvider>(context).getUser as User_model;
    return Scaffold(
      body: PageView(
        children: Homescreens,
        physics:  NeverScrollableScrollPhysics(),
        controller: pagecontroller,
        onPageChanged: onchanges,

        
      ),
      // Center(child: Text(user.username)),

      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          
          BottomNavigationBarItem(icon: Icon(Icons.home, color: _page == 0? primaryColor : secondaryColor,),
          label: '',
          backgroundColor: primaryColor,
          ),

           BottomNavigationBarItem(icon: Icon(Icons.search , color: _page == 1? primaryColor : secondaryColor,),
          label: '',
          backgroundColor: primaryColor,
          ),

           BottomNavigationBarItem(icon: Icon(Icons.add_circle , color: _page == 2? primaryColor : secondaryColor,),
          label: '',
          backgroundColor: primaryColor,
          ),
           BottomNavigationBarItem(icon: Icon(Icons.favorite , color: _page == 3? primaryColor : secondaryColor,),
          label: '',
          backgroundColor: primaryColor,
          ),
           BottomNavigationBarItem(icon: Icon(Icons.person , color: _page == 4? primaryColor : secondaryColor,),
          label: '',
          backgroundColor: primaryColor,
          )

          
        ],
        onTap: navigationTapped,
         

        ),
    );
  }
}