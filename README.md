# Store

**Simple data storage and retrieval package for your Dart project**  
![StoreVersion](https://img.shields.io/badge/Store-1.0.0-blueviolet)

## Features

- Data storage
- On Data Changed Listener
- Singleton wrapper for your data
- Adding and retrieving the data using simple String keys with almost instant retrieval

## Getting started

First, add the following dependency to your pubspec.yaml.

```yaml
dependencies:
  data_storeholder: ^1.0.0
```

After that, run the `flutter packages get` command.

Next, add tho following imports to your project.

```dart
import 'package:data_storeholder/store.dart';
```

## Usage

First, create your Store instance.
In this case we will set it to accept String value.

```dart
Store<String> stringStore = Store('Default value');
```

Let's also add listener to the stringStore.

```dart
stringStore.addOnDataChangedListener((data) => print(data));
```

We can then add this store instance to StoreHolder.
StoreHolder uses Map to store the instances so you need to specify key and value.
The key is always String and the value is always Store.
Don't worry. The StoreHolder is Singleton so you will get the same instance anywhere in your project.

```dart
StoreHolder storeHolder = StoreHolder();
storeHolder.addStoreInstance('stringStoreKey', stringStore);
```

Somewhere else in your project you can again get the StoreHolder instance
and with the key you specified you can retrieve the same Store instance.
you can then change the data and thus trigger the listener that we created.

```dart
StoreHolder storehHolder2 = StoreHolder();
Store<String> stringStore2 = storeHolder2.getStoreInstance('stringStoreKey') as Store<String>;
stringStore2.data = 'Data changed!'
```

In your console you should now see 'Data changed!' printed.

> **Note that you have to cast the instance retrieved from StoreHolder to the one you specified earlier.
> We recommend to name your keys such that they contain the type you need the Store to be cast to.**

If you want to trigger the listener without changing the date you can call the following method:

```dart
stringStore2.notifyListeners();
```

If you want to get all keys stored in the instance map of StoreHolder you can call the following method:

```dart
List<String> keyList = storeHolder2.getAllStoreInstanceKeys();
```

This is useful if you want to check if the StoreHolder contains the key you are looking for or when you want to reconstruct the map.
