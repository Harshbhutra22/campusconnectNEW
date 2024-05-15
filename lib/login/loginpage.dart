import 'package:newcampusconnect/backend/authService.dart';
import 'package:newcampusconnect/commons.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.callback});
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginForm(callback: callback),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.callback});
  final VoidCallback callback;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String accountType = 'user';
  String errorMessage = '';

  // Validator
  LoginValidator() {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty) {
      errorMessage = 'All fields mandatory!';
    }

    // Check if email is provided and valid
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(_emailController.text.trim())) {
      errorMessage = 'Enter a valid e-mail address!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          clipBehavior: Clip.hardEdge,
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/icons/logo.png'),
                          ),
                        ),
                        const Text(
                          'Campus Connect',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (errorMessage.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: MyText(errorMessage,
                        color: Colors.red, size: 14, spacing: 1.5),
                  ),
                Container(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _passwordController,
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        obscureText: true,
                      ),
                      const SizedBox(height: 25),
                      GestureDetector(
                        onTap: () async {
                          // Perform login action here
                          String email = _emailController.text;
                          String password = _passwordController.text;
                          print('Email: $email, Password: $password');
                          LoginValidator();
                          if (errorMessage.isEmpty) {
                            errorMessage =
                                await AuthService().signInWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            if (errorMessage.isNotEmpty) {
                              setState(() {});
                            }
                          } else {
                            setState(() {});
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black),
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          widget.callback();
                          // Navigate to registration page
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                        },
                        child: Text('Don\'t have an account? Register'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
