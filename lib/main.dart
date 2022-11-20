// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/responsive/mobile_screenlayout.dart';
import 'package:insta_clone/responsive/responsivelayout.dart';
import 'package:insta_clone/responsive/web_screenlayout.dart';
import 'package:insta_clone/screens/login_screen.dart';
import 'package:insta_clone/screens/signup_screen.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:provider/provider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: FirebaseOptions(apiKey: "AIzaSyADYxY8mndw2frQB4cw3paVyYUHWKyBctg", 
      appId: "1:79827477863:web:e90116ffb5b2b826f0fbc2", 
      messagingSenderId: "79827477863", 
      projectId: "instagram-clone-425e4",
      storageBucket: "instagram-clone-425e4.appspot.com",),

    );

  }else{
    await Firebase.initializeApp();
  } 
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (_)=> UserProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: 
        LoginScreen(),
        // ResponsiveLayout(mobileScreenLayout: MobileScreenLayout(), webScreenLayout: WebScreenLayout(),)
      //   StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     if(snapshot.hasData){
      //       return ResponsiveLayout(webScreenLayout: WebScreenLayout(), mobileScreenLayout: MobileScreenLayout());

      //     }else if (snapshot.hasError){
      //       return Center(
      //         child: Text('${snapshot.hasData}'),
      //       );
      //     }
      //     if(snapshot.connectionState == ConnectionState.waiting){
      //       return Center(
      //         child: CircularProgressIndicator(color: primaryColor,),
      //       );
      //     }

      //     return LoginScreen();

 
      //   }
        

        
      // )
      ),
    );
  }
}
         