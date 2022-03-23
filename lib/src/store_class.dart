class Store<T> {
  ///User stored data
  T? _data;

  ///List of listener Functions
  final List<Function(T? data)> _storeListeners = [];

  ///Custom operator
  @override
  bool operator ==(Object other) =>
      other is Store<T> &&
      other._data == _data &&
      _listsAreEqual(_storeListeners, other._storeListeners);

  ///hashCode
  @override
  int get hashCode => Object.hash(_data, _storeListeners);

  ///Helper function for checking equality of lists
  ///
  ///If [listA] and [listB] have different length, return false
  ///If [listB] contains all elements as [listA], return true, otherwise return false
  bool _listsAreEqual(
    List<Function(T? data)> listA,
    List<Function(T? data)> listB,
  ) {
    if (listA.length != listB.length) {
      return false;
    }
    return listA.every((element) => listB.contains(element));
  }

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
  addOnDataChangedListener(Function(T? data) listener) {
    _storeListeners.add(listener);
  }

  ///Method for removing listener
  ///
  ///Expects Function of type [T] called [listener]
  ///Removes the [listener] from [_storeListeners] list
  removeOnDataChangedListener(Function(T? data) listener) {
    _storeListeners.remove(listener);
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
