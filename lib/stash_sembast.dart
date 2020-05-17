/// Provides a Sembast implementation of the Stash caching API for Dart
library stash_sembast;

import 'package:stash/stash_api.dart';
import 'package:stash_sembast/src/sembast/sembast_store.dart';

export 'src/sembast/sembast_store.dart';

Cache newSembastCache(String path,
    {String cacheName,
    KeySampler sampler,
    EvictionPolicy evictionPolicy,
    int maxEntries,
    ExpiryPolicy expiryPolicy,
    CacheLoader cacheLoader,
    dynamic Function(dynamic) fromEncodable}) {
  return Cache.newCache(SembastStore(path, fromEncodable: fromEncodable),
      name: cacheName,
      expiryPolicy: expiryPolicy,
      sampler: sampler,
      evictionPolicy: evictionPolicy,
      maxEntries: maxEntries,
      cacheLoader: cacheLoader);
}
