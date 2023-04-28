import 'package:flutter/material.dart';

class AgreedTerms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Termos de Uso'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          '''
Termos de Uso 

O uso deste aplicativo está sujeito aos termos e condições abaixo apresentados. Ao utilizar O uso deste aplicativo está sujeito aos termos e condições abaixo apresentados. Ao utilizar o aplicativo, você concorda com estes termos e condições.

1 - Direitos Autorais
Todo o conteúdo deste aplicativo, incluindo textos, imagens, áudios e vídeos, é propriedade exclusiva do desenvolvedor e está protegido pelas leis de direitos autorais. Nenhum conteúdo poderá ser reproduzido, distribuído, transmitido, exibido, vendido, licenciado ou de outra forma explorado para qualquer finalidade sem o consentimento prévio e por escrito do desenvolvedor
''',
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
