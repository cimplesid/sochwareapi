import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CommentShow extends StatelessWidget {
  final comment;
  CommentShow(this.comment);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
      child: Row(
        
        children: <Widget>[
          Icon(MdiIcons.comment),
          Text(comment),
        ],
      ),
    );
  }
}
