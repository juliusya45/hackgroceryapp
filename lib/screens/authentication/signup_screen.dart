import 'package:firebase_auth/firebase_auth.dart';
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

  //String to hold error message that pops up when user encounters error:
  String errorMsg = '';

  Future signUp() async
  {
    try{
      if(passwordConfirmed() && emptyCheck())
      {
        //set the error message to be nothing since there shouldn't
        //be anymore errors
        setState(() {
          errorMsg = '';
        });
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(), 
          password: _passwordController.text.trim()
        );

        //If I need to add more details to a user add them here:

        //Then push the user to the verification screen:
        if (context.mounted) Navigator.pushReplacementNamed(context, '/verification');
      }
    }
    //if there's an exception catch it and let the user know
    on FirebaseAuthException catch (e)
    {
      if(kDebugMode)
      {
        print(e);
        setState(() {
          errorMsg = e.message!;
        });
      }
    }
  }

  //checks to see that the passwords the user entered matches
  bool passwordConfirmed()
  {
    if(_passwordController.text.trim() == _confirmpasswordController.text.trim())
    {

      return true;
      
    }
    else
    {
      if(_confirmpasswordController.text.trim().isNotEmpty)
      {
        setState(() {
        errorMsg = 'Passwords do not match';
      });
      }
      else
      {
        setState(() {
          errorMsg = 'Please confirm your password';
        });
      }
      return false;
    }
  }

  //checks to see if any fields are empty
  //if any of them are empty it'll let the user know
  bool emptyCheck()
  {
    if(_usernameController.text.trim().isEmpty)
    {
      setState(() {
        errorMsg = 'Please type in your email';
      });
      return false;
    }
    else if(_emailController.text.trim().isEmpty)
    {
      setState(() {
        errorMsg = 'Please type in a username';
      });
      return false;
    }
    else if(_passwordController.text.trim().isEmpty)
    {
      setState(() {
        errorMsg = 'Please type in a password';
      });
      return false;
    }
    else
    {
      return true;
    }
  }

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
                      Text(errorMsg,
                      style: const TextStyle(color: Colors.red),  
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
                          //Need to implement Signup function above
                          onPressed: () {signUp();},
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