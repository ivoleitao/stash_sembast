import 'dart:io';

import 'package:stash/stash_harness.dart';
import 'package:stash_sembast/stash_sembast.dart';
import 'package:test/test.dart';

void main() async {
  Future<SembastStore> newStore(
      {dynamic Function(Map<String, dynamic>) fromEncodable}) {
    return Directory.systemTemp
        .createTemp('stash_sembast')
        .then((d) => SembastStore(d.path, fromEncodable: fromEncodable));
  }

  Future<SembastStore> newObjectStore(
      {dynamic Function(Map<String, dynamic>) fromEncodable}) {
    return newStore(fromEncodable: fromEncodable);
  }

  Future<SembastStore> newSampleObjectStore() {
    return newObjectStore(
        fromEncodable: (Map<String, dynamic> json) =>
            SampleClass.fromJson(json));
  }

  Future<void> deleteStore(SembastStore store) {
    return store.deleteAll();
  }

  test('Boolean', () async {
    await testStoreWith<SembastStore>(newStore, BoolGenerator(), deleteStore);
    await testCacheWith<SembastStore>(
        newStore, newDefaultCache, BoolGenerator(), deleteStore);
  });

  test('Int', () async {
    await testStoreWith<SembastStore>(newStore, IntGenerator(), deleteStore);
    await testCacheWith<SembastStore>(
        newStore, newDefaultCache, IntGenerator(), deleteStore);
  });

  test('Double', () async {
    await testStoreWith<SembastStore>(newStore, DoubleGenerator(), deleteStore);
    await testCacheWith<SembastStore>(
        newStore, newDefaultCache, DoubleGenerator(), deleteStore);
  });

  test('String', () async {
    await testStoreWith<SembastStore>(newStore, StringGenerator(), deleteStore);
    await testCacheWith<SembastStore>(
        newStore, newDefaultCache, StringGenerator(), deleteStore);
  });

  test('List<bool>', () async {
    await testStoreWith<SembastStore>(
        newStore, IteratorGenerator(BoolGenerator()), deleteStore);
    await testCacheWith<SembastStore>(newStore, newDefaultCache,
        IteratorGenerator(BoolGenerator()), deleteStore);
  });

  test('List<int>', () async {
    await testStoreWith<SembastStore>(
        newStore, IteratorGenerator(IntGenerator()), deleteStore);
    await testCacheWith<SembastStore>(newStore, newDefaultCache,
        IteratorGenerator(IntGenerator()), deleteStore);
  });

  test('List<double>', () async {
    await testStoreWith<SembastStore>(
        newStore, IteratorGenerator(DoubleGenerator()), deleteStore);
    await testCacheWith<SembastStore>(newStore, newDefaultCache,
        IteratorGenerator(DoubleGenerator()), deleteStore);
  });

  test('List<String>', () async {
    await testStoreWith<SembastStore>(
        newStore, IteratorGenerator(StringGenerator()), deleteStore);
    await testCacheWith<SembastStore>(newStore, newDefaultCache,
        IteratorGenerator(StringGenerator()), deleteStore);
  });

  test('Map<bool,bool>', () async {
    await testStoreWith<SembastStore>(
        newStore, MapGenerator(BoolGenerator(), BoolGenerator()), deleteStore);
    await testCacheWith<SembastStore>(newStore, newDefaultCache,
        MapGenerator(BoolGenerator(), BoolGenerator()), deleteStore);
  }, skip: 'Map<bool,bool> is not supported by Sembast');

  test('Map<bool,int>', () async {
    await testStoreWith<SembastStore>(
        newStore, MapGenerator(BoolGenerator(), IntGenerator()), deleteStore);
    await testCacheWith<SembastStore>(newStore, newDefaultCache,
        MapGenerator(BoolGenerator(), IntGenerator()), deleteStore);
  }, skip: 'Map<bool,int> is not supported by Sembast');

  test('Map<bool,double>', () async {
    await testStoreWith<SembastStore>(newStore,
        MapGenerator(BoolGenerator(), DoubleGenerator()), deleteStore);
    await testCacheWith<SembastStore>(newStore, newDefaultCache,
        MapGenerator(BoolGenerator(), DoubleGenerator()), deleteStore);
  }, skip: 'Map<bool,double> is not supported by Sembast');

  test('Map<bool,String>', () async {
    await testStoreWith<SembastStore>(newStore,
        MapGenerator(BoolGenerator(), StringGenerator()), deleteStore);
    await testCacheWith<SembastStore>(newStore, newDefaultCache,
        MapGenerator(BoolGenerator(), StringGenerator()), deleteStore);
  }, skip: 'Map<bool,String> is not supported by Sembast');

  test('Map<int,bool>', () async {
    await testStoreWith<SembastStore>(
        newStore, MapGenerator(IntGenerator(), BoolGenerator()), deleteStore);
    await testCacheWith<SembastStore>(newStore, newDefaultCache,
        MapGenerator(IntGenerator(), BoolGenerator()), deleteStore);
  }, skip: 'Map<int,bool> is not supported by Sembast');

  test('Map<int,int>', () async {
    await testStoreWith<SembastStore>(
        newStore, MapGenerator(IntGenerator(), IntGenerator()), deleteStore);
    await testCacheWith<SembastStore>(newStore, newDefaultCache,
        MapGenerator(IntGenerator(), IntGenerator()), deleteStore);
  }, skip: 'Map<int,int> is not supported by Sembast');

  test('Map<int,double>', () async {
    await testStoreWith<SembastStore>(
        newStore, MapGenerator(IntGenerator(), DoubleGenerator()), deleteStore);
    await testCacheWith<SembastStore>(newStore, newDefaultCache,
        MapGenerator(IntGenerator(), DoubleGenerator()), deleteStore);
  }, skip: 'Map<int,double> is not supported by Sembast');

  test('Map<int,String>', () async {
    await testStoreWith<SembastStore>(
        newStore, MapGenerator(IntGenerator(), StringGenerator()), deleteStore);
    await testCacheWith<SembastStore>(newStore, newDefaultCache,
        MapGenerator(IntGenerator(), StringGenerator()), deleteStore);
  }, skip: 'Map<int,String> is not supported by Sembast');

  test('Map<double,bool>', () async {
    await testStoreWith<SembastStore>(newStore,
        MapGenerator(DoubleGenerator(), BoolGenerator()), deleteStore);
    await testCacheWith<SembastStore>(newStore, newDefaultCache,
        MapGenerator(DoubleGenerator(), BoolGenerator()), deleteStore);
  }, skip: 'Map<double,bool> is not supported by Sembast');

  test('Map<double,int>', () async {
    await testStoreWith<SembastStore>(
        newStore, MapGenerator(DoubleGenerator(), IntGenerator()), deleteStore);
    await testCacheWith<SembastStore>(newStore, newDefaultCache,
        MapGenerator(DoubleGenerator(), IntGenerator()), deleteStore);
  }, skip: 'Map<double,int> is not supported by Sembast');

  test('Map<double,double>', () async {
    await testStoreWith<SembastStore>(newStore,
        MapGenerator(DoubleGenerator(), DoubleGenerator()), deleteStore);
    await testCacheWith<SembastStore>(newStore, newDefaultCache,
        MapGenerator(DoubleGenerator(), DoubleGenerator()), deleteStore);
  }, skip: 'Map<double,double> is not supported by Sembast');

  test('Map<double,String>', () async {
    await testStoreWith<SembastStore>(newStore,
        MapGenerator(DoubleGenerator(), StringGenerator()), deleteStore);
    await testCacheWith<SembastStore>(newStore, newDefaultCache,
        MapGenerator(DoubleGenerator(), StringGenerator()), deleteStore);
  }, skip: 'Map<double,String> is not supported by Sembast');

  test('Map<String,bool>', () async {
    await testStoreWith<SembastStore>(newStore,
        MapGenerator(StringGenerator(), BoolGenerator()), deleteStore);
    await testCacheWith<SembastStore>(newStore, newDefaultCache,
        MapGenerator(StringGenerator(), BoolGenerator()), deleteStore);
  });

  test('Map<String,int>', () async {
    await testStoreWith<SembastStore>(
        newStore, MapGenerator(StringGenerator(), IntGenerator()), deleteStore);
    await testCacheWith<SembastStore>(newStore, newDefaultCache,
        MapGenerator(StringGenerator(), IntGenerator()), deleteStore);
  });

  test('Map<double,double>', () async {
    await testStoreWith<SembastStore>(newStore,
        MapGenerator(StringGenerator(), DoubleGenerator()), deleteStore);
    await testCacheWith<SembastStore>(newStore, newDefaultCache,
        MapGenerator(StringGenerator(), DoubleGenerator()), deleteStore);
  });

  test('Map<String,String>', () async {
    await testStoreWith<SembastStore>(newStore,
        MapGenerator(StringGenerator(), StringGenerator()), deleteStore);
    await testCacheWith<SembastStore>(newStore, newDefaultCache,
        MapGenerator(StringGenerator(), StringGenerator()), deleteStore);
  });

  test('Class<bool>', () async {
    await testStoreWith<SembastStore>(newSampleObjectStore,
        SampleClassGenerator(BoolGenerator()), deleteStore);
    await testCacheWith<SembastStore>(newSampleObjectStore, newDefaultCache,
        SampleClassGenerator(BoolGenerator()), deleteStore);
  });

  test('Class<int>', () async {
    await testStoreWith<SembastStore>(newSampleObjectStore,
        SampleClassGenerator(IntGenerator()), deleteStore);
    await testCacheWith<SembastStore>(newSampleObjectStore, newDefaultCache,
        SampleClassGenerator(IntGenerator()), deleteStore);
  });

  test('Class<double>', () async {
    await testStoreWith<SembastStore>(newSampleObjectStore,
        SampleClassGenerator(DoubleGenerator()), deleteStore);
    await testCacheWith<SembastStore>(newSampleObjectStore, newDefaultCache,
        SampleClassGenerator(DoubleGenerator()), deleteStore);
  });

  test('Class<String>', () async {
    await testStoreWith<SembastStore>(newSampleObjectStore,
        SampleClassGenerator(StringGenerator()), deleteStore);
    await testCacheWith<SembastStore>(newSampleObjectStore, newDefaultCache,
        SampleClassGenerator(StringGenerator()), deleteStore);
  });

  test('Class<List<bool>>', () async {
    await testStoreWith<SembastStore>(newSampleObjectStore,
        SampleClassGenerator(IteratorGenerator(BoolGenerator())), deleteStore);
    await testCacheWith<SembastStore>(newSampleObjectStore, newDefaultCache,
        SampleClassGenerator(IteratorGenerator(BoolGenerator())), deleteStore);
  });

  test('Class<List<int>>', () async {
    await testStoreWith<SembastStore>(newSampleObjectStore,
        SampleClassGenerator(IteratorGenerator(IntGenerator())), deleteStore);
    await testCacheWith<SembastStore>(newSampleObjectStore, newDefaultCache,
        SampleClassGenerator(IteratorGenerator(IntGenerator())), deleteStore);
  });

  test('Class<List<double>>', () async {
    await testStoreWith<SembastStore>(
        newSampleObjectStore,
        SampleClassGenerator(IteratorGenerator(DoubleGenerator())),
        deleteStore);
    await testCacheWith<SembastStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(IteratorGenerator(DoubleGenerator())),
        deleteStore);
  });

  test('Class<List<String>>', () async {
    await testStoreWith<SembastStore>(
        newSampleObjectStore,
        SampleClassGenerator(IteratorGenerator(StringGenerator())),
        deleteStore);
    await testCacheWith<SembastStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(IteratorGenerator(StringGenerator())),
        deleteStore);
  });

  test('Class<Map<bool,bool>>', () async {
    await testStoreWith<SembastStore>(
        newSampleObjectStore,
        SampleClassGenerator(MapGenerator(BoolGenerator(), BoolGenerator())),
        deleteStore);
    await testCacheWith<SembastStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(MapGenerator(BoolGenerator(), BoolGenerator())),
        deleteStore);
  }, skip: 'Class<Map<bool,bool>> is not supported by Sembast');

  test('Class<Map<bool,int>>', () async {
    await testStoreWith<SembastStore>(
        newSampleObjectStore,
        SampleClassGenerator(MapGenerator(BoolGenerator(), IntGenerator())),
        deleteStore);
    await testCacheWith<SembastStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(MapGenerator(BoolGenerator(), IntGenerator())),
        deleteStore);
  }, skip: 'Class<Map<bool,int>> is not supported by Sembast');

  test('Class<Map<bool,double>>', () async {
    await testStoreWith<SembastStore>(
        newSampleObjectStore,
        SampleClassGenerator(MapGenerator(BoolGenerator(), DoubleGenerator())),
        deleteStore);
    await testCacheWith<SembastStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(MapGenerator(BoolGenerator(), DoubleGenerator())),
        deleteStore);
  }, skip: 'Class<Map<bool,double>> is not supported by Sembast');

  test('Class<Map<bool,String>>', () async {
    await testStoreWith<SembastStore>(
        newSampleObjectStore,
        SampleClassGenerator(MapGenerator(BoolGenerator(), StringGenerator())),
        deleteStore);
    await testCacheWith<SembastStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(MapGenerator(BoolGenerator(), StringGenerator())),
        deleteStore);
  }, skip: 'Class<Map<bool,String>> is not supported by Sembast');

  test('Class<Map<int,bool>>', () async {
    await testStoreWith<SembastStore>(
        newSampleObjectStore,
        SampleClassGenerator(MapGenerator(IntGenerator(), BoolGenerator())),
        deleteStore);
    await testCacheWith<SembastStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(MapGenerator(IntGenerator(), BoolGenerator())),
        deleteStore);
  }, skip: 'Class<Map<int,bool>> is not supported by Sembast');

  test('Class<Map<int,int>>', () async {
    await testStoreWith<SembastStore>(
        newSampleObjectStore,
        SampleClassGenerator(MapGenerator(IntGenerator(), IntGenerator())),
        deleteStore);
    await testCacheWith<SembastStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(MapGenerator(IntGenerator(), IntGenerator())),
        deleteStore);
  }, skip: 'Class<Map<int,int>> is not supported by Sembast');

  test('Class<Map<int,double>>', () async {
    await testStoreWith<SembastStore>(
        newSampleObjectStore,
        SampleClassGenerator(MapGenerator(IntGenerator(), DoubleGenerator())),
        deleteStore);
    await testCacheWith<SembastStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(MapGenerator(IntGenerator(), DoubleGenerator())),
        deleteStore);
  }, skip: 'Class<Map<int,double>> is not supported by Sembast');

  test('Class<Map<int,String>>', () async {
    await testStoreWith<SembastStore>(
        newSampleObjectStore,
        SampleClassGenerator(MapGenerator(IntGenerator(), StringGenerator())),
        deleteStore);
    await testCacheWith<SembastStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(MapGenerator(IntGenerator(), StringGenerator())),
        deleteStore);
  }, skip: 'Class<Map<int,String>> is not supported by Sembast');

  test('Class<Map<double,bool>>', () async {
    await testStoreWith<SembastStore>(
        newSampleObjectStore,
        SampleClassGenerator(MapGenerator(DoubleGenerator(), BoolGenerator())),
        deleteStore);
    await testCacheWith<SembastStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(MapGenerator(DoubleGenerator(), BoolGenerator())),
        deleteStore);
  }, skip: 'Class<Map<double,bool>> is not supported by Sembast');

  test('Class<Map<double,int>>', () async {
    await testStoreWith<SembastStore>(
        newSampleObjectStore,
        SampleClassGenerator(MapGenerator(DoubleGenerator(), IntGenerator())),
        deleteStore);
    await testCacheWith<SembastStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(MapGenerator(DoubleGenerator(), IntGenerator())),
        deleteStore);
  }, skip: 'Class<Map<double,int>> is not supported by Sembast');

  test('Class<Map<double,double>>', () async {
    await testStoreWith<SembastStore>(
        newSampleObjectStore,
        SampleClassGenerator(
            MapGenerator(DoubleGenerator(), DoubleGenerator())),
        deleteStore);
    await testCacheWith<SembastStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(
            MapGenerator(DoubleGenerator(), DoubleGenerator())),
        deleteStore);
  }, skip: 'Class<Map<double,double>> is not supported by Sembast');

  test('Class<Map<double,String>>', () async {
    await testStoreWith<SembastStore>(
        newSampleObjectStore,
        SampleClassGenerator(
            MapGenerator(DoubleGenerator(), StringGenerator())),
        deleteStore);
    await testCacheWith<SembastStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(
            MapGenerator(DoubleGenerator(), StringGenerator())),
        deleteStore);
  }, skip: 'Class<Map<double,String>> is not supported by Sembast');

  test('Class<Map<String,bool>>', () async {
    await testStoreWith<SembastStore>(
        newSampleObjectStore,
        SampleClassGenerator(MapGenerator(StringGenerator(), BoolGenerator())),
        deleteStore);
    await testCacheWith<SembastStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(MapGenerator(StringGenerator(), BoolGenerator())),
        deleteStore);
  });

  test('Class<Map<String,int>>', () async {
    await testStoreWith<SembastStore>(
        newSampleObjectStore,
        SampleClassGenerator(MapGenerator(StringGenerator(), IntGenerator())),
        deleteStore);
    await testCacheWith<SembastStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(MapGenerator(StringGenerator(), IntGenerator())),
        deleteStore);
  });

  test('Class<Map<String,double>>', () async {
    await testStoreWith<SembastStore>(
        newSampleObjectStore,
        SampleClassGenerator(
            MapGenerator(StringGenerator(), DoubleGenerator())),
        deleteStore);
    await testCacheWith<SembastStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(
            MapGenerator(StringGenerator(), DoubleGenerator())),
        deleteStore);
  });

  test('Class<Map<String,String>>', () async {
    await testStoreWith<SembastStore>(
        newSampleObjectStore,
        SampleClassGenerator(
            MapGenerator(StringGenerator(), StringGenerator())),
        deleteStore);
    await testCacheWith<SembastStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(
            MapGenerator(StringGenerator(), StringGenerator())),
        deleteStore);
  });
}
