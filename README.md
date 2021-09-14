# FindX

FindX is a Flutter state manager inspired in the controllers and the widget GetBuilder of GetX

## Why I made this package
1) Because I want to try to make a package hehe
2) I really like GetX as a state manager, I like how GetControllers works, I like Obx, GetBuilder and GetView. But sometimes GetX acts in weird ways, like, deletes controllers that suppose to not be deleted, and other times it does not delete controllers that suppose to be deleted.
3) I want to try to make a package easy to understand what's happening behind the scenes.

## How to use it

To use FindX, first, we need to create on the widget tree the FindXStore widget, this widget will store all the controllers

```dart
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
```

Now we need our controller

```dart
class Controller extends FindXController {
  String sampleData = "example";

  void changeRandomData() {
    sampleData = _generateRandomString(10);
    this.update();
  }

  String _generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}
```

If you want global controllers, there is the globalControllers option on FindXStore

```dart
    return FindXStore(
      globalControllers: [
        GlobalController()
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: Test(),
      ),
    );
```

Now we can inject controllers from different ways

```
FindXStore.of(context)!.store.put<Controller>(Controller());
```

and use it down on the tree as

```
FindXStore.of(context)!.store.find<Controller>();
```

Don't forget to remove the controller if you don't use it anymore

```
Find.of(context)!.store.remove<Controller>();
```

But for all this, there is a better way to do it
with...

### FindXBuilder

It's like GetBuilder from GetX

```dart

FindXBuilder<Controller>(
        builder: (Controller _) {
          return TextButton(
              onPressed: () {
                _.changeRandomData();
              },
              child: Text(_.sampleData));
        });
```

FindXBuilder will find the controller that we want, serve on the builder function, and when the page gets dispose FindXStore will remove the controller **if** there is no other FindXBuilder using it.

If you didn't inject the controller that you want to use, there is the option **put:** to do it

```dart
FindXBuilder<Controller>(
        put: Controller()
        builder: (Controller _) {
          return TextButton(
              onPressed: () {
                _.changeRandomData();
              },
              child: Text(_.sampleData));
        });
```

*If you use this option FindXBuilder will call FindXStore.of(context)!.store.put<Controller>(Controller())
and inject the controller, but it will use the object of this controller too.*

*So, if you got another FindXBuilder with **put: Controller()** it will try to put it into the store (unsuccessfully) and will use the object.*

And to make all this **reactive**, you can call the method **update()** from the controller and this will update all the FindXBuilder that depends on this controller.

If you want to update just a few FindXBuilders, you can specified an id with the **id** option  and then call update with a list of ids **update(['fxbuilder1','fxbuilder2'])**

