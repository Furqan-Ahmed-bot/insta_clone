// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/resources/auth_methods.dart';
import 'package:insta_clone/responsive/mobile_screenlayout.dart';
import 'package:insta_clone/responsive/responsivelayout.dart';
import 'package:insta_clone/responsive/web_screenlayout.dart';
import 'package:insta_clone/screens/login_screen.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:insta_clone/widgets/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({ Key? key }) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _biocontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  Uint8List? _image;
  bool _loading = false;


  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _usernamecontroller.dispose();
  }

  void selectImage() async {
    Uint8List img =  await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
      
    });
    
  }

 void signUpUser() async {
    // set loading to true
    setState(() {
      _loading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpuser(
        email: _emailcontroller.text,
        password: _passwordcontroller.text,
        username: _usernamecontroller.text,
        bio: _biocontroller.text,
        file: _image!);
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _loading = false;
      });
      // navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      setState(() {
        _loading = false;
      });
      // show the error
      showSnackBar(res , context);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(  
            children: [
              Flexible(child: Container(), flex: 2,),
              SvgPicture.asset('assets/ic_instagram.svg', color: primaryColor, height: 64,),
        
              SizedBox(height: 64,),
        
              Stack(
                children: [
                  _image != null
                  ? CircleAvatar(
                    radius: 64,
                    backgroundImage: MemoryImage(_image!),
                    
                  )
                  : const CircleAvatar(
                    radius: 64,
                     backgroundImage: NetworkImage('https://images.unsplash.com/photo-1611262588024-d12430b98920?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80'),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(icon: Icon(Icons.add_a_photo), onPressed: (){selectImage();},
                  ),
                  ),
        
                ],
              ),
              SizedBox(height: 24,),
              TextFieldInput(
                hinttext: 'Enter your Username',
                textInputType: TextInputType.emailAddress,
                textEditingController: _usernamecontroller,
              ),
              SizedBox(height: 24,),
              
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
               TextFieldInput(
                hinttext: 'Enter your Bio',
                textInputType: TextInputType.emailAddress,
                textEditingController: _biocontroller,
              ),
              SizedBox(height: 24,),
         
              InkWell(
                onTap: () async{
                  signUpUser();
                },
                child: Container(
                  child: _loading? Center(child: CircularProgressIndicator(
                    color: primaryColor,
                  ),) : Text('Signup'),
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
                         Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                    child: Container(
                      child: Text("Login"),
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