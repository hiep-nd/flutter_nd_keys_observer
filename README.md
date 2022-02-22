# nd_keys_observer
nd_keys_observer is a small library to observe by key path with callback.
```dart
NDSubject subject = NDSimpleSubject.create();
subject.observe(["myProperty", "myProperty2.myProperty"], (keys) {
	print(keys);
});
//...
subject.didChange(["myProperty.a.b"]);
// [myProperty]

//...
subject.didChange(["myProperty.a, myProperty2"]);
// [myProperty, myProperty2.myProperty]
```
