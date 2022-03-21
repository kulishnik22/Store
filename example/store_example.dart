import 'package:data_store/store.dart';

void main() {
  //Obtaining singleton StoreHolder instance
  StoreHolder storeHolder = StoreHolder();
  //Creating new empty Store instance
  Store<String> stringStore = Store.empty();
  //Adding the store instance to StoreHolder with retrieval key
  storeHolder.addStoreInstance('stringStore', stringStore);
  //Creating new listener for data inside the store
  stringStore.addOnDataChangedListener((data) => print(data));

  //Retrieving the Store instance from StoreHolder using the specified key
  //Note that the Store instance has to be cast to correct type
  Store<String> stringStore2 =
      storeHolder.getStoreInstance('stringStore') as Store<String>;
  //Changing the data inside the store instance which triggers the listener
  stringStore2.data = 'notified!';
  //If we only want to trigger the listeners without changing the data, we call 'notifyListeners' method
  stringStore2.notifyListeners();

  //Adding new Store instance with default value
  Store<int> integerStore = Store(11);
  storeHolder.addStoreInstance('integerStore', integerStore);

  //Creating new variable for StoreHolder
  StoreHolder storeHolder2 = StoreHolder();
  //We can get a list of all instance keys stored in the StoreHolder
  //The new storeHolder2 variable should hold all instances that storeHolder has
  if (storeHolder2.getAllStoreInstanceKeys().contains('integerStore')) {
    Store<int> innerIntegerStore =
        storeHolder2.getStoreInstance('integerStore') as Store<int>;
    innerIntegerStore.addOnDataChangedListener((data) => print(data! + 11));
  }
  //Now let's call notifyListeners from the integerStore and observe that the listener in innerIntegerStore is called
  integerStore.notifyListeners();

  //If we want to get rid of unused Store instance, we can call 'removeStoreInstance' method
  storeHolder2.removeStoreInstance('stringStore');
  //At this point it shouldn't be possible to call getStoreInstance in StoreHolder with given key
  //If the Store instance is stored in variable, it should still exist but it won't be accessable via StoreHolder
  stringStore.data = 'I still exist!';
}
