//
// nd_observer.dart
// nd_keys_observer
//
// Created by Nguyen Duc Hiep on Mon Feb 07 2022.
// Copyright © 2022 Nguyen Duc Hiep. All rights reserved.
//

import 'package:flutter/widgets.dart';
import 'package:nd_core_utils/nd_core_utils.dart';
import 'package:nd_keys_observer/nd_subject.dart';

class NDObserver<T> extends StatefulWidget {
  final NDSubject? subject;
  final NDKeys? keys;
  final T? dataContext;
  late final Widget Function(
    BuildContext buildContext,
    NDSubject subject,
    NDKeys keys,
    T? dataContext,
  ) _builder;

  NDObserver({
    Key? key,
    this.subject,
    this.keys,
    this.dataContext,
    Widget Function()? builder0,
    Widget Function(BuildContext buildContext)? builder1,
    Widget Function(
      BuildContext buildContext,
      NDKeys keys,
    )?
        builder2,
    Widget Function(
      BuildContext buildContext,
      NDKeys keys,
      T? dataContext,
    )?
        builder3,
    Widget Function(
      BuildContext buildContext,
      NDSubject subject,
      NDKeys keys,
      T? dataContext,
    )?
        builder4,
  }) : super(key: key) {
    if (builder0 != null) {
      _builder = (buildContext, subject, keys, dataContext) => builder0();
      return;
    }
    if (builder1 != null) {
      _builder =
          (buildContext, subject, keys, dataContext) => builder1(buildContext);
      return;
    }
    if (builder2 != null) {
      _builder = (buildContext, subject, keys, dataContext) =>
          builder2(buildContext, keys);
      return;
    }
    if (builder3 != null) {
      _builder = (buildContext, subject, keys, dataContext) =>
          builder3(buildContext, keys, dataContext);
      return;
    }
    if (builder4 != null) {
      _builder = builder4;
      return;
    }
    _builder =
        (buildContext, subject, keys, dataContext) => const SizedBox.shrink();
  }

  @override
  State<NDObserver<T>> createState() => _NDState<T>();
}

class _NDState<T> extends State<NDObserver<T>> {
  // State
  @override
  void initState() {
    _observe();
    super.initState();
  }

  @override
  void didUpdateWidget(NDObserver<T> oldWidget) {
    _observe();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _handle.value = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final result =
        widget._builder(context, _subject!, _keys, widget.dataContext);
    _keys.clear();
    return result;
  }

  // Privates
  final NDAutoDisposable _handle = NDAutoDisposable(null);
  final _keys = <NDKey>[];
  NDSubject? _subject;

  void _observe() {
    _subject = widget.subject;
    final keys = widget.keys;
    if (_subject == null || keys == null) {
      _handle.value = null;
      return;
    }

    _handle.value = _subject!.observe(keys, (keys) {
      setState(() {
        for (var key in keys) {
          if (!_keys.contains(key)) {
            _keys.add(key);
          }
        }
      });
    });
  }
}
