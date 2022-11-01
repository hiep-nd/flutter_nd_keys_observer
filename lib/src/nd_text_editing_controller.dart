//
//  nd_text_editing_controller.dart
//  nd_keys_observer
//
//  Created by Nguyen Duc Hiep on 01/12/2021.
//

import 'package:flutter/widgets.dart';
import 'package:nd_keys_observer/src/nd_bindable.dart';
import 'package:nd_keys_observer/src/nd_subject.dart';

class NDTextEditingController extends TextEditingController with NDBindable {
  // TextEditingController
  @override
  void dispose() {
    ndBindableDispose();
    super.dispose();
  }

  // NDTextEditingController
  NDTextEditingController({String? text}) : super(text: text);

  void bindWithTextGetter({
    NDSubject? subject,
    NDKeys? keys,
    required String Function() textGetter,
  }) {
    bindWith(
      subject: subject,
      keys: keys,
      binder0: () {
        final value = textGetter();
        if (text != value) {
          text = value;
        }
      },
    );
  }
}
