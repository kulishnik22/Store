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

  ///Method that returns generic [Store] instance
  ///
  ///Expects String [key] as parameter, retrieves the value from [_storeInstanceMap]
  ///In case the value is null, it returns empty Store instance
  ///If the value is not null, it is cast to generic [Store] and returned
  Store<T> getStoreInstance<T>(String key) {
    if (_storeInstanceMap[key] == null) {
      return Store.empty();
    } else {
      return _storeInstanceMap[key] as Store<T>;
    }
  }

  ///Method that returns generic [Store] instance
  ///
  ///Expects String [key] as parameter, retrieves the value from [_storeInstanceMap]
  ///In case the value is null, it returns null
  ///If the value is not null, it is cast to generic [Store] and returned
  Store<T>? getNullableStoreInstance<T>(String key) {
    if (_storeInstanceMap[key] == null) {
      return null;
    }
    return _storeInstanceMap[key] as Store<T>;
  }

  ///Method for adding new [Store] instance
  ///
  ///Expects String [key] and generic [Store] as parameter
  ///Stores the values in [_storeInstanceMap]
  addStoreInstance<T>(String key, Store<T> store) {
    _storeInstanceMap[key] = store;
  }

  ///Method for adding new [Store] instance with safety
  ///
  ///Expects String [key] and generic [Store] as parameter
  ///If instance in map at given [key] is null, the store is added
  ///If instance in map at given [key] is not null, the instance is
  /// preserved and nothing is overwriten.
  ///Returns true if the instance was added and false if the value was preserved.
  bool safeAddStoreInstance<T>(String key, Store<T> store) {
    bool instanceIsNull = _storeInstanceMap[key] == null;
    _storeInstanceMap[key] = instanceIsNull ? store : _storeInstanceMap[key]!;
    return instanceIsNull;
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
