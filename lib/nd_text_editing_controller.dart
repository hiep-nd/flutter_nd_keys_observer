//
//  nd_text_editing_controller.dart
//  nd_keys_observer
//
//  Created by Nguyen Duc Hiep on 01/12/2021.
//

import 'package:flutter/widgets.dart';
import 'package:nd_core_utils/nd_core_utils.dart';
import 'package:nd_keys_observer/nd_keys_observer.dart';

class NDTextEditingController<T> extends TextEditingController {
  @override
  void dispose() {
    super.dispose();
    _handle.value = null;
  }

  void bindWith({
    NDSubject? subject,
    NDKeys? keys,
    T? context,
    void Function()? binder0,
    void Function(
      NDKeys keys,
    )?
        binder1,
    void Function(
      NDKeys keys,
      T? dataContext,
    )?
        binder2,
    void Function(
      NDSubject subject,
      NDKeys keys,
      T? dataContext,
    )?
        binder3,
  }) {
    if (subject == null || keys == null) {
      _handle.value = null;
      return;
    }

    NDCallback? callback;
    if (binder0 != null) {
      callback = (_) => binder0();
    } else if (binder1 != null) {
      callback = binder1;
    } else if (binder2 != null) {
      callback = (keys) => binder2(keys, context);
    } else if (binder3 != null) {
      callback = (keys) => binder3(subject, keys, context);
    }

    if (callback == null) {
      _handle.value = null;
      return;
    }

    _handle.value = subject.bind(keys, callback);
  }

  // Privates
  final NDAutoDisposable _handle = NDAutoDisposable(null);
}
