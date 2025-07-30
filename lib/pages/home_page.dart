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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        elevation: 2,
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _buildUserList(),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatServices.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text(
              'Something went wrong!',
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final users = snapshot.data!;
        if (users.isEmpty) {
          return const Center(child: Text('No users found.'));
        }

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final userData = users[index];
            return _buildUserListItems(userData, context);
          },
        );
      },
    );
  }

  Widget _buildUserListItems(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    if (userData['email'] == _authservices.getCurrentUser()!.email) {
      return const SizedBox(); // Don't show self
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person_outline)),
        title: Text(userData['email']),
        trailing: const Icon(Icons.chat_bubble_outline),
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
      ),
    );
  }
}
