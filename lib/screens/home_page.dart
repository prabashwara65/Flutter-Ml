import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final Gemini gemini = Gemini.instance;

  final ChatUser currentUser = ChatUser(id: "0" , firstName: "user"); // Define current user
  final ChatUser geminiUser = ChatUser(id: "1" ,
   firstName: "Gemini",
   profileImage: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.reddit.com%2Fr%2FTech_Philippines%2Fcomments%2F1apkec4%2Fhow_to_access_google_gemini_on_your_phone_if_you%2F&psig=AOvVaw200QijMF1OJU33v-1o_XIq&ust=1726296264844000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCMCSze-ov4gDFQAAAAAdAAAAABAJ");
  
  
  final List<ChatMessage> messages = []; // Define list of messages

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: buildUI(),
    );
  }

  Widget buildUI() {
    return DashChat(
      currentUser: currentUser, onSend: onSend, messages: messages,
    );
  }

  void onSend(ChatMessage message) {
    setState(() {
      messages.add(message);
    });

    try {
      
      String question = message.text;
      gemini.streamGenerateContent(question).listen((event) {
        ChatMessage? lastmessage = messages.firstOrNull;
        if(lastmessage != null && lastmessage.user == geminiUser){

        }else{
          ChatMessage newMessage = ChatMessage(user: geminiUser, createdAt: DateTime.now(), text: )
        }
      });

    } catch (e) {
      print(e);
    }
  }
}
