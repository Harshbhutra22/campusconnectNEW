import 'package:newcampusconnect/admin/adminscreen.dart';
import 'package:newcampusconnect/backend/authService.dart';
import 'package:newcampusconnect/commons.dart';
import 'package:newcampusconnect/user/userhomepage.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key, required this.callback});
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignupForm(callback: callback),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({super.key, required this.callback});
  final VoidCallback callback;

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();
  String accountType = 'user';
  String errorMessage = '';

  SignUpValidator() {
    // Check if any of the values are null
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty ||
        _nameController.text.trim().isEmpty ||
        _repasswordController.text.isEmpty) {
      errorMessage = 'All fields mandatory!';
    }

    // Check if email is provided and valid
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(_emailController.text.trim())) {
      errorMessage = 'Enter a valid e-mail address!';
    }
    if (_passwordController.text.length < 8) {
      errorMessage = 'Password is too short!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                      // Account type switch
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // User
                          GestureDetector(
                            onTap: () {
                              accountType = "user";
                              setState(() {});
                              print(accountType);
                            },
                            child: Container(
                              width: 75,
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 15, vertical: 3),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.5, color: Colors.grey),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                                color: Colors.black,
                              ),
                              child: Center(
                                child: MyText(
                                  'User',
                                  size: 14,
                                  color: (accountType == 'user')
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),

                          // Admin
                          GestureDetector(
                            onTap: () {
                              accountType = "admin";
                              setState(() {});
                              print(accountType);
                            },
                            child: Container(
                              width: 75,
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 15, vertical: 3),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.5, color: Colors.grey),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                                color: Colors.black,
                              ),
                              child: MyText(
                                'Admin',
                                size: 14,
                                color: (accountType == 'admin')
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
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
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(labelText: 'Password'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        obscureText: true,
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _repasswordController,
                        decoration:
                            InputDecoration(labelText: 'Confirm Password'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        obscureText: true,
                      ),
                      SizedBox(height: 25),
                      GestureDetector(
                        onTap: () async {
                          // Perform login action here
                          String email = _emailController.text;
                          String password = _passwordController.text;
                          print('Email: $email, Password: $password');
                          SignUpValidator();
                          if (errorMessage.isEmpty) {
                            errorMessage = await AuthService()
                                .signUpWithUserCredentials(
                                    name: _nameController.text,
                                    email: email,
                                    password: password,
                                    role: accountType);
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
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          widget.callback();
                        },
                        child: const Text('Already have an account? Login'),
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
