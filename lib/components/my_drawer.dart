import 'package:chatapp/pages/setting_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final colorScheme = Theme.of(context).colorScheme;

    Future<void> logOut() async {
      await FirebaseAuth.instance.signOut();
    }

    return Drawer(
      backgroundColor: colorScheme.background,
      child: SafeArea(
        child: Column(
          children: [
            // Header with Email and Avatar
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(child: Image.asset('lib/images/vaga.png', scale: 8)),
                  const SizedBox(height: 12),
                  Text(
                    user?.email ?? 'No Email',
                    style: TextStyle(
                      color: colorScheme.inversePrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Menu Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(
                    context,
                    icon: Icons.home,
                    title: 'Home',
                    color: colorScheme.inversePrimary,
                    onTap: () => Navigator.pop(context),
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.settings,
                    title: 'Settings',
                    color: colorScheme.inversePrimary,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingPage()),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: GestureDetector(
                onTap: logOut,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: colorScheme.inversePrimary),
                      const SizedBox(width: 12),
                      Text(
                        'Log Out',
                        style: TextStyle(
                          color: colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
        leading: Icon(icon, color: color),
        title: Text(
          title.toUpperCase(),
          style: TextStyle(color: color, fontWeight: FontWeight.w500),
        ),
        onTap: onTap,
      ),
    );
  }
}
