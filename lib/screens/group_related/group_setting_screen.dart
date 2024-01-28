import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hack_grocery_app/classes/group.dart';
import 'package:hack_grocery_app/screens/logout_screen.dart';
import 'package:hack_grocery_app/screens/notification_screen.dart';
import 'package:clipboard/clipboard.dart';

class GroupSettingScreen extends StatefulWidget {
  const GroupSettingScreen({super.key, required this.group});

  final Group group;

  @override
  State<GroupSettingScreen> createState() => _GroupSettingScreenState();
}

class _GroupSettingScreenState extends State<GroupSettingScreen> {



  final _groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

      var group = widget.group;
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.green,
      title: Text(group.name),
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
      SizedBox(height: 20,),
      GestureDetector(
        child: Text("Group Code: " + group.id,
          style: TextStyle(fontSize: 18),
        ),
        onTap: (){
          FlutterClipboard.copy(group.id);
        },
        ),
      SizedBox(height: 10,),
      Text("Tap the code to copy & send!"),
      
       SizedBox(height: 400),
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