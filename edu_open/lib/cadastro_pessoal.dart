import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'cadastro_eduprof.dart';
import 'data_input.dart';
import 'package:http/http.dart' as http;

class SingUpPersonalPage extends StatefulWidget {
  @override
  _CadastroPessoalPageState createState() => _CadastroPessoalPageState();
}

class _CadastroPessoalPageState extends State<SingUpPersonalPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _cepController = TextEditingController();
  final _ufController = TextEditingController();
  final _bairroController = TextEditingController();
  final _numeroController = TextEditingController();

  Future<void> consultarCEP(String cep) async {
    var url = Uri.parse('https://viacep.com.br/ws/$cep/json/');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data != null && data['erro'] == null) {
          setState(() {
            _ufController.text = data['uf'] ?? '';
            _cidadeController.text = data['localidade'] ?? '';
            _bairroController.text = data['bairro'] ?? '';
            _enderecoController.text = data['logradouro'] ?? '';
          });
        } else {
          print('CEP não encontrado.');
          mostrarErroCEP();
        }
      } else {
        print('Erro na consulta do CEP. Status code: ${response.statusCode}');
        mostrarErroCEP();
      }
    } catch (e) {
      print('Erro na consulta do CEP: $e');
      mostrarErroCEP();
    }
  }

  void mostrarErroCEP() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro no CEP'),
          content: const Text('CEP inválido. Verifique o número digitado.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    setState(() {
      _ufController.text = '';
      _cidadeController.text = '';
      _bairroController.text = '';
      _enderecoController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      suffixText: '*',
                      suffixStyle: TextStyle(color: Colors.red),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _birthDateController,
                    keyboardType: TextInputType.datetime,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                      DateInputFormatter()
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Data de Nascimento',
                    ),
                  ),
                  TextFormField(
                    controller: _cepController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'CEP',
                      suffixText: '*',
                      suffixStyle: TextStyle(color: Colors.red),
                    ),
                    onChanged: (value) {
                      if (value.length == 8) {
                        consultarCEP(value);
                      }
                      if (value.length > 8) {
                        mostrarErroCEP();
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _enderecoController,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Endereço',
                      suffixText: '*',
                      suffixStyle: TextStyle(color: Colors.red),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _numeroController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Número',
                      suffixText: '*',
                      suffixStyle: TextStyle(color: Colors.red),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _bairroController,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Bairro',
                      suffixText: '*',
                      suffixStyle: TextStyle(color: Colors.red),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _cidadeController,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Cidade',
                      suffixText: '*',
                      suffixStyle: TextStyle(color: Colors.red),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _ufController,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'UF',
                      suffixText: '*',
                      suffixStyle: TextStyle(color: Colors.red),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SingUpProfessionalPage()),
                        );
                      }
                    },
                    child: const Text('Próximo'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
