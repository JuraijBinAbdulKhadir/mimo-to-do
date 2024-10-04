import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/view/Widgets/button.dart';
import 'package:todo_app/view/home_screen.dart';
import 'package:todo_app/view/Widgets/text_button.dart';
import 'package:todo_app/view/register_screen.dart';

import '../provider/auth_provider.dart';
import 'Widgets/text_form_field.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  // Controllers for input fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset('assets/images/logo.png')),
              SizedBox(height: 30),

              // Email input field
              TextFF(
                controller: emailController,
                obsc: false,
                text: 'Email',
              ),

              SizedBox(height: 15),

              // Password input field
              TextFF(
                  controller: passwordController,
                  text: 'Password',
                  obsc: true
              ),

              SizedBox(height: 15),

              // Forgot password button
              TextBut(
                  text: 'Forgot password?',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPwdScreen(),
                      ),
                    );
                  }
              ),

              SizedBox(height: 20),

              // Consumer widget to listen to the AuthenticateProvider
              Consumer<AuthenticateProvider>(
                builder: (context, authenticateProvider, _) {
                  return authenticateProvider.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : MyButton(
                    text: 'CONTINUE',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Attempt to log in using the provider
                        bool success = await authenticateProvider.signIn(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );

                        if (success) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Login Failed'),
                          ));
                        }
                      }
                    },
                    width: 500,
                    height: 50,
                  );
                },
              ),

              SizedBox(height: 10),

              // Register prompt
              Row(
                children: [
                  Text('Don\'t have an account?'),
                  TextBut(
                    text: 'Register',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
