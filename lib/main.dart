import 'package:flutter/material.dart';
import 'package:university_management_system/Routes/Routes.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: 'Univeristy Management System',
      home: new Routes()
      );
  }
}