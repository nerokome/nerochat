import 'package:chatapp/chat%20sevices/Auth_services.dart';
import 'package:chatapp/chat%20sevices/chat_services.dart';
import 'package:chatapp/components/my_drawer.dart';
import 'package:chatapp/components/user_title.dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatServices _chatServices = ChatServices();
  final AuthServices _authservices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,

        title: Center(child: Text('Home')),
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatServices.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('loading...');
        }
        return ListView(
          children:
              snapshot.data!
                  .map<Widget>(
                    (userData) => _buildUserListItems(userData, context),
                  )
                  .toList(),
        );
      },
    );
  }

  Widget _buildUserListItems(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    if (userData['email'] != _authservices.getCurrentUser()!.email) {
      return UserTitle(
        text: userData['email'],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ChatPage(
                    recieverEmail: userData['email'],
                    recieverID: userData['uid'],
                  ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
