import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/auth_provider.dart';
import 'package:todo_app/view/Widgets/button.dart';
import 'package:todo_app/view/Widgets/text_form_field.dart';
import 'package:todo_app/view/register_screen.dart';

import 'Widgets/text_button.dart';

class ForgotPwdScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();

  ForgotPwdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'forgot password',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFF(controller: emailController, text: 'email', obsc: false),
            SizedBox(
              height: 25,
            ),
            Text('Enter the email address for password resetting.'),
            SizedBox(
              height: 30,
            ),
            Consumer<AuthenticateProvider>(
                builder:(context,authProvider,_) {
                  return authProvider.isLoading
                      ?CircularProgressIndicator()
                      : MyButton(
                    text: 'CONTINUE',
                    onPressed: ()async {
                      final email = emailController.text.trim();
                      if (email.isNotEmpty) {
                        try {
                          await authProvider.resetPassword(email);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Password reset email sent!'),
                          ));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Failed to send reset email.'),
                          ));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Please enter your email address.'),
                        ));
                      }

                    },
                    width: 500,
                    height: 50);
                }),
            Row(
              children: [
                Text('don\'t have an account ?'),
                TextBut(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                    },
                    text: 'Register')
              ],
            )
          ],
        ),
      ),
    );
  }
}
