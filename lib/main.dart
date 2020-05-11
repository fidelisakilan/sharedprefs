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
  int refcounter = 0;
  Future<int> _counter;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;
    setState(() {
      _counter = prefs.setInt('counter', counter).then((value) => counter);
    });
  }

  @override
  void initState() {
    _counter =
        _prefs.then((SharedPreferences pref) => pref.getInt('counter') ?? 0);
    super.initState();
  }

  void instancecounter() {
    setState(() {
      refcounter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FutureBuilder(
              future: _counter,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('${snapshot.data}',style:Theme.of(context).textTheme.headline5),
                    MaterialButton(
                      color: Colors.green,
                      splashColor: Colors.blue[800],
                      child: Text('this should be presistent'),
                      onPressed: _incrementCounter,
                    )
                  ],
                );
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('$refcounter',style:Theme.of(context).textTheme.headline5),
                MaterialButton(
                    color: Colors.red,
                    splashColor: Colors.blueGrey,
                    child: Text('Not this'),
                    onPressed: () {
                      instancecounter();
                    }),
              ],
            )
          ],
        ),
      ),
      
    );
  }
}
