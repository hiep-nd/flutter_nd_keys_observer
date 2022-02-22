//
//  nd_keys_observer_test.dart
//  nd_keys_observer
//
//  Created by Nguyen Duc Hiep on 01/12/2021.
//

import 'package:flutter_test/flutter_test.dart';
import 'package:nd_keys_observer/nd_keys_observer.dart';

void main() {
  void testNDSubject(NDSubject subject) {
    var changes = <String>[];
    var handle = subject.observe(["a", "b", "c.d"], (keys) {
      changes = keys;
    });

    subject.didChange(['b', 'a'], () {});
    expect(changes, ['a', 'b']);
    changes.clear();

    subject.didChange(['c', 'd'], () {});
    expect(changes, ['c.d']);
    changes.clear();

    subject.didChange(['e'], () {});
    expect(changes, []);
    changes.clear();

    subject.removeObserver(handle);
  }

  test('Test NDSimpleSubject', () {
    final subject = NDSimpleSubject.create();
    testNDSubject(subject);
  });
}
