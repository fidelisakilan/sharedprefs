
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SharedPreferences Demo',
      home: SharedPreferencesDemo(),
    );
  }
}
class SharedPreferencesDemo extends StatefulWidget {
  @override
  _SharedPreferencesDemoState createState() => _SharedPreferencesDemoState();
}

class _SharedPreferencesDemoState extends State<SharedPreferencesDemo> {
  Future<int> _counter;
  Future<SharedPreferences> _prefs=SharedPreferences.getInstance();

  Future<void> _incrementCounter() async{
    final SharedPreferences prefs= await _prefs;
    final int counter=(prefs.getInt('counter') ??0) +1;
    setState(() {
      _counter= prefs.setInt('counter', counter).then((value) => counter);
      
    });

  }
  @override
  void initState() {
    _counter=_prefs.then((SharedPreferences pref) => pref.getInt('counter') ?? 0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _counter,
          builder: (BuildContext context,AsyncSnapshot snapshot){
            return Text(
              '${snapshot.data}  this should be presistent'
            );

          },
        ),
      ),
      
       floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}