import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:linkable/linkable.dart';

class Chat extends StatefulWidget {
  final List messages;
  final int index;

  const Chat({Key? key, required this.messages, required this.index}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: widget.messages[widget.index]['isUserMessage'] ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          !widget.messages[widget.index]['isUserMessage'] ? Container(
            height: 60,
            width: 60,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/image/robot.jpg"),
            ),
          ) : Container(),

          Padding(
            padding: EdgeInsets.all(10.0),
            child: Bubble(
                radius: Radius.circular(15.0),
                color: !widget.messages[widget.index]['isUserMessage']
                    ? Color.fromRGBO(23, 157, 139, 1) : Colors.orange,
                elevation: 0.0,
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                          child: Container(
                            constraints: BoxConstraints( maxWidth: 200),
                            child: Linkable(
                              textColor: Colors.white,
                              linkColor: Colors.black54,
                              text: widget.messages[widget.index]['message'].text.text[0],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                    ],
                  ),
                )),
          ),

          widget.messages[widget.index]['isUserMessage'] ? Container(
            height: 60,
            width: 60,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/image/default.jpg"),
            ),
          ) : Container(),

        ],
      ),
    );
  }
}
