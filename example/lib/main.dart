//
//  main.dart
//  nd_keys_observer
//
//  Created by Nguyen Duc Hiep on 01/12/2021.
//

// ignore_for_file: avoid_print

import 'package:example/animation_examples_page.dart';
import 'package:example/common_ui_examples_page.dart';
import 'package:example/observer_examples_page.dart';
import 'package:example/simple_subject_examples_page.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  Widget menuItem(String title, Widget Function(BuildContext) pageBuilder) {
    return Builder(
        builder: (context) => Center(
              child: TextButton(
                  child: Text(title),
                  onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: pageBuilder))),
            ));
  }

  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('NDKeyObserver Examples'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              menuItem(
                'NDSimpleSubject Examples',
                (_) => const SimpleSubjectExamplesPage(),
              ),
              menuItem(
                'NDObserver Examples',
                (_) => const ObserverExamplesPage(),
              ),
              menuItem(
                'Common UI Examples',
                (_) => const CommonUiExamplesPage(),
              ),
              menuItem(
                'Animation Examples',
                (_) => const AnimationExamplesPage(),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
