import 'package:chatapp/chat%20sevices/Auth_services.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passWordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passWordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void register() {
    final _auth = AuthServices();
    _auth.signUpWithEmailPasssword(
      _emailController.text,
      _passWordController.text,
    );
  }

  bool passwordConfirmed() {
    return _passWordController.text.trim() ==
        _confirmPasswordController.text.trim();
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
                  'Let’s create an account for you',
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

                const SizedBox(height: 10),

                // Confirm Password
                _buildInputField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: _obscureConfirmPassword,
                  toggleVisibility: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                  isPasswordField: true,
                  isObscured: _obscureConfirmPassword,
                ),

                const SizedBox(height: 20),

                // Register button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),

                  child: GestureDetector(
                    onTap: register,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: Center(
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Already have account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: const Text(
                        'Login now',
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
