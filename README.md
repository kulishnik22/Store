# Store

**Simple package that allows you to store, retrieve and listen to your data anywhere across your project.**  
![StoreVersion](https://img.shields.io/badge/Store-1.0.5-blueviolet)

## Features

- Data storage
- On Data Changed Listener
- Singleton wrapper for your data
- Adding and retrieving the data using simple String keys with almost instant retrieval

## Getting started

First, add the following dependency to your pubspec.yaml.

```yaml
dependencies:
  data_storeholder: ^1.0.5
```

After that, run the `flutter packages get` or `dart pub get` command.

Next, add the following import to places where you need it.

```dart
import 'package:data_storeholder/store.dart';
```

---

# Store class

Store class is wrapper for your data. It can hold any type or object and adds useful functionality to it.

### Initializing

#### Empty constructor:

```dart
Store<String> stringStore = Store.empty();
```

#### Default constructor:

```dart
Store<String> stringStore = Store('Some default value');
```

### Usage

Store provides getter and setter for the `data` variable

```dart
stringStore.data = 'New data!';
print(stringStore.data);
```

This example should print 'New data!' in console.
Let's create listener for the variable so we don't have to call print method each time the data changes.
We can call `addOnDataChangedListener` method that accepts void Function as parameter. The function will provide the data variable as parameter.

```dart
stringStore.addOnDataChangedListener((data) => print(data));
```

Now each time we call the setter for the data variable inside of our stringStore, all listeners will be notified.

```dart
stringStore.data = 'Data has changed!';
```

This example should print 'Data has changed!' in console.
In case we don't want to change the data but we want to notify the listeners, we can call `notifyListeners` method.

```dart
stringStore.notifyListeners();
```

This should again print 'Data has changed!' because that is the current value stored in data variable.

If we wish to remove the listener, we can call `removeOnDataChangedListener` method which accepts void Function as parameter.

```dart
void printFunction(dynamic data) => print(data);
stringStore.addOnDataChangedListener(printFunction);
stringStore.data = '1';
stringStore.removeOnDataChangedListener(printFunction);
stringStore.data = '2';
```

The example above should only print `1` because at the point when data was set to `2`, the listener was already removed.

---

# StoreHolder class

StoreHolder class is single instance object that can hold instances of your Store.
It uses HashMap to store the instances so retrieval of the instance is almost instant.
This means that you can share your data anywhere in your project

### Initializing

#### Singleton constructor:

```dart
StoreHolder storeHolder = StoreHolder();
```

### Usage

We already created our Store instance. Now let's store it in StoreHolder so we can access it anywhere in our project.
To store it, we use `addStoreInstance` method that accepts String key and Store instance as parameter.

```dart
storeHolder.addStoreInstance('stringStore1', stringStore);
```

Method `safeAddStoreInstance` is used when we are not sure if there is any Store instance at given key.
The method return true is the supplied Store instance was added to the map. If there already exists some entry
at given key, the entry is preserved and the method returns false.

```dart
storeHolder.safeAddStoreInstance('stringStore1', stringStore);
```

> We recommend to name your key such that it contains the type of your Store instance as to avoid type mismatch.

Now the stringStore is stored in StoreHolder. We can access it anywhere else in project by calling `getStoreInstance` which accepts String key as parameter and returns our Store instance. In case there is no Store instance for given key, it returns new `Store.empty()` instance.

```dart
Store<String> stringStore1 = storeHolder.getStoreInstance('stringStore1');
```

> As you can see, naming the key such that we know that we are accessing Store of type String is very useful.

There are situations where we might want to work with nullable instances. For that case we can call `getNullableStoreInstance` which also accepts String key as parameter but returns nullable Store instance. This means that when the Store instance for given key was not found, it returns `null` instead of `Store.empty()`.

```dart
Store<String>? nullableStringStore = storeHolder.getNullableStoreInstance('stringStore1');
```

If we no longer need the Store instance to be stored in StoreHolder, we can call `removeStoreInstance` method that accepts String key as parameter.

```dart
storeHolder.removeStoreInstance('stringStore1');
```

The instance of our stringStore should still exist in place where it was created but it's no longer accessable from StoreHolder.
In case we need to see all the keys stored in StoreHolder, we can call `getAllStoreInstanceKeys` which returns a list of Strings.

```dart
List<String> storeInstanceKeys = storeHolder.getAllStoreInstanceKeys();
```

This method can be useful when we want to check that the instance exists or no longer exists in StoreHolder.
It can also be used to reconstruct the Store instance HashMap.
