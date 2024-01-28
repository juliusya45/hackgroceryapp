import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hack_grocery_app/screens/logout_screen.dart';
import 'package:hack_grocery_app/screens/notification_screen.dart';

class GroupSettingScreen extends StatefulWidget {
  const GroupSettingScreen({super.key});

  @override
  State<GroupSettingScreen> createState() => _GroupSettingScreenState();
}

class _GroupSettingScreenState extends State<GroupSettingScreen> {

  final _groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.green,
      title: Text('temp name'),
      // title: Text(_groupNameController.text.trim()),
      centerTitle: true,
      
  ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            
            child: Column(
               
        crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Takes in email input
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(35),
                      child: SizedBox(
                        width: 250,
                        child: TextField(
                          controller: _groupNameController,
                          decoration: InputDecoration(
                            hintText: "Change Group Name"
                          ),
                          obscureText: false,
                        ),
                      ),
                    ),
                    IconButton(onPressed: () => {},
       icon: Icon(Icons.drive_file_rename_outline_rounded)),
                  ],
                ),
      
       SizedBox(height: 200),
       ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
        primary: Colors.red, // Background color
        onPrimary: Colors.white,
        ),
        child: const Text(
            'Leave Group',
        style: TextStyle(fontSize: 20),
      ),
    )
              ],
            

       
        
      ),
      ),
    )
      ),
    );
    
  }
}