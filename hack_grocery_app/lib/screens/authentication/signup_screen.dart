import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignUpScreen({super.key, required this.showLoginPage});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: 
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 52,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 20,),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Please enter your info here to create an account!",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25),
                          ),
                      ),
                      const SizedBox(height: 20,),

                      //Username input
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color.fromARGB(255, 78, 150, 227)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'Create a username',
                            fillColor: Colors.grey[200],
                            filled: true
                          ),
                          obscureText: false,
                          ),
                        ),
                        SizedBox(height: 10,),

                        //Email input:
                        Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color.fromARGB(255, 78, 150, 227)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'Enter your email address',
                            fillColor: Colors.grey[200],
                            filled: true
                          ),
                          obscureText: false,
                          ),
                        ),
                        SizedBox(height: 10,),

                        //Password input
                        Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color.fromARGB(255, 78, 150, 227)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'Create a password',
                            fillColor: Colors.grey[200],
                            filled: true
                          ),
                          obscureText: true,
                          ),
                        ),
                        SizedBox(height: 10,),

                        //Password confirmation input
                        Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextField(
                          controller: _confirmpasswordController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color.fromARGB(255, 78, 150, 227)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'Re-Enter your password',
                            fillColor: Colors.grey[200],
                            filled: true
                          ),
                          obscureText: true,
                          ),
                        ),

                        SizedBox(height: 20,),
                        //Sign Up Button:
                        ElevatedButton(
                          onPressed: (){}, 
                          child: Text("Sign Up!")),

                      SizedBox(height: 50),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Have an account?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              )
                            ),
                            GestureDetector(
                              onTap: widget.showLoginPage,
                              child: const Text(
                                ' Sign In',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                  )
                                ),
                            )
                          ],
                        ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}