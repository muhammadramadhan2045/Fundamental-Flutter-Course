import 'package:flutter/foundation.dart';

class BookmarkModuleProvider extends ChangeNotifier {
  List<String> _doneModuleList = [];

  List<String> get doneModuleList => _doneModuleList;

  void addDoneModule(String module) {
    _doneModuleList.add(module);
    notifyListeners();
  }

  void removeDoneModule(String module) {
    _doneModuleList.remove(module);
    notifyListeners();
  }
}
