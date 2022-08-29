import 'package:flutter/material.dart';
import 'package:nd_keys_observer/nd_bindable.dart';
import 'package:nd_keys_observer/nd_subject.dart';

class NDValueNotifier<T> extends ValueNotifier<T> with NDBindable {
  // ValueNotifier
  @override
  void dispose() {
    ndbindableDispose();
    super.dispose();
  }

  // NDValueNotifier
  NDValueNotifier(value) : super(value);

  void bindWithTextGetter({
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
