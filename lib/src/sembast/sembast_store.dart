import 'package:path/path.dart' as p;
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:stash/stash_api.dart';
import 'package:stash_sembast/src/sembast/sembast_extensions.dart';

import 'dao/cache_dao.dart';

class SembastStore extends CacheStore {
  final dynamic Function(Map<String, dynamic>) _fromEncodable;

  final String path;

  Database _db;
  final Map<String, StoreRef<String, Map<String, dynamic>>> _cacheStoreMap = {};

  SembastStore(this.path,
      {dynamic Function(Map<String, dynamic>) fromEncodable})
      : _fromEncodable = fromEncodable;

  Future<CacheDao> _cacheStore(String name) {
    Future<Database> getDB;
    if (_db == null) {
      getDB = databaseFactoryIo.openDatabase(p.join(path, name)).then((d) {
        _db = d;

        return d;
      });
    } else {
      getDB = Future.value(_db);
    }

    return getDB.then((db) {
      if (_cacheStoreMap.containsKey(name)) {
        return CacheDao(db, _cacheStoreMap[name]);
      }

      _cacheStoreMap[name] = StoreRef<String, Map<String, dynamic>>(name);

      return CacheDao(db, _cacheStoreMap[name]);
    });
  }

  @override
  Future<int> size(String name) => _cacheStore(name).then((ctx) => ctx.count());

  @override
  Future<Iterable<String>> keys(String name) =>
      _cacheStore(name).then((ctx) => ctx.findKeys());

  CacheEntry _getEntryFromValue(Map<String, dynamic> value) {
    return value != null
        ? SembastExtensions.fromJson(value, fromJson: _fromEncodable)
        : null;
  }

  CacheStat _getStatFromValue(Map<String, dynamic> value) {
    return _getEntryFromValue(value).stat;
  }

  Future<CacheEntry> _getEntryFromStore(CacheDao ctx, String key) =>
      ctx.getByKey(key).then(_getEntryFromValue);

  Future<CacheEntry> _getEntry(String name, String key) {
    return _cacheStore(name).then((ctx) => _getEntryFromStore(ctx, key));
  }

  Future<List<RecordSnapshot<String, Map<String, dynamic>>>> _getRecords(
      String name) {
    return _cacheStore(name).then((ctx) => ctx.find());
  }

  @override
  Future<Iterable<CacheStat>> stats(String name) =>
      _getRecords(name).then((records) =>
          records.map((record) => _getStatFromValue(record.value)).toList());

  @override
  Future<Iterable<CacheEntry>> values(String name) =>
      _getRecords(name).then((records) =>
          records.map((record) => _getEntryFromValue(record.value)).toList());

  @override
  Future<bool> containsKey(String name, String key) =>
      _cacheStore(name).then((ctx) => ctx.exists(key));

  @override
  Future<CacheStat> getStat(String name, String key) {
    return _getEntry(name, key).then((entry) => entry.stat);
  }

  @override
  Future<Iterable<CacheStat>> getStats(String name, Iterable<String> keys) {
    return _cacheStore(name).then((ctx) => ctx.getByKeys(keys)).then(
        (records) =>
            records.map((record) => _getEntryFromValue(record)).toList());
  }

  @override
  Future<void> setStat(String name, String key, CacheStat stat) {
    return _cacheStore(name).then((ctx) {
      return _getEntryFromStore(ctx, key)
          .then((entry) => ctx.put(key, (entry..stat = stat).toSembastJson()));
    });
  }

  @override
  Future<CacheEntry> getEntry(String name, String key) {
    return _getEntry(name, key);
  }

  @override
  Future<void> putEntry(String name, String key, CacheEntry entry) {
    return _cacheStore(name).then((ctx) => ctx.put(key, entry.toSembastJson()));
  }

  @override
  Future<void> remove(String name, String key) {
    return _cacheStore(name).then((ctx) => ctx.remove(key));
  }

  @override
  Future<void> clear(String name) {
    return _cacheStore(name).then((ctx) => ctx.clear());
  }

  @override
  Future<void> delete(String name) {
    if (_cacheStoreMap.containsKey(name)) {
      return _cacheStore(name).then((ctx) {
        return ctx.clear().then((_) => _cacheStoreMap.remove(name));
      });
    }

    return Future.value();
  }

  @override
  Future<void> deleteAll() {
    return Future.wait(_cacheStoreMap.keys.map((name) {
      return _cacheStore(name).then((ctx) {
        return ctx.deleteDatabase().then((_) => _cacheStoreMap.remove(name));
      });
    }));
  }
}
