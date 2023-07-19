import 'package:flutter/material.dart';
import 'home_page.dart';
import 'database_helper.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Verificar as credenciais no banco de dados
    bool isAuthenticated =
        await DatabaseHelper().authenticateUser(username, password);

    if (isAuthenticated) {
      // Navegar para a página inicial
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } else {
      // Exibir mensagem de erro
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erro de autenticação'),
            content: const Text(
                'Usuário ou senha inválidos. Por favor, tente novamente.'),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16.0),
              TextField(
                controller: _usernameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  hintText: 'Usuário',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => login(context), // Chamada da função de login
                child: const Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
