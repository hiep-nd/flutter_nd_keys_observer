//
//  subject.dart
//  key_observer
//
//  Created by Nguyen Duc Hiep on 01/12/2021.
//

import 'package:flutter/foundation.dart';

typedef Key = String;
typedef Keys = List<Key>;
typedef Handle = int;
typedef Callback = void Function(Keys keys);
typedef CheckRelative = bool Function(Key lKey, Key rKey);

abstract class Subject {
  late final CheckRelative isRelative;

  Subject({CheckRelative? isRelative}) {
    this.isRelative = isRelative ??
        (lKey, rKey) {
          final lLength = lKey.length;
          final rLength = rKey.length;
          return (lLength < rLength)
              ? rKey.startsWith(lKey)
              : (rLength < lLength)
                  ? lKey.startsWith(rKey)
                  : lKey == rKey;
        };
  }

  Handle observe(Keys keys, Callback callback);

  void removeObserver(Handle handle);

  void didChange(Keys keys);

  @mustCallSuper
  void dispose();
}
