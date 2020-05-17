import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class CacheDao {
  final Database _client;
  final StoreRef<String, Map<String, dynamic>> _store;

  CacheDao(
    this._client,
    this._store,
  );

  Future<bool> exists(String key) {
    return _store.record(key).exists(_client);
  }

  Future<int> count({Filter filter}) {
    return _store.count(_client, filter: filter);
  }

  Future<List<String>> findKeys({Finder finder}) {
    return _store.findKeys(_client, finder: finder);
  }

  Future<Map<String, dynamic>> getByKey(String key) {
    return _store.record(key).get(_client);
  }

  Future<List<Map<String, dynamic>>> getByKeys(Iterable<String> keys) {
    return _store.records(keys).get(_client);
  }

  Future<List<RecordSnapshot<String, Map<String, dynamic>>>> find(
      {Finder finder}) {
    return _store.find(_client, finder: finder);
  }

  Future<Map<String, dynamic>> put(String key, Map<String, dynamic> value,
      {bool merge}) {
    return _store.record(key).put(_client, value, merge: merge);
  }

  Future<dynamic> remove(String key) {
    return _store.record(key).delete(_client);
  }

  Future<int> clear() {
    return _store.delete(_client);
  }

  Future<void> deleteDatabase() {
    return _client
        .close()
        .then((_) => databaseFactoryIo.deleteDatabase(_client.path));
  }
}
