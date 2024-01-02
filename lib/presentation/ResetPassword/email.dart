import 'package:flutter/material.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/presentation/ResetPassword/password_reset.dart';
import 'package:lettutor/services/login_service.dart';
import 'package:provider/provider.dart';

class Email extends StatefulWidget {
  const Email({super.key});

  @override
  State<Email> createState() => _Email();
}

class _Email extends State<Email> {
  final TextEditingController _emailController = TextEditingController();
  String email_error = '';
  String password_error = '';
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
      setState(() {});
    }

    AccountProvider provider = context.watch<AccountProvider>();
    void _SendEmail() async {
      try {
        await LoginService.ForgotPassword(_emailController.text);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email send success')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error Reset Password: ${e.toString()}')),
        );
      }
    }

    void _findEmail() {
      String email = _emailController.text;
      if (provider.accountList.any((element) => element.email == email)) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ResetPassword(
                    email: email,
                  )),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Account unavailable"),
            content: const Text("Your account does not exist"),
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
          'Forgot password',
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
                     errorText: email_error.isEmpty ? null:email_error,
                      enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.blue),
                  )),
                  controller: _emailController,
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
                      onPressed: isValid? _SendEmail:null,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      child: const Text(
                        'Continue',
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
