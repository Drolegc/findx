import 'package:findx/findx_controller.dart';
import 'package:flutter/widgets.dart';

class FindXStore extends InheritedWidget {

  final _FindXStore store =_FindXStore();

  FindXStore({required Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static FindXStore? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<FindXStore>();
}

class _FindXStore {

  final Map<String,FindXController> _controllers = {};


  T find<T extends FindXController>({String? id}) {
    var name = (id == null) ? T.toString() : T.toString() + id;
    final controller = _controllers[name];

    if(controller == null)
      throw "Can't find controller, did you create it and put it in the tree?";

    return _controllers[name] as T;
  }

  void put<T extends FindXController>(T controller,{String? id}){
    var name = (id == null) ? controller.runtimeType.toString() : controller.runtimeType.toString() + id;
    _controllers[name] = controller;
  }
}