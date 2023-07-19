import 'package:flutter/material.dart';

import 'cadastro_login.dart';
import 'database_helper.dart';

class SingUpProfessionalPage extends StatefulWidget {
  @override
  _CadastroProfissionalPageState createState() =>
      _CadastroProfissionalPageState();
}

class _CadastroProfissionalPageState extends State<SingUpProfessionalPage> {
  final _formKey = GlobalKey<FormState>();
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
                  const Text('Motivo do Acesso:'),
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
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> data = {
                          'email': _emailController.text,
                          'proposito': _propositoSelecionado,
                          'nomeUniversidade': _nomeUniversidadeController.text,
                          'curso': _cursoController.text,
                          'tipoInstituicao': _instituicaoSelecionada,
                          'titularidade': _titularidade,
                          'nomeEmpresa': _nomeEmpresaControler.text,
                          'ocupacaoEmpresa': _ocupacaoEmpresaControler.text,
                          'urlEmpresa': _urlEmpresaControler.text,
                        };

                        DatabaseHelper databaseHelper = DatabaseHelper();
                        await databaseHelper.insertUsuario(data);

                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SingUpPage()),
                        );
                      }
                    },
                    child: const Text('Próximo'),
                  ),
                  // Todo: Enviar os dados do formulário para o backend
                ],
              ),
            ),
          ),
        ));
  }
}
