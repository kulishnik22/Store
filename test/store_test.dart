import 'package:data_storeholder/store.dart';
import 'package:test/test.dart';

void main() {
  group('StoreHolder tests', () {
    Store<String> stringStore = Store('data');
    StoreHolder storeHolderA = StoreHolder();
    StoreHolder storeHolderB = StoreHolder();

    test('Singleton test', () => expect(storeHolderA, storeHolderB));

    test('Instance addition test',
        () => storeHolderA.addStoreInstance('stringStore', stringStore));

    test(
        'Instance holding test',
        () => expect(storeHolderA.getStoreInstance('stringStore'),
            storeHolderB.getStoreInstance('stringStore')));
    test('Instance removal test', () {
      storeHolderA.removeStoreInstance('stringStore');
      expect(storeHolderB.getNullableStoreInstance('stringStore'), null);
    });

    test('Instance null safety test', () {
      expect(storeHolderA.getNullableStoreInstance('thisInstanceDoesNotExist'),
          null);
      expect(storeHolderA.getStoreInstance('thisInstanceDoesNotExist'),
          Store.empty());
    });

    test('Key list retrieval test', () {
      var type = storeHolderB.getAllStoreInstanceKeys().runtimeType;
      List<String> emptyList = [];
      var type2 = emptyList.runtimeType;
      expect(type, type2);
    });
  });

  group('Store tests', () {
    Store<bool> boolStore = Store(false);
    bool? expectedValue;
    void expectedValueFunction(dynamic data) => expectedValue = data;

    test('Getting data test', () => expect(boolStore.data, false));

    test('Listener addition test',
        () => boolStore.addOnDataChangedListener(expectedValueFunction));

    test('Setting data test', () {
      boolStore.data = true;
      expect(boolStore.data, true);
    });

    test(
        'Listener triggered test', () => expect(boolStore.data, expectedValue));

    test('Listener removal test', () {
      boolStore.removeOnDataChangedListener(expectedValueFunction);
      boolStore.data = !boolStore.data!;
      expect(boolStore.data, !expectedValue!);
    });
  });
}
