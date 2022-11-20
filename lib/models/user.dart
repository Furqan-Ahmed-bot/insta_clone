
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User_model{
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;


  const User_model({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
  });

  

  Map<String, dynamic> toJson()=> {
    "username" : username,
    "uid" : uid,
    "email" : email,
    "photoUrl" : photoUrl,
    "bio" : bio,
    "followers" : followers,
    "following" : following,
    


  };
   static User_model fromSnap(DocumentSnapshot snap,) {
    var snapshot = snap.data() as Map<String , dynamic>;
    

    return User_model(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      bio: snapshot['bio'],
      followers: snapshot['followers'],
      following: snapshot['following'],

    );
  }
  
 
  





}





