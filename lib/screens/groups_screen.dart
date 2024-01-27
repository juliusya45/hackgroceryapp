import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('Groups'),
          actions: <Widget> [
          IconButton(
              tooltip: 'Open Group Settings',
              icon: const Icon(Icons.more_vert),
              color: Colors.white,
              onPressed: () {},
            ),
          ],
        ),
        body: ListView(
          
        ),
        floatingActionButton: 
            FloatingActionButton(
                onPressed: () {},
                tooltip: 'Create',
                child: const Icon(Icons.add),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: const _NavigationBar(
          fabLocation: FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}

class _NavigationBar extends StatelessWidget {

  const _NavigationBar({
    this.fabLocation = FloatingActionButtonLocation.endFloat,
  });

  final FloatingActionButtonLocation fabLocation;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.blue,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              tooltip: 'Open navigation menu',
              icon: const Icon(Icons.group_rounded),
              onPressed: null,
            ),
            IconButton(
              tooltip: 'Search',
              icon: const Icon(Icons.inbox_rounded),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Favorite',
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}