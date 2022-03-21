class Store<T> {
  T? _data;
  final List<Function(T?)> _storeListeners = [];

  T? get data {
    return _data;
  }

  set data(T? data) {
    _data = data;
    notifyListeners();
  }

  Store(this._data);
  Store.empty();

  addOnDataChangedListener(Function(T?) listener) {
    _storeListeners.add(listener);
  }

  notifyListeners() {
    for (var storeListener in _storeListeners) {
      storeListener.call(data);
    }
  }
}
