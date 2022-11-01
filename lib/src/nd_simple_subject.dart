//
//  nd_simple_subject.dart
//  nd_keys_observer
//
//  Created by Nguyen Duc Hiep on 01/12/2021.
//

import 'package:nd_keys_observer/src/nd_subject.dart';

extension NDSimpleSubject on NDSubject {
  static NDSubject create() => _NDSimpleSubject();
}

class _NDSimpleSubjectObserver {
  final NDKeys keys;
  final NDCallback callback;

  _NDSimpleSubjectObserver({required NDKeys keys, required this.callback})
      // ignore: unnecessary_this
      : this.keys = keys.toList(growable: false);
}

class _NDSimpleSubject extends NDSubject {
  final Map<_NDSimpleSubjectHandle, _NDSimpleSubjectObserver> _observers = {};

  @override
  void didChange(NDKeys keys, [void Function()? action]) {
    action?.call();

    _observers.forEach((handle, observer) {
      var builder = <NDKey>[];
      for (var key in observer.keys) {
        if (keys.any((element) => isRelative(element, key))) {
          builder.add(key);
        }
      }
      if (builder.isNotEmpty) {
        observer.callback(builder);
      }
    });
  }

  @override
  NDHandle observe(NDKeys keys, NDCallback callback) {
    _NDSimpleSubjectHandle handle = _NDSimpleSubjectHandle(this);
    _observers[handle] =
        _NDSimpleSubjectObserver(keys: keys, callback: callback);
    return handle;
  }

  @override
  void removeObserver(NDHandle handle) {
    if (handle is _NDSimpleSubjectHandle) {
      _disconnect(this, handle);
    }
  }

  @override
  void dispose() {
    for (var handle in _observers.keys) {
      handle._subject = null;
    }
    _observers.clear();
  }

  @override
  bool get isDisposed => _observers.isEmpty;
}

class _NDSimpleSubjectHandle extends NDHandle {
  _NDSimpleSubject? _subject;

  _NDSimpleSubjectHandle(_NDSimpleSubject subject) : _subject = subject;

  @override
  void dispose() {
    if (_subject != null) {
      _disconnect(_subject!, this);
    }
  }

  @override
  bool get isDisposed => _subject == null;
}

void _disconnect(_NDSimpleSubject subject, _NDSimpleSubjectHandle handle) {
  if (subject._observers.remove(handle) != null) {
    handle._subject = null;
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

class NDSubject {
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
