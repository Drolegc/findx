
import 'dart:math';

import 'package:findx/findx_controller.dart';

class Controller extends FindXController {
  String sampleData = "example";

  //Controller({String? id}):super(id: id);

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

class GlobalController extends FindXController {
  String data = "Im a global controller";

  GlobalController():super(permanent: true);

  void changeRandomData() {
    data = data + _generateRandomString(10);
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

class CommunicationWithOthers extends FindXController {

  void testCommunication(){
    var globalControllerComm = findOtherController<GlobalController>();
    print(globalControllerComm);
  }
}