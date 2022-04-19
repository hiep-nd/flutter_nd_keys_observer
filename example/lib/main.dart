//
//  main.dart
//  nd_keys_observer
//
//  Created by Nguyen Duc Hiep on 01/12/2021.
//

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:nd_core_utils/nd_core_utils.dart';
import 'package:nd_keys_observer/nd_keys_observer.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('NDKeyObserver Examples'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Center(
                child: TextButton(
                  onPressed: () {
                    print('NDSimpleSubject');

                    var subject = NDSimpleSubject.create();
                    subject.observe(["a", "b.c"], (keys) {
                      print(keys);
                      print("--------------");
                    });

                    print("didChange([\"a\", \"b\", \"c\"])");
                    subject.didChange(["a", "b", "c"], () {});

                    print("didChange([\"d\"])");
                    subject.didChange(["d"], () {});
                  },
                  child: const Text('Simple Subject'),
                ),
              ),
              // NDObserver
              Builder(builder: (context) {
                final subject = NDSimpleSubject.create();
                final data = NDVariableWrapper('');
                void setData(String value) {
                  final keys = value.split(',').map((e) => e.trim()).toList();
                  subject.didChange(keys, () => data.value = value);
                }

                final controller = TextEditingController();
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      TextField(
                        controller: controller,
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                        onPressed: () {
                          setData(controller.value.text);
                        },
                        child: const Text('Update'),
                      ),
                      NDObserver<NDVariableWrapper<String>>(
                        subject: subject,
                        keys: const ['a', 'c'],
                        dataContext: data,
                        builder3: (_, keys, ctx) {
                          return Text('$keys: \'${ctx?.value}\'');
                        },
                      ),
                    ],
                  ),
                );
              })
            ],
          ),
        ),
      ),
    ),
  );
}
