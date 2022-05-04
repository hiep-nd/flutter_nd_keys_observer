//
//  switch_examples_page.dart
//  nd_keys_observer
//
//  Created by Nguyen Duc Hiep on 01/12/2021.
//

import 'package:flutter/material.dart';
import 'package:nd_keys_observer/nd_keys_observer.dart';

class CommonUiExamplesPage extends StatefulWidget {
  const CommonUiExamplesPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CommonUiExamplesPageState();
}

class _CommonUiExamplesPageState extends State<CommonUiExamplesPage> {
  final _subject = NDSimpleSubject.create();
  bool _switchValue = true;
  String _textValue = 'abc';

  final _textController = NDTextEditingController();

  @override
  void initState() {
    _textController.bindWith(
      subject: _subject,
      keys: ['textValue'],
      binder0: () {
        if (_textController.text != _textValue) {
          _textController.text = _textValue;
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Common UI Examples'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              NDObserver(
                subject: _subject,
                keys: const ['switchValue'],
                builder0: () => Switch(
                  value: _switchValue,
                  onChanged: (val) => _subject.didChange(
                    ['switchValue'],
                    () {
                      _switchValue = val;
                    },
                  ),
                ),
              ),
              TextField(
                controller: _textController,
                onChanged: (value) {
                  _subject.didChange(['textValue'], () {
                    _textValue = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
