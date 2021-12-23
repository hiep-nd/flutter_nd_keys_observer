# key_observer
key_observer is a small library to observe by key path with callback.
```dart
Subject subject = SimpleSubject.create();
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
