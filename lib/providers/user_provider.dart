import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/resources/auth_methods.dart';


class UserProvider with ChangeNotifier {
  User_model? _user;
  final AuthMethods _authMethods = AuthMethods();

  User_model get getUser => _user!;

  Future<void> refreshuser() async {
    User_model user = await _authMethods.getUsersDetails();
    _user = user;
    notifyListeners();
  }
}