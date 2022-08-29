import 'package:nd_core_utils/nd_core_utils.dart';
import 'package:nd_keys_observer/nd_subject.dart';

mixin NDBindable implements NDDisposable {
  // NDDisposable
  @override
  void dispose() => ndbindableDispose();

  @override
  bool get isDisposed => ndbindableIsDisposed();

  // NDBindable
  void bindWith<T>({
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

  // Unshadow methods
  void ndbindableDispose() {
    _handle.value = null;
  }

  bool ndbindableIsDisposed() {
    return _handle.value == null;
  }

  // Privates
  final NDAutoDisposable _handle = NDAutoDisposable(null);
}
