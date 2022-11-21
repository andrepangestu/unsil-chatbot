import 'package:chatbot_unsil/components/chat.dart';
import 'package:chatbot_unsil/constans.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatbotScreen extends StatefulWidget {
  // const ChatbotScreen({ Key ? key}) : super(key : key);

  @override
  // _ChatbotScreenState createState() => _ChatbotScreenState();
  State<StatefulWidget> createState() => new _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/image/robot.jpg"),
            ),
            SizedBox(width: kDefaultPadding * 0.75,),
            Column(
              children: [
                Text(
                  "SITEKBOT",
                  style: TextStyle(fontSize: 18),
                )
              ],
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 10),
              child: Text("Today, ${DateFormat("Hm").format(DateTime.now())}", style: TextStyle(
                  fontSize: 20
              ),),
            ),
            Flexible(
                child: ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) => Chat(
                        messages: messages,
                        index: messages.length - 1 - index
                    )
                )
            ),

            SizedBox(
              height: 20,
            ),

            Divider(
              height: 5.0,
              color: Colors.greenAccent,
            ),

            Container(
              child: ListTile(
                title: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(
                        15)),
                    color: Color.fromRGBO(220, 220, 220, 1),
                  ),
                  padding: EdgeInsets.only(left: 15),
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Enter a Message...",
                      hintStyle: TextStyle(
                          color: Colors.black26
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),

                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black
                    ),
                    onChanged: (value) {

                    },
                  ),
                ),

                trailing: IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 30.0,
                      color: Colors.greenAccent,
                    ),
                    onPressed: () {
                      if (_controller.text.isEmpty) {
                        print("empty message");
                      } else {
                        sendMessage(_controller.text);
                        _controller.clear();
                        // setState(() {
                        //   messsages.insert(0,
                        //       {"data": 1, "message": messageInsert.text});
                        // });
                        // response(messageInsert.text);
                        // messageInsert.clear();
                      }

                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    }),

              ),

            ),

            SizedBox(
              height: 15.0,
            )
          ],
        ),
      ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty){
      print('Message Empty');
    } else {
      setState(() {
        addMessage(Message(
          text: DialogText(text: [text])
        ), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));

      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });



      print(messages);
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({
      'message': message,
      'isUserMessage': isUserMessage
    });
  }
}
