import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //textControllers that facilitate input of text by the user
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String errorMsg = "";

  //method to get text from the text fields and attempts to log in user
  //with that info
  Future signIn() async
  {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    //checking for empty fields:
    if(email.isEmpty && password.isEmpty)
      setState(() {
        errorMsg = "Please enter an email and password";
      });
    else if(email.isEmpty)
      setState(() {
        errorMsg = "Please enter your email";
      });
    else if(password.isEmpty)
      setState(() {
        errorMsg = "Please enter your password";
      });
    else
    {
      try 
      {
        setState(() {
          errorMsg = '';
          });
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (context.mounted) Navigator.pushReplacementNamed(context, '/loading_home');
      } 
      on FirebaseAuthException catch (e) 
      {
        //the exceptionMsg should be shown to the user
        //ex if the user tries to make an account that already exists
        //or if the user's password is too short
        setState(() {
          String exceptionMsg = e.toString().replaceAll(RegExp('\\[.*?\\]'), '');
          if(exceptionMsg.contains("An internal error"))
            errorMsg = "Email or Password is invalid";
          else
            errorMsg = exceptionMsg;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30,),

                //Title
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 50),

                //Takes in email input
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Enter your email"
                    ),
                  ),
                ),

                //Takes in password input
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: "Password"
                    ),
                  ),
                ),

                SizedBox(height: 10,),

                //Button to Sign in User
                ElevatedButton(
                  onPressed: signIn, 
                  child: Text("Sign In")
                  ),

                SizedBox(height: 5,),

                //error message shown here
                Text(
                  errorMsg,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                     
                    ),
                  ),
                
                SizedBox(height: 50,),

                //A row of elements (text & gestureDetector) that sends the user to sign up page
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    )
                  ),
                  GestureDetector(
                    onTap: widget.showRegisterPage,
                    child: const Text(
                      ' Sign Up Now',
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