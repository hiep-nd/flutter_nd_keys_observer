import 'package:key_observer/key_observer.dart';

void main(List<String> args) {
  var subject = SimpleSubject.create();
  subject.observe(["a", "b.c"], (keys) {
    print(keys);
    print("--------------");
  });

  print("didChange([\"a\", \"b\", \"c\"])");
  subject.didChange(["a", "b", "c"]);

  print("didChange([\"d\"])");
  subject.didChange(["d"]);
}
