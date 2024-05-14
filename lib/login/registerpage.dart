import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newcampusconnect/backend/authService.dart';
import 'package:newcampusconnect/login/loginpage.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key, required this.callback}) : super(key: key);

  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignupForm(callback: callback),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key, required this.callback}) : super(key: key);

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
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/icons/logo.png'),
                        ),
                        const Text(
                          'Campus Connect',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            color: Color(0xff6666ff),
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                              setState(() {
                                accountType = "user";
                              });
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
                                color: accountType == 'user'
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                              child: Center(
                                child: Text(
                                  'User',
                                  style: TextStyle(
                                    color: accountType == 'user'
                                        ? Colors.white
                                        : Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Admin
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                accountType = "admin";
                              });
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
                                color: accountType == 'admin'
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                              child: Text(
                                'Admin',
                                style: TextStyle(
                                  color: accountType == 'admin'
                                      ? Colors.white
                                      : Colors.grey,
                                  fontSize: 14,
                                ),
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
                          if (_formKey.currentState!.validate()) {
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            print('Email: $email, Password: $password');
                            await AuthService().signUpWithUserCredentials(
                              name: _nameController.text,
                              email: email,
                              password: password,
                              role: accountType,

                            );
                            _emailController.clear();
                            _passwordController.clear();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Get.to(LoginPage(callback: () {}));
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
