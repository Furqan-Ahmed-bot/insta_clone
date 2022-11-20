
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart'; 
import 'package:insta_clone/models/user.dart' as model;
import 'package:insta_clone/resources/storage_methods.dart';

import '../models/user.dart';



class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 
 Future<model.User_model> getUsersDetails() async {
  // model.User_model currentUser = _auth.currentUser! as model.User_model;
  User currentUser = _auth.currentUser!;

  DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();
  return model.User_model.fromSnap(snap);

 }
  


  Future<String> signUpuser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some Error Occurs";
    try{
      if(email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty){
        UserCredential cred  = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        print(cred.user!.uid);

        String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false);

         User_model user = User_model
         (email:email, uid: cred.user!.uid, photoUrl: photoUrl, username: username, bio: bio, followers: [], following: []);
        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson(),);
          // 'username' : username,
          // 'uid' : cred.user!.uid,
          // 'email': email, 
          // 'bio':bio,
          // 'followers' :[],
          // 'following' :[],
          // 'photoUrl' : photoUrl,
        // });
        //  await _firestore.collection('users').add({
        //   'username' : username,
        //   'uid' : cred.user!.uid,
        //   'email': email, 
        //   'bio':bio,
        //   'followers' :[],
        //   'following' :[],
        res = "Success";

      }
      
    }
    catch(err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser(
    {
      required String email,
      required String password
    })async{
      String res = "Some Error Occured";
      try{
        if(email.isNotEmpty || password.isNotEmpty){
          await _auth.signInWithEmailAndPassword(email: email, password: password);
          res = "success";

        }
        else{
          res = "Enter all fields";
        }
      } on FirebaseAuthException catch(e) {
        if(e.code == 'user-not-found'){
        
          
        }
      }
      catch(err){
        res = err.toString();


      }
      return res;

    }
      

    
  
    
    
  

  
}





