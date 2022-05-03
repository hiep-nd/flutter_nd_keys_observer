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
    void Function()? builder0,
    void Function(
      NDKeys keys,
    )?
        builder1,
    void Function(
      NDKeys keys,
      T? dataContext,
    )?
        builder2,
    void Function(
      NDSubject subject,
      NDKeys keys,
      T? dataContext,
    )?
        builder3,
  }) {
    if (subject == null || keys == null) {
      _handle.value = null;
      return;
    }

    NDCallback? callback;
    if (builder0 != null) {
      callback = (_) => builder0();
    } else if (builder1 != null) {
      callback = builder1;
    } else if (builder2 != null) {
      callback = (keys) => builder2(keys, context);
    } else if (builder3 != null) {
      callback = (keys) => builder3(subject, keys, context);
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
