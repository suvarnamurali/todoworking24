import 'package:flutter/material.dart';
import 'package:my_app/login/login.dart';
import 'package:my_app/signup/signup_repo.dart';

class signupPage extends StatelessWidget {
  signupPage({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  child: TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please fill the field";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "name",
                    ),
                  ),
                ),
                SizedBox(
                  child: TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please fill the field";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "email",
                    ),
                  ),
                ),
                SizedBox(
                  child: TextFormField(
                    controller: _phonenumberController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please fill the field";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "phone number",
                    ),
                  ),
                ),
                SizedBox(
                  child: TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please fill the field";
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
                        if (_formKey.currentState!.validate()) {
                          await SignupRepo().createUser(
                              _nameController.text,
                              _emailController.text,
                              _phonenumberController.text,
                              _passwordController.text,
                              context);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => loginPage(),));
                              
                        }
                      },
                      child: Text("signup")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
