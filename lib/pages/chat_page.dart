import 'package:chatapp/chat%20sevices/Auth_services.dart';
import 'package:chatapp/chat%20sevices/chat_services.dart';
import 'package:chatapp/components/chat_bubble.dart';
import 'package:chatapp/components/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String recieverEmail;
  final String recieverID;
  ChatPage({super.key, required this.recieverEmail, required this.recieverID});

  final TextEditingController _messageController = TextEditingController();

  final ChatServices _chatServices = ChatServices();
  final AuthServices _authServices = AuthServices();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatServices.sendMessage(recieverID, _messageController.text);

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 187, 215, 238),
        title: Text(recieverEmail),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/plain.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [Expanded(child: _builldMessageList()), _buildUserInput()],
        ),
      ),
    );
  }

  Widget _builldMessageList() {
    String senderID = _authServices.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatServices.getMessages(recieverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('loading...');
        }
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser =
        data['senderID'] == _authServices.getCurrentUser()!.uid;

    var aligment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: aligment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data['message'], isCurrentUser: isCurrentUser),
        ],
      ),
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextfield(
              hintText: 'Type a message',
              obscureText: false,
              controller: _messageController,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
