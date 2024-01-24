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
  String email_error = '';
  String password_error = '';
  bool isLoading = false;
  bool isValid = false;
  @override
  Widget build(BuildContext context) {
    void _validation() {
      final emailRegExp = RegExp(
          r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
      if (_emailController.text.isEmpty) {
        email_error = 'Email is empty';
        isValid = false;
      } else if (!emailRegExp.hasMatch(_emailController.text)) {
        email_error = 'Email is invalid';
        isValid = false;
      } else {
        email_error = '';
        isValid = true;
      }

      if (_passwordController.text.isEmpty) {
        password_error = 'Password is empty';
        isValid = false;
      } else if (_passwordController.text.length < 6) {
        password_error = 'Password is to short';
        isValid = false;
      } else {
        password_error = '';
        isValid = true;
      }
      setState(() {});
    }

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
                  decoration:  InputDecoration(
                    errorText: email_error,
                      enabledBorder: const OutlineInputBorder(
                      
                    borderSide: BorderSide(width: 3, color: Colors.blue),
                  )),
                  controller: _emailController,
                  onChanged: (value) {
                    _validation();
                  },
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
                  decoration:  InputDecoration(
                    errorText: password_error,
                      enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.blue),
                  )),
                  controller: _passwordController,
                  onChanged: (value) {
                    _validation();
                  },
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
                  decoration:  InputDecoration(
                    errorText: password_error,
                      enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.blue),
                  )),
                  controller: _confirmpasswordController,
                    onChanged: (value) {
                    _validation();
                  },
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
