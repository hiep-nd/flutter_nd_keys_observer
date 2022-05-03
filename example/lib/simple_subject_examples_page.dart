//
//  simple_subject_examples_page.dart
//  nd_keys_observer
//
//  Created by Nguyen Duc Hiep on 01/12/2021.
//

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:nd_keys_observer/nd_keys_observer.dart';

class SimpleSubjectExamplesPage extends StatelessWidget {
  const SimpleSubjectExamplesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logs = <String>[];

    return Scaffold(
      appBar: AppBar(
        title: const Text('NDSimpleSubject Examples'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: StatefulBuilder(
            builder: (context, setState) {
              void log(String value) {
                setState(() {
                  logs.add(value);
                });
              }

              return Column(
                children: [
                  Center(
                    child: TextButton(
                      onPressed: () {
                        log('NDSimpleSubject');

                        var subject = NDSimpleSubject.create();
                        subject.observe(["a", "b.c"], (keys) {
                          log(keys.toString());
                          log("--------------");
                        });

                        log("didChange([\"a\", \"b\", \"c\"])");
                        subject.didChange(["a", "b", "c"], () {});

                        log("didChange([\"d\"])");
                        subject.didChange(["d"], () {});
                        log("--------------");
                      },
                      child: const Text('Simple Subject'),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: logs.length,
                      itemBuilder: (context, index) => Text(logs[index]),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
