import 'package:findx/findx_change_notifier.dart';
import 'package:flutter/widgets.dart';

abstract class FindXController extends FindXChangeNotifier {

  final String? id;
  final bool permanent;
  Map<String, FindXController>? _controllers;

  void allowComunicationWithOthers(Map<String,FindXController> controllers){
    _controllers = controllers;
  }

  FindXController({this.id,this.permanent = false,Map<String,FindXController>? controllers}){
    _controllers = controllers;
  }

  @protected
  T findOtherController<T extends FindXController>({String? id}) {
    var name = (id == null) ? T.toString() : T.toString() + id;

    if(_controllers == null)
      throw "Can't find controller $name from ${this.runtimeType} because ${this.runtimeType} is not allowed to find other controllers.";

    final controller = _controllers![name];

    if (controller == null)
      throw "Can't find controller $name, did you create it and put it in the tree?";

    return _controllers![name] as T;
  }

  void update({List<String>? ids}){
    notifyListeners(ids);
  }
}