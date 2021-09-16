import 'package:findx/findx_controller.dart';
import 'package:flutter/widgets.dart';

class FindXStore extends InheritedWidget {
  _FindXStore _store = _FindXStore();
  _FindXStore get store => _store;

  List<FindXController>? globalControllers;

  FindXStore({required Widget child, this.globalControllers})
      : super(child: child) {
    globalControllers?.forEach((controller) {
      _store.put(controller, id: controller.id ?? null);
    });
  }

  @override
  bool updateShouldNotify(covariant FindXStore oldWidget) {
    _store = oldWidget.store;
    return true;
  }

  static FindXStore? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FindXStore>();
}

class _FindXStore {
  final Map<String, FindXController> _controllers = {};

  T find<T extends FindXController>({String? id}) {
    var name = (id == null) ? T.toString() : T.toString() + id;
    final controller = _controllers[name];

    if (controller == null)
      throw "Can't find controller $name, did you create it and put it in the tree?";

    return _controllers[name] as T;
  }

  void put<T extends FindXController>(T controller, {String? id,bool allowComunicationWithOthers = false}) {
    var name = (id == null)
        ? controller.runtimeType.toString()
        : controller.runtimeType.toString() + id;

    if (_controllers[name] == null) {
      controller.allowComunicationWithOthers(_controllers);
      _controllers[name] = controller;
    }
  }

  void remove<T extends FindXController>({String? id}) {
    var name = (id == null) ? T.toString() : T.toString() + id;
    final controller = _controllers[name];

    if (controller == null)
      throw "Can't find controller $name to delete, did you create it and put it in the tree?";

    if (controller.permanent)
      throw "Can't delete the controller $name because it is permanent, try calling forceRemove";

    if (!controller.hasListeners) _controllers.remove(name);
  }

  void forceRemove<T extends FindXController>({String? id}) {
    var name = (id == null) ? T.toString() : T.toString() + id;
    final controller = _controllers[name];

    if (controller == null)
      throw "Can't find controller $name to delete, did you create it and put it in the tree?";

    if (!controller.hasListeners) _controllers.remove(name);

    //Delete controller
    //print("Listeners: ${controller.hasListeners}");
  }
}
