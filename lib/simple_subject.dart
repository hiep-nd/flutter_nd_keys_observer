import 'dart:math';

import 'package:key_observer/subject.dart';

extension SimpleSubject on Subject {
  static Subject create() => _SimpleSubject();
}

class _SimpleSubjectObserver {
  final Keys keys;
  final Callback callback;

  _SimpleSubjectObserver({required this.keys, required this.callback});
}

class _SimpleSubject extends Subject {
  final Map<Handle, _SimpleSubjectObserver> _observers = {};

  @override
  void didChange(Keys keys) {
    _observers.forEach((handle, observer) {
      Keys observedKeys = Keys.empty(growable: true);
      for (var key in observer.keys) {
        if (keys.any((element) => isRelative(element, key))) {
          observedKeys.add(key);
        }
      }
      if (observedKeys.isNotEmpty) {
        observer.callback(observedKeys);
      }
    });
  }

  @override
  Handle observe(Keys keys, Callback callback) {
    Handle handle = _observers.isEmpty ? 0 : _observers.keys.reduce(max) + 1;
    _observers[handle] = _SimpleSubjectObserver(keys: keys, callback: callback);
    return handle;
  }

  @override
  void removeObserver(Handle handle) {
    _observers.remove(handle);
  }

  @override
  void dispose() {
    _observers.clear();
  }
}

/*

// class Observer {
//   int key;
//   final String path;
//   Function callback;
// }


class _Handler {
  final _Callback callback;
  _Node node;
}

typedef _Nodes = List<_Node>;

class _Node {
  final _Node? parent;
  final _Nodes children = [];

  _Node({this.parent, required this.name}) {
    parent?.children.add(this);
    key = _findKey();
  }

  final String name;

  late final String key;

  String _findKey() {
    var builder = name;
    var node = this;
    while (node.parent != null) {
      node = node.parent!;
      builder = node.name + "." + builder;
    }
    return builder;
  }
}

class Subject {
  int observe(List<String> keys, void Function(List<String> keys) callback) {
    return 0;
  }

  void removeObserver(int handle) {}

  void didChange(List<String> keys) {
    var nodes = _findNodes(keys);
    var callbacks = _findCallbacks(nodes);
    for (Callback callback in callbacks) {
      callback(keys);
    }
  }

  void _didChangeNodes(_Nodes nodes) {}

  // final Map<int, Function> _observers = {};

  // int observe(List<String> paths, Function callback) {
  //   int key = _observers.isEmpty ? 0 : _observers.keys.reduce(max) + 1;
  //   _observers[key] = observer;
  //   return key;
  // }

  // void remoteHandler(int key) {
  //   _observers.remove(key);
  // }

  // void didUpdate(List<String> paths) {

  // }
}
*/
