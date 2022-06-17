import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  final TextEditingController textEditingController;
  const Post({Key? key,required this.textEditingController}) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("posdt details"),
          TextField(controller: widget.textEditingController,),
        ],
      ),
    );
  }
}
