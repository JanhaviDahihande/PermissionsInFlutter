import 'package:flutter/material.dart';
import 'dart:async';
import 'package:simple_permissions/simple_permissions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Permissions',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Permissions'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _status;
  Permission permission;

  @override
  void initState() {
    super.initState();
    _status = "Select an item";
    print(Permission.values);
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(_status),
            DropdownButton(items: _getItems(), value: permission,  onChanged: _onDropDownChanged),
            RaisedButton(onPressed: _checkPermission, child: Text("Check Permission"),),
            RaisedButton(onPressed: _requestPermission, child: Text("Request Permission"),),
            RaisedButton(onPressed: _getStatus, child: Text("Get status"),)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: SimplePermissions.openSettings,
        tooltip: 'Settings',
        child: Icon(Icons.settings),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<DropdownMenuItem<Permission>> _getItems() {
    List<DropdownMenuItem<Permission>> _items = new List<DropdownMenuItem<Permission>>();
    Permission.values.forEach((permission) {
      var _item = new DropdownMenuItem(child: Text(getPermissionString(permission)), value: permission);
      _items.add(_item);
    });
    return _items;
  }
  _onDropDownChanged(Permission permission) {
    setState(() {
      this.permission = permission;
      _status = "Click a button below";
    });
  }
  _checkPermission() async {
    bool res = await SimplePermissions.checkPermission(permission);
    print("permission is " + res.toString());
    setState(() {
      _status = "${permission.toString()} = ${res.toString()}";
    });
  }
  _requestPermission() async {
    final result = await SimplePermissions.requestPermission(permission);
    print("Permission resulttt is ${result.toString()}");
    setState(() {
      _status = "${permission.toString()} = ${result.toString()}";
    });
  }
  _getStatus() async{
  final result = await SimplePermissions.getPermissionStatus(permission);
    print("Permission result is ${result.toString()}");
    setState(() {
      _status = "${permission.toString()} = ${result.toString()}";
    });
  }
}
