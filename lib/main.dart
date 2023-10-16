import 'package:flutter/material.dart';

import 'model/person.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculadora IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Person> history = List.empty(growable: true);
  var nameTextController = TextEditingController(text: '');
  var heightTextController = TextEditingController(text: '');
  var weightTextController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
            child: SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            height: 50,
                            alignment: Alignment.center,
                            child: Row(children: [
                              const SizedBox(
                                width: 60,
                                child: Text('Nome: '),
                              ),
                              Flexible(
                                child: TextField(
                                    decoration: const InputDecoration(
                                        hintText: 'Insira seu nome',
                                        hintStyle:
                                            TextStyle(color: Colors.grey)),
                                    keyboardType: TextInputType.name,
                                    controller: nameTextController),
                              )
                            ]),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            height: 50,
                            alignment: Alignment.center,
                            child: Row(children: [
                              const SizedBox(
                                width: 60,
                                child: Text('Altura: '),
                              ),
                              Flexible(
                                child: TextField(
                                    decoration: const InputDecoration(
                                        hintText: 'Insira sua altura',
                                        hintStyle:
                                            TextStyle(color: Colors.grey)),
                                    keyboardType: TextInputType.number,
                                    controller: heightTextController),
                              )
                            ]),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            height: 50,
                            alignment: Alignment.center,
                            child: Row(children: [
                              const SizedBox(
                                width: 60,
                                child: Text('Peso: '),
                              ),
                              Flexible(
                                child: TextField(
                                    decoration: const InputDecoration(
                                        labelStyle: TextStyle(fontSize: 8),
                                        hintText: 'Insira seu peso',
                                        hintStyle:
                                            TextStyle(color: Colors.grey)),
                                    keyboardType: TextInputType.number,
                                    controller: weightTextController),
                              )
                            ]),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                String name = nameTextController.text;
                                double height =
                                    double.parse(heightTextController.text);
                                double weight =
                                    double.parse(weightTextController.text);

                                if (name.isNotEmpty &&
                                    height > 0 &&
                                    weight > 0) {
                                  Person person = Person(
                                      name: name,
                                      weight: weight,
                                      height: height);
                                  debugPrint(person.toString());
                                  setState(() {
                                    history.add(person);
                                    nameTextController.text = '';
                                    heightTextController.text = '';
                                    weightTextController.text = '';
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  });
                                }
                              },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 141, 79, 151))),
                              child: const Text(
                                "Calcular IMC",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              )),
                          const SizedBox(height: 10),
                          const Divider(
                            thickness: 1.0,
                          ),
                          Expanded(
                              child: Scrollbar(
                                  child: ListView.builder(
                                      itemCount: history.length,
                                      itemBuilder:
                                          (BuildContext bc, int index) {
                                        var person = history[index];
                                        return Column(children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text('Nome: ${person.name}'),
                                                Text(
                                                    'Situação: ${person.getImcMessage()}'),
                                              ]),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                    'Altura: ${person.getHeight()}'),
                                                Text(
                                                    'Peso: ${person.getWeight()}'),
                                                Text(
                                                    'IMC: ${person.getImcString()}'),
                                              ]),
                                          const Divider(
                                            thickness: 3.0,
                                          )
                                        ]);
                                      })))
                        ]))
                //This trailing comma makes auto-formatting nicer for build methods.
                )));
  }
}
