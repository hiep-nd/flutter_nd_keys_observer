//
//  nd_subject.dart
//  nd_keys_observer
//
//  Created by Nguyen Duc Hiep on 01/12/2021.
//

import 'package:flutter/foundation.dart';
import 'package:nd_core_utils/nd_core_utils.dart';

typedef NDKey = String;
typedef NDKeys = List<NDKey>;
typedef NDCallback = void Function(NDKeys keys);
typedef NDCheckRelative = bool Function(NDKey lKey, NDKey rKey);

extension NDCheckRelativeStandard on NDCheckRelative {
  static NDCheckRelative prefix({
    String separator = '.',
    bool trim = true,
  }) {
    return (NDKey lKey, NDKey rKey) {
      Iterable lIt = lKey.split(separator);
      final lLen = lIt.length;
      Iterable rIt = rKey.split(separator);
      final rLen = rIt.length;
      if (trim) {
        lIt = lIt.map((e) => e.trim());
        rIt = rIt.map((e) => e.trim());
      }
      return lLen >= rLen ? lIt.startsWith(rIt) : rIt.startsWith(lIt);
    };
  }

  static NDCheckRelative basic() {
    return (NDKey lKey, NDKey rKey) {
      return (lKey.length <= rKey.length)
          ? rKey.startsWith(lKey)
          : lKey.startsWith(rKey);
    };
  }
}

abstract class NDSubject implements NDDisposable {
  late final NDCheckRelative isRelative;

  NDSubject({NDCheckRelative? isRelative}) {
    this.isRelative = isRelative ?? NDCheckRelativeStandard.prefix();
  }

  NDHandle observe(NDKeys keys, NDCallback callback);

  void removeObserver(NDHandle handle);

  void didChange(NDKeys keys, [void Function()? action]);

  @mustCallSuper
  @override
  void dispose();
}

abstract class NDHandle implements NDDisposable {}

extension NDSubjectUtils on NDSubject {
  NDHandle bind(NDKeys keys, NDCallback callback) {
    final handle = observe(keys, callback);
    callback(keys);
    return handle;
  }
}
