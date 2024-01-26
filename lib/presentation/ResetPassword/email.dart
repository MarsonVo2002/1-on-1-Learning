import 'package:flutter/material.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/presentation/ResetPassword/password_reset.dart';
import 'package:lettutor/provider/language_provider.dart';
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
    LanguageProvider languageProvider = context.watch<LanguageProvider>();
    void _validation() {
      final emailRegExp = RegExp(
          r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
      if (_emailController.text.isEmpty) {
        email_error = languageProvider.language.emptyEmail;
        isValid = false;
      } else if (!emailRegExp.hasMatch(_emailController.text)) {
        email_error = languageProvider.language.invalidEmail;
        isValid = false;
      } else {
        email_error = '';
        isValid = true;
      }
      setState(() {});
    }
    void _SendEmail() async {
      try {
        await LoginService.ForgotPassword(_emailController.text);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text(languageProvider.language.sendRecoveryEmailSuccess)),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error Reset Password: ${e.toString()}')),
        );
      }
    }

    

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
        languageProvider.language.forgotPassword,
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
                      child:  Text(
                        languageProvider.language.back,
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
