# stash_sembast
A [stash](https://github.com/ivoleitao/stash) storage extension for [sembast](https://pub.dev/packages/sembast)

[![Pub Package](https://img.shields.io/pub/v/stash_sembast.svg?style=flat-square)](https://pub.dartlang.org/packages/stash_sembast)
[![Build Status](https://github.com/ivoleitao/shadertoy_api/workflows/build/badge.svg)](https://github.com/ivoleitao/stash_sembast/actions)
[![Coverage Status](https://codecov.io/gh/ivoleitao/stash_sembast/graph/badge.svg)](https://codecov.io/gh/ivoleitao/stash_sembast)
[![Package Documentation](https://img.shields.io/badge/doc-stash_sembast-blue.svg)](https://www.dartdocs.org/documentation/stash_sembast/latest)
[![GitHub License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Introduction

This storage extension for [stash](https://pub.dartlang.org/packages/stash) provides a 
[sembast](https://pub.dev/packages/sembast) based storage that relies on a highly performing binary serialization of the cache items through the use of [msgpack](https://msgpack.org) serialization format.

## Getting Started

Add this to your `pubspec.yaml` (or create it):

```dart
dependencies:
    stash_sembast: ^1.0.1
```

Run the following command to install dependencies:

```dart
pub install
```

Optionally use the following command to run the tests:

```dart
pub run test
```

Finally, to start developing import the library:

```dart
import 'package:stash_sembast/stash_sembast.dart';
```

## Usage

This storage extension for [stash](https://pub.dartlang.org/packages/stash) provides a 
[hive](https://pub.dev/packages/sembast) based storage that relies on a highly performing binary serialization of the cache items through the use of [msgpack](https://msgpack.org) serialization format.


```dart
import 'dart:io';

import 'package:stash_sembast/stash_sembast.dart';

class Task {
  final int id;
  final String title;
  final bool completed;

  Task({this.id, this.title, this.completed = false});

  /// Creates a [Task] from json map
  factory Task.fromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as int,
      title: json['title'] as String,
      completed: json['completed'] as bool);

  /// Creates a json map from a [Task]
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'id': id, 'title': title, 'completed': completed};

  @override
  String toString() {
    return 'Task ${id}: "${title}" is ${completed ? "completed" : "not completed"}';
  }
}

void main() async {
  // Temporary path
  final path = Directory.systemTemp.path;

  // Creates cache with a Sembast based storage backend with the capacity of 10 entries
  final cache = newSembastCache(path,
      maxEntries: 10, fromEncodable: (json) => Task.fromJson(json));

  // Adds a task with key 'task1' to the cache
  await cache.put('task1',
      Task(id: 1, title: 'Run stash_sembast example', completed: true));
  // Retrieves the value from the cache
  final value = await cache.get('task1');

  print(value);
}
```

## Contributing

This library is developed by best effort, in the motto of "Scratch your own itch!", meaning APIs that are meaningful for the author use cases.

If you would like to contribute with other parts of the API, feel free to make a [Github pull request](https://github.com/ivoleitao/stash_sembast/pulls) as I'm always looking for contributions for:
* Tests
* Documentation
* New APIs

## Features and Bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/ivoleitao/stash_sembast/issues/new

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details