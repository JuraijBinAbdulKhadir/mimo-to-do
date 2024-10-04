import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/view/Widgets/button.dart';
import 'package:todo_app/view/login_screen.dart';
import '../provider/auth_provider.dart';
import 'Widgets/text_button.dart';
import 'Widgets/text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cnfPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create an Account',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey, // Assign the form key
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Full name field
                TextFF(
                  text: 'Full name',
                  obsc: false,
                  controller: nameController,
                ),
                SizedBox(height: 20),

                // Email field
                TextFF(
                  text: 'Email',
                  obsc: false,
                  controller: emailController,

                ),
                SizedBox(height: 20),

                // Password field
                TextFF(
                  text: 'Password',
                  obsc: true,
                  controller: passwordController,

                ),
                SizedBox(height: 20),

                // Confirm Password field
                TextFF(
                  text: 'Confirm Password',
                  obsc: true,
                  controller: cnfPasswordController,

                ),
                SizedBox(height: 30),

                // Sign-up button wrapped in a Consumer to listen to the AuthenticateProvider
                Consumer<AuthenticateProvider>(
                  builder: (context, authenticateProvider, _) {
                    return authenticateProvider.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : MyButton(
                      text: 'CONTINUE',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          bool success = await authenticateProvider.signUp(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );

                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Registration Successful'),
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Registration Failed'),
                              ),
                            );
                          }
                        }
                      },
                      width: 500,
                      height: 50,
                    );
                  },
                ),

                SizedBox(height: 20),

                // Login prompt for existing users
                Row(
                  children: [
                    Text('Already have an account?'),
                    TextBut(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      text: 'Login',
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
}
