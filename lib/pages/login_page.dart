import 'package:chatapp/chat%20sevices/Auth_services.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;

  LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passWordController = TextEditingController();
  bool _obscurePassword = true;

  void login() {
    final _auth = AuthServices();
    _auth.signInWithEmailPasssword(
      _emailController.text.trim(),
      _passWordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/pp.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(child: Image.asset('lib/images/vaga.png', scale: 10)),
                const SizedBox(height: 50),
                const Text(
                  'Welcome back',
                  style: TextStyle(
                    color: Color.fromARGB(255, 183, 201, 233),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),

                // Email
                _buildInputField(
                  controller: _emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // Password
                _buildInputField(
                  controller: _passWordController,
                  hintText: 'Password',
                  obscureText: _obscurePassword,
                  toggleVisibility: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  isPasswordField: true,
                  isObscured: _obscurePassword,
                ),

                const SizedBox(height: 20),

                // Login Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: GestureDetector(
                    onTap: login,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: const Center(
                        child: Text('Login', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Register link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.showRegisterPage,
                      child: const Text(
                        'Register now',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    VoidCallback? toggleVisibility,
    bool isPasswordField = false,
    bool isObscured = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.tertiary,
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            suffixIcon:
                isPasswordField
                    ? IconButton(
                      icon: Icon(
                        isObscured ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey[600],
                      ),
                      onPressed: toggleVisibility,
                    )
                    : null,
          ),
        ),
      ),
    );
  }
}
