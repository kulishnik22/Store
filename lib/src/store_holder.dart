import 'store_class.dart';

class StoreHolder {
  static final StoreHolder _storeHolder = StoreHolder._internal();
  final Map<String, Store<dynamic>> _storeInstanceMap = {};

  factory StoreHolder() {
    return _storeHolder;
  }
  StoreHolder._internal();

  Store<dynamic>? getStoreInstance(String key) {
    return _storeInstanceMap[key];
  }

  addStoreInstance(String key, Store<dynamic> store) {
    _storeInstanceMap[key] = store;
  }

  removeStoreInstance(String key) {
    _storeInstanceMap.remove(key);
  }

  List<String> getAllStoreInstanceKeys() {
    return _storeInstanceMap.keys.toList();
  }
}
