import 'package:flutter/material.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/account-dto.dart';
import 'package:lettutor/presentation/Login/login.dart';
import 'package:lettutor/services/login_service.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    AccountProvider provider = context.watch<AccountProvider>();
    void _signup() async {
      String email = _emailController.text;
      String password = _passwordController.text;
      String confirmpassword = _confirmpasswordController.text;
      if (password == confirmpassword) {
        try {
          await LoginService.Register(email, password);
          (
            email: _emailController.text,
            password: _passwordController.text,
          );

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Please check your email')),
            );
            Navigator.pop(context);
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error Register: ${e.toString()}')),
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Sign up Failed"),
            content: const Text("Passwords do not match"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign up',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const Image(
              image: AssetImage('asset/images/English.jpg'),
              width: 300,
              height: 200,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Email',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
                TextField(
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.blue),
                  )),
                  controller: _emailController,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Password',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
                TextField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.blue),
                  )),
                  controller: _passwordController,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Confirm Password',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
                TextField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.blue),
                  )),
                  controller: _confirmpasswordController,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      child: const Text(
                        'Back',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )),
                    SizedBox(
                        child: ElevatedButton(
                      onPressed: _signup,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
