import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double dolar = 0.0;
  double euro = 0.0;

  Future<Map<String, dynamic>> getData() async {
    final requestUri = Uri.https("api.hgbrasil.com", '/finance',
        {'format': 'json-cors', 'key': '3872ee8e'});

    http.Response response = await http.get(requestUri);
    final json = jsonDecode(response.body);
    return json;
  }

  TextEditingController brlController = TextEditingController();
  TextEditingController usdController = TextEditingController();
  TextEditingController eurController = TextEditingController();

  void _realChange(String text) {
    if (text.isNotEmpty) {
      double real = double.parse(text);
      usdController.text = (real / dolar).toStringAsFixed(2);
      eurController.text = (real / euro).toStringAsFixed(2);
    } else {
      usdController.text = '0';
      eurController.text = '0';
    }
  }

  void _dolarChange(String text) {
    if (text.isNotEmpty) {
      double dolar = double.parse(text);
      brlController.text = (dolar * this.dolar).toStringAsFixed(2);
      eurController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
    } else {
      brlController.text = '0';
      eurController.text = '0';
    }
  }

  void _euroChange(String text) {
    if (text.isNotEmpty) {
      double euro = double.parse(text);
      brlController.text = (euro * this.euro).toStringAsFixed(2);
      usdController.text = (euro * this.euro / dolar).toStringAsFixed(2);
    } else {
      brlController.text = '0';
      usdController.text = '0';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          " Conversor ",
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            FutureBuilder<Map<String, dynamic>>(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  dolar = snapshot.data!['results']['currencies']['USD']['buy'];
                  euro = snapshot.data!['results']['currencies']['EUR']['buy'];
                } else if (snapshot.hasError) {
                  return const Text('Tem erro');
                } else {
                  return const Center(
                    child: Text('Carregando ...',
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 30,
                        ),
                        textAlign: TextAlign.center),
                  );
                }
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 360,
                    child: Column(
                      children: <Widget>[
                        const Icon(
                          Icons.monetization_on,
                          color: Colors.amber,
                          size: 120,
                        ),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          controller: brlController,
                          onChanged: _realChange,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Real BRL',
                            labelStyle:
                                TextStyle(fontSize: 20, color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.amberAccent, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amber, width: 2.0),
                            ),
                            prefixText: 'R\$ : ',
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          onChanged: _dolarChange,
                          keyboardType: TextInputType.number,
                          controller: usdController,
                          decoration: const InputDecoration(
                            labelText: 'Dolar USD',
                            labelStyle:
                                TextStyle(fontSize: 20, color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.amberAccent, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amber, width: 2.0),
                            ),
                            prefixText: 'USD :',
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          onChanged: _euroChange,
                          keyboardType: TextInputType.number,
                          controller: eurController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'Euro EUR',
                            labelStyle:
                                TextStyle(fontSize: 20, color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.amberAccent, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amber, width: 2.0),
                            ),
                            prefixText: 'ЄUR : ',
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
