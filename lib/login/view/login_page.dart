import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/home/view/home_page.dart';
import 'package:my_app/signup/signup.dart';

class loginPage extends StatelessWidget {
  loginPage({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: TextFormField(
                    controller: _usernameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "this field is mandatory";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "username",
                    ),
                  ),
                ),
                SizedBox(
                  child: TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "this field is mandatory";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "password",
                    ),
                  ),
                ),
                SizedBox(
                  child: TextButton(
                      onPressed: () async {
                        try {
                          final _auth = FirebaseAuth.instance;
                          final userRef =
                              await _auth.signInWithEmailAndPassword(
                                  email: _usernameController.text,
                                  password: _passwordController.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("invalid username or password")));
                        }
                      },
                      child: Text("login")),
                ),
                SizedBox(child: Text("or")),
                SizedBox(
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => signupPage(),
                            ));
                      },
                      child: Text("sign up")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
