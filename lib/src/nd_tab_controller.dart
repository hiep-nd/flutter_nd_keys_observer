import 'package:flutter/material.dart';
import 'package:nd_keys_observer/src/nd_bindable.dart';
import 'package:nd_keys_observer/src/nd_subject.dart';

class NDTabController extends TabController with NDBindable {
  // TabController
  @override
  void dispose() {
    ndBindableDispose();
    super.dispose();
  }

  // NDBindableController
  NDTabController({
    int initialIndex = 0,
    Duration? animationDuration,
    required int length,
    required TickerProvider vsync,
  }) : super(
          initialIndex: initialIndex,
          animationDuration: animationDuration,
          length: length,
          vsync: vsync,
        );

  void bindWithIndexGetter({
    NDSubject? subject,
    NDKeys? keys,
    required int Function() indexGetter,
  }) {
    bindWith(
      subject: subject,
      keys: keys,
      binder0: () {
        index = indexGetter();
      },
    );
  }
}
