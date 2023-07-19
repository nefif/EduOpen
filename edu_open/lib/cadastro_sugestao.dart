import 'package:flutter/material.dart';

class CadastroBase extends StatefulWidget {
  @override
  _CadastroBaseState createState() => _CadastroBaseState();
}

class _CadastroBaseState extends State<CadastroBase> {
  final _formKey = GlobalKey<FormState>();
  final _nomeBaseController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _linkController = TextEditingController();

  bool _isModalVisible = false;
  bool _isNomeBaseFocused = false;
  bool _isDescricaoFocused = false;
  bool _isLinkFocused = false;

  void _enviarFormulario() {
    if (_formKey.currentState!.validate()) {
      // Envie os dados do formulário para o backend ou realize qualquer ação desejada
      _limparFormulario();
      _mostrarModal();
    } else {
      setState(() {
        _isNomeBaseFocused = _nomeBaseController.text.isEmpty;
        _isDescricaoFocused = _descricaoController.text.isEmpty;
        _isLinkFocused = _linkController.text.isEmpty;
      });
    }
  }

  void _limparFormulario() {
    _nomeBaseController.clear();
    _descricaoController.clear();
    _linkController.clear();
  }

  void _mostrarModal() {
    setState(() {
      _isModalVisible = true;
    });
  }

  void _fecharModal() {
    setState(() {
      _isModalVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                const Text(
                  'Nome da Base',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: _nomeBaseController,
                  decoration: InputDecoration(
                    hintText: 'Digite o nome da base',
                    errorText: _isNomeBaseFocused ? 'Campo obrigatório' : null,
                  ),
                  onChanged: (_) {
                    setState(() {
                      _isNomeBaseFocused = false;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      setState(() {
                        _isNomeBaseFocused = true;
                      });
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Descrição da Base',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: _descricaoController,
                  decoration: InputDecoration(
                    hintText: 'Digite a descrição da base',
                    errorText: _isDescricaoFocused ? 'Campo obrigatório' : null,
                  ),
                  onChanged: (_) {
                    setState(() {
                      _isDescricaoFocused = false;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      setState(() {
                        _isDescricaoFocused = true;
                      });
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Link para a página',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: _linkController,
                  decoration: InputDecoration(
                    hintText: 'Digite o link para a página',
                    errorText: _isLinkFocused ? 'Campo obrigatório' : null,
                  ),
                  onChanged: (_) {
                    setState(() {
                      _isLinkFocused = false;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      setState(() {
                        _isLinkFocused = true;
                      });
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _enviarFormulario,
                  child: const Text('ENVIAR'),
                ),
                if (_isModalVisible)
                  GestureDetector(
                    onTap: _fecharModal,
                    child: AlertDialog(
                      titlePadding: const EdgeInsets.all(0.0),
                      contentPadding: const EdgeInsets.all(16.0),
                      content: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Sucesso'),
                            const SizedBox(height: 16.0),
                            const Text('Mensagem enviada com sucesso'),
                            const SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: _fecharModal,
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
