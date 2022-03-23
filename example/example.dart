import 'package:data_storeholder/store.dart';

void main() {
  Store<String> hiStore = Store('Hi!');
  print(hiStore.data);
  hiStore.addOnDataChangedListener((data) => print(data));
  StoreHolder storeHolder = StoreHolder();
  storeHolder.addStoreInstance('stringGreetingStore', hiStore);

  StoreHolder sameStoreHolder = StoreHolder();
  Store<String>? helloStore =
      sameStoreHolder.getNullableStoreInstance('stringGreetingStore');
  helloStore!.data = 'Hello!';

  Store<String> nonNullHelloStore =
      sameStoreHolder.getStoreInstance('stringGreetingStore');
  print(nonNullHelloStore.data);

  if (storeHolder == sameStoreHolder) {
    print('These StoreHolders are the same!');
  }
  if (hiStore == helloStore) {
    print('These Stores are the same!');
  }
}
