import 'package:flutter/material.dart';
import 'package:nd_core_utils/nd_core_utils.dart';
import 'package:nd_keys_observer/nd_keys_observer.dart';

class ObserverExamplesPage extends StatelessWidget {
  const ObserverExamplesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subject = NDSimpleSubject.create();
    final data = NDVariableWrapper('');
    void setData(String value) {
      final keys = value.split(',').map((e) => e.trim()).toList();
      subject.didChange(keys, () => data.value = value);
    }

    final controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('NDObserver Examples'),
      ),
      body: SafeArea(
        child: Padding(
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
              NDObserver(
                builder0: () {
                  return const Text(
                      'NDObserver without subject, keys, and dataContext.');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
