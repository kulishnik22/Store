import 'store_class.dart';

class StoreHolder {
  ///Static variable that holds the only instance of StoreHolder class
  static final StoreHolder _storeHolder = StoreHolder._internal();

  ///Map in which String is the key and Store of type dynamic is value
  ///
  ///Used to store instances of Store object
  final Map<String, Store<dynamic>> _storeInstanceMap = {};

  ///Factory constructor for StoreHolder class
  ///
  ///Returns the only instance of itself called [_storeHolder]
  factory StoreHolder() {
    return _storeHolder;
  }

  ///Private named constructor
  ///
  ///Used to initialize the only instance of itself
  StoreHolder._internal();

  ///Method that return generic [Store] instance
  ///
  ///Expects String [key] as parameter, retrieves the value from [_storeInstanceMap]
  ///and casts it to generic [Store]
  Store<T> getStoreInstance<T>(String key) {
    return _storeInstanceMap[key] as Store<T>;
  }

  ///Method for adding new [Store] instance
  ///
  ///Expects String [key] and generic [Store] as parameter
  ///Stores the values in [_storeInstanceMap]
  addStoreInstance<T>(String key, Store<T> store) {
    _storeInstanceMap[key] = store;
  }

  ///Method for removing the instance record in [_storeInstanceMap]
  ///
  ///Expects String [key]
  removeStoreInstance(String key) {
    _storeInstanceMap.remove(key);
  }

  ///Method for getting all String keys stored in [_storeInstanceMap]
  ///
  ///Returns List of type String
  List<String> getAllStoreInstanceKeys() {
    return _storeInstanceMap.keys.toList();
  }
}
