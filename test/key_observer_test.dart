import 'package:flutter_test/flutter_test.dart';
import 'package:key_observer/key_observer.dart';

void main() {
  void testSubject(Subject subject) {
    var changes = <String>[];
    var handle = subject.observe(["a", "b", "c.d"], (keys) {
      changes = keys;
    });

    subject.didChange(['b', 'a']);
    expect(changes, ['a', 'b']);
    changes.clear();

    subject.didChange(['c', 'd']);
    expect(changes, ['c.d']);
    changes.clear();

    subject.didChange(['e']);
    expect(changes, []);
    changes.clear();

    subject.removeObserver(handle);
  }

  test('Test SimpleSubject', () {
    final subject = SimpleSubject.create();
    testSubject(subject);
  });
}
