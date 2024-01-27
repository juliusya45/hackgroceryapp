import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoadingHome extends StatefulWidget {
  const LoadingHome({super.key});

  @override
  State<LoadingHome> createState() => _LoadingHomeState();
}

class _LoadingHomeState extends State<LoadingHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loading Home"),
      ),
    );
  }
}