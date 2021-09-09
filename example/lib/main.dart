import 'dart:math';

import 'package:findx/findx_builder.dart';
import 'package:findx/findx_controller.dart';
import 'package:findx/findx_store.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FindXStore(
      child: MaterialApp(
        title: 'Flutter Demo',
        home: Test(),
      ),
    );
  }
}

class Test extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //FindXStore.of(context)!.store.put(Controller());

    return Scaffold(
      body: Center(
        child: FindXBuilder<Controller>(
          put: Controller(),
          builder: (_) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: (){
                _.changeRandomData();
              }, child: Text(_.sampleData)),
              AnotherFindXBuilder(),
              LastFindXBuilder()
            ],
          ),
        ),
      ),
    );
  }
}

class AnotherFindXBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FindXBuilder<Controller>(
        builder: (controller){
          return TextButton(onPressed: (){
            controller.changeRandomData();
          }, child: Text("Second builder" + controller.sampleData));
    });
  }
}


class LastFindXBuilder extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FindXBuilder<Controller>(
      put: Controller(id: "2"),
        builder: (_){
          return TextButton(onPressed: (){
            _.changeRandomData();
          }, child: Text("Last builder" + _.sampleData));
    });
  }
}



class Controller extends FindXController {
  String sampleData = "example";

  Controller({String? id}):super(id: id);

  void changeRandomData(){
    sampleData = _generateRandomString(10);
    this.update();
  }

  String _generateRandomString(int len) {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }
}

