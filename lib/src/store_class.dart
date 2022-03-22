class Store<T> {
  ///User stored data
  T? _data;

  ///List of listener Functions
  final List<Function(T?)> _storeListeners = [];

  ///Getter for user stored data
  ///
  ///returns data of type [T]
  T? get data {
    return _data;
  }

  ///Setter for user stored data
  ///
  ///Expects [data] of type [T] and calls [notifyListeners] method
  set data(T? data) {
    _data = data;
    notifyListeners();
  }

  ///Standard Store constructor
  ///
  ///Initializes [_data] variable
  Store(this._data);

  ///Empty Store constructor
  ///
  ///Returns Store in which [_data] is null
  Store.empty();

  ///Method for adding new listener for [_data] variable
  ///
  ///Expects Function of type [T] called [listener]
  ///Adds the [listener] to [_storeListeners] list
  addOnDataChangedListener(Function(T?) listener) {
    _storeListeners.add(listener);
  }

  ///Method for notifying all listeners
  ///
  ///Loops through [_storeListeners] list and calls each Function with [_data] as parameter
  notifyListeners() {
    for (var storeListener in _storeListeners) {
      storeListener.call(_data);
    }
  }
}
