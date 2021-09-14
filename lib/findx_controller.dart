import 'package:findx/findx_change_notifier.dart';

abstract class FindXController extends FindXChangeNotifier {

  final String? id;
  final bool permanent;

  FindXController({this.id,this.permanent = false});

  void update({List<String>? ids}){
    notifyListeners(ids);
  }
}