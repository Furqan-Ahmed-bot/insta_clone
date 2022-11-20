// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_clone/resources/auth_methods.dart';
import 'package:insta_clone/responsive/mobile_screenlayout.dart';
import 'package:insta_clone/responsive/responsivelayout.dart';
import 'package:insta_clone/responsive/web_screenlayout.dart';
import 'package:insta_clone/screens/signup_screen.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:insta_clone/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool _isloading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }
   void loginUser() async {
    setState(() {
      _isloading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailcontroller.text, password: _passwordcontroller.text);
    if (res == 'success') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
          (route) => false);

      setState(() {
        _isloading = false;
      });
    } else {
      setState(() {
        _isloading = false;
      });
      showSnackBar(res, context);
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            children: [
              Flexible(child: Container(), flex: 2,),
              SvgPicture.asset('assets/ic_instagram.svg', color: primaryColor, height: 64,),
              SizedBox(height: 64,),
              TextFieldInput(
                hinttext: 'Enter your Email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailcontroller,
              ),
              SizedBox(height: 24,),
              TextFieldInput(
                hinttext: 'Enter your Password',
                textInputType: TextInputType.emailAddress,
                textEditingController: _passwordcontroller,
                isPass: true,
              ),

               SizedBox(height: 24,),
 
              InkWell(
                onTap: (){
                  loginUser();
                },
                child: Container(
                  child: _isloading? Center(child: CircularProgressIndicator(
                    color: primaryColor,
                  ),) : Text('Log in'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  color: blueColor),
                ),
              ),

              Flexible(child: Container(), flex: 2,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Don't have an account?"),
                    padding: EdgeInsets.symmetric(
                      vertical: 8
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                    },
                    child: Container(
                      child: Text("Sign up."),
                      padding: EdgeInsets.symmetric(
                        vertical: 8
                      ),
                    ),
                  )
                ],
              )
              
            ],

          ),
        )),
      
    );
  }
}