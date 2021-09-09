import 'package:findx/findx_change_notifier.dart';
import 'package:flutter/widgets.dart';

abstract class FindXController extends FindXChangeNotifier {

  final BuildContext? needContext;
  final String? id;

  FindXController({this.needContext,this.id});

  void update({List<String>? ids}){
    notifyListeners(ids);
  }
}