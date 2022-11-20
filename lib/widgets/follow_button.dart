import 'package:flutter/material.dart';

class FollowButton extends StatefulWidget {
  final Function()? function;
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final Color textColor;

  const FollowButton(
      {Key? key,
      required this.backgroundColor,
      required this.borderColor,
      required this.text,
      required this.textColor,
      this.function})
      : super(key: key);

  @override
  State<FollowButton> createState() => _FollowButtonState();
  
}

class _FollowButtonState extends State<FollowButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: TextButton(onPressed: () {},
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          border: Border.all(
            color: widget.borderColor
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: Text(widget.text , style: TextStyle(color: widget.textColor, fontWeight: FontWeight.bold),),
        width: 240,
        height: 27,
        
      ),
    ),
    );
  }
}

// class FollowButton extends StatelessWidget {
  
//   const FollowButton({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }
// }