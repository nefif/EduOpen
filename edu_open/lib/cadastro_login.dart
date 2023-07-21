import 'package:edu_open/login_page.dart';
import 'package:edu_open/terms_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'data_input.dart';
import 'database_helper.dart';

class SingUpPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<SingUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeUsuarioController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();
  bool _agreedToTerms = false;
  final _emailController = TextEditingController();
  String _propositoSelecionado = 'Educacional';
  bool _isEducational = true;
  final _nomeUniversidadeController = TextEditingController();
  String _instituicaoSelecionada = 'Selecione um item';
  String _titularidade = 'Selecione um item';
  final _cursoController = TextEditingController();
  final _nomeEmpresaControler = TextEditingController();
  final _ocupacaoEmpresaControler = TextEditingController();
  final _urlEmpresaControler = TextEditingController();
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
                  const Text('Dados Pessoais: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16.0),
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
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      suffixText: '*',
                      suffixStyle: TextStyle(color: Colors.red),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'E-mail inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32.0),
                  const Text(
                    'Motivo do Acesso:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Educacional',
                        groupValue: _propositoSelecionado,
                        onChanged: (value) {
                          setState(() {
                            _propositoSelecionado = value ?? 'Educacional';
                            _isEducational = true;
                          });
                        },
                      ),
                      const Text('Educacional'),
                      const SizedBox(width: 16.0),
                      Radio<String>(
                        value: 'Profissional',
                        groupValue: _propositoSelecionado,
                        onChanged: (value) {
                          setState(() {
                            _propositoSelecionado = value ?? 'Educacional';
                            _isEducational = false;
                          });
                        },
                      ),
                      const Text('Profissional'),
                    ],
                  ),
                  Visibility(
                    visible: _isEducational,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: _nomeUniversidadeController,
                              decoration: const InputDecoration(
                                  labelText: 'Nome da Istituição de Ensino',
                                  suffixText: '*',
                                  suffixStyle: TextStyle(color: Colors.red)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo obrigatório';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: _cursoController,
                              decoration: const InputDecoration(
                                  labelText:
                                      'Nome do curso ou programa de Pós-Graduação',
                                  suffixText: '*',
                                  suffixStyle: TextStyle(color: Colors.red)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo obrigatório';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            const Text('Tipo de Instituição:    '),
                            DropdownButton<String>(
                              value: _instituicaoSelecionada,
                              onChanged: (value) {
                                if (value == 'Selecione um item') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Selecione uma opção válida'),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    _instituicaoSelecionada =
                                        value ?? 'Pública';
                                  });
                                }
                              },
                              items: <String>[
                                'Selecione um item',
                                'Pública',
                                'Privada',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            const Text('Titularidade:   '),
                            DropdownButton<String>(
                              value: _titularidade,
                              onChanged: (value) {
                                if (value == 'Selecione um item') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Selecione uma opção válida'),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    _titularidade =
                                        value ?? 'Bacharel / Licenciatura';
                                  });
                                }
                              },
                              items: <String>[
                                'Selecione um item',
                                'Graduação',
                                'Especialização',
                                'Mestrado',
                                'Doutorado',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !_isEducational,
                    child: Column(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _nomeEmpresaControler,
                            decoration: const InputDecoration(
                              labelText: 'Nome da Empresa',
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
                            controller: _ocupacaoEmpresaControler,
                            decoration: const InputDecoration(
                              labelText: 'Cargo: ',
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
                            controller: _urlEmpresaControler,
                            decoration: const InputDecoration(
                                labelText: 'Site da Empresa'),
                            keyboardType: TextInputType.url,
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      )
                    ]),
                  ),
                  const SizedBox(height: 36.0),
                  const Text(
                    'Dados de Acesso:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _nomeUsuarioController,
                    decoration: const InputDecoration(
                      labelText: 'Nome do Usuário',
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
                    controller: _senhaController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
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
                    controller: _confirmarSenhaController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirmar Senha',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      if (value != _senhaController.text) {
                        return 'As senhas não correspondem';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Checkbox(
                        value: _agreedToTerms,
                        onChanged: (value) {
                          setState(() {
                            _agreedToTerms = value!;
                          });
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AgreedTerms()),
                          );
                        },
                        child: const Text(
                            'Eu li e concordo com os termos de uso.'),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate() && _agreedToTerms) {
                        Map<String, dynamic> usuario = {
                          'nome': _nomeUsuarioController.text,
                          'senha': _senhaController.text,
                          'email': _emailController.text,
                          'proposito': _propositoSelecionado,
                          'nomeUniversidade': _nomeUniversidadeController.text,
                          'curso': _cursoController.text,
                          'tipoInstituicao': _instituicaoSelecionada,
                          'titularidade': _titularidade,
                          'nomeEmpresa': _nomeEmpresaControler.text,
                          'ocupacaoEmpresa': _ocupacaoEmpresaControler.text,
                          'urlEmpresa': _urlEmpresaControler.text,
                          'nomeCompleto': _nomeController.text,
                          'dataNascimento': _birthDateController.text,
                          'cep': _cepController.text,
                          'endereco': _enderecoController.text,
                          'numero': _numeroController.text,
                          'bairro': _bairroController.text,
                          'cidade': _cidadeController.text,
                          'uf': _ufController.text,
                        };

                        DatabaseHelper databaseHelper = DatabaseHelper();
                        await databaseHelper.insertUsuario(usuario);

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      }
                    },
                    child: const Text('Cadastrar'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
