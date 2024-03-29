import 'package:flutter/material.dart';
import 'package:nd_keys_observer/src/nd_bindable.dart';
import 'package:nd_keys_observer/src/nd_subject.dart';

class NDValueNotifier<T> extends ValueNotifier<T> with NDBindable {
  // ValueNotifier
  @override
  void dispose() {
    ndBindableDispose();
    super.dispose();
  }

  // NDValueNotifier
  NDValueNotifier(value) : super(value);

  void bindWithValueGetter({
    NDSubject? subject,
    NDKeys? keys,
    required T Function() valueGetter,
  }) {
    bindWith(
      subject: subject,
      keys: keys,
      binder0: () {
        value = valueGetter();
      },
    );
  }
}
