import 'package:flutter/material.dart';
import 'package:nd_keys_observer/nd_bindable.dart';
import 'package:nd_keys_observer/nd_subject.dart';

class NDTabController extends TabController with NDBindable {
  // TabController
  @override
  void dispose() {
    ndbindableDispose();
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

  void bindWithGetter({
    NDSubject? subject,
    NDKeys? keys,
    required int Function() getter,
  }) {
    bindWith(
      subject: subject,
      keys: keys,
      binder0: () {
        index = getter();
      },
    );
  }
}
