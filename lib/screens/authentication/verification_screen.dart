import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hack_grocery_app/screens/authentication/auth_page.dart';
import 'package:rive/rive.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
    //bools to determine whether or not a user was verified
    bool isEmailVerified = false;
    bool checked = false;
    Timer? timer;
    Timer? sendHomeTime;
    String verificationText = 'Waiting for Verification...';
    String animation = 'Loading';

    checkEmailVerified() async
    {
      await FirebaseAuth.instance.currentUser?.reload();
      setState(() {
        isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      });

      
      /// The code block is checking if the email is successfully verified. If it is, it updates the
      /// `verificationText` variable to display the message "Email Successfully Verified". It also
      /// cancels the timer that checks for email verification and starts a new timer that navigates to
      /// the home screen after 3 seconds.
      if(isEmailVerified)
      {
        setState(() {
        verificationText = 'Email Successfully Verified';
        animation = 'Success';
        });
        timer?.cancel();
        sendHomeTime = Timer.periodic(const Duration(seconds: 2), (timer) => sendToHome());
      }
    }

    void sendToHome()
    {
      Navigator.pushReplacementNamed(context, '/loading_home');
      sendHomeTime?.cancel();
    }

    @override
    void initState()
    {
      super.initState();
      try {
        if (kDebugMode) {
          print('sent');
        }
        FirebaseAuth.instance.currentUser?.sendEmailVerification();
        } on Exception catch (e) {
          // TODO
          if (kDebugMode) {
            print(e);
          }
        }
      timer = Timer.periodic(const Duration(seconds: 3), (timer) => checkEmailVerified());
    }

    @override
    void dispose()
    {
      timer?.cancel();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verfication Screen"),
        ),
        body: Column(
          children: [
            //Button to sign out if the user wants to do that
            ElevatedButton(
              child: Text("Sign Out"),
              onPressed:() {
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation,
                            Animation secondaryAnimation) {
                              //switch to Authpage?
                          return const AuthScreen();
                        },
                        transitionsBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation,
                            Widget child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        }),
                        (route) => false
                        );
              },
              ),
              //Everythng else below here is to handle user verification:
              const SizedBox(height: 80),
            Text('A verification email was sent to ${FirebaseAuth.instance.currentUser?.email}',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('Please check your email for a link, hit the resend button if the email was not recieved',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: SizedBox(
                height: 110,
                width: 110,
                //To show a fancy animation
                //animation editor: https://editor.rive.app/file/loading/477204
                //docs: https://help.rive.app/runtimes/playback
                child: RiveAnimation.asset('assets/loading.riv',
                animations: [animation],)
              )
            ),
            //const SizedBox(height: 40),
            Padding(
                padding: const EdgeInsets
                    .symmetric(horizontal: 32.0),
                child: Center(
                  child: Text(
                    verificationText,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            const SizedBox(height: 40),
            //Button to resend email in case user didn't recieve it
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: ElevatedButton(
                child: const Text('Resend'),
                onPressed: () {
                  try{
                    FirebaseAuth.instance.currentUser?.sendEmailVerification();
                  }
                  catch (e)
                  {
                    debugPrint('$e');
                  }
                },
              ),
            ),
          ],
        ),
    );
  }
}