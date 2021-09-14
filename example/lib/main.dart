
import 'package:findx/findx_builder.dart';
import 'package:findx/findx_store.dart';
import 'package:flutter/material.dart';
import 'package:test_findx/controllers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FindXStore(
      globalControllers: [
        GlobalController()
      ],
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
    FindXStore.of(context)!.store.put(Controller(
    )..sampleData = "okokoko");

    return Scaffold(
      body: Center(
        child: FindXBuilder<Controller>(
          put: Controller(),
          builder: (_) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    _.changeRandomData();
                  },
                  child: Text(_.sampleData)),
              AnotherFindXBuilder(),
              LastFindXBuilder(),
              TextButton(
                child: Text("To another page"),
                onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SecondRoute()),);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FindXStore.of(context)!.store.find<GlobalController>().data),
      ),
      body: Column(
        children: [
          FindXBuilder<GlobalController>(
            builder:(_) => TextButton(
              child: Text("Change data global controller - ${_.data}"),
              onPressed: (){
                _.changeRandomData();
              },
            ),
          ),
          TextButton(
            child: Text("Remove global controller"),
            onPressed: (){
              FindXStore.of(context)!.store.forceRemove<GlobalController>();

            },
          ),
          TextButton(
            child: Text("Go back to first"),
            onPressed: (){

              FindXStore.of(context)!.store.remove<Controller>();
            },
          ),
        ],
      ),
    );
  }
}


class FirstFindXBuilder extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FindXBuilder<Controller>(builder: (controller) {
      return TextButton(
          onPressed: () {
            controller.changeRandomData();
          },
          child: Text("First builder" + controller.sampleData));
    });
  }
}

class AnotherFindXBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FindXBuilder<Controller>(builder: (controller) {
      return TextButton(
          onPressed: () {
            controller.changeRandomData();
          },
          child: Text("Second builder" + controller.sampleData));
    });
  }
}

class LastFindXBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FindXBuilder<Controller>(
        //put: Controller(),
        builder: (_) {
          return TextButton(
              onPressed: () {
                _.changeRandomData();
              },
              child: Text("Last builder" + _.sampleData));
        });
  }
}


