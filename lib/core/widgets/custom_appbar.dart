import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {

  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {

    return AppBar(

      backgroundColor: Colors.transparent,

      leading: Icon(Icons.phone_iphone),

      title: Text("Downtown Flagship"),

      actions: [

        Icon(Icons.search),

        SizedBox(width:10),

        Icon(Icons.notifications),

        SizedBox(width:10),

        CircleAvatar(
          child: Icon(Icons.sunny),
        ),

        SizedBox(width:15)
      ],
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(70);
}