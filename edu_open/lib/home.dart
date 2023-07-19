import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'favoritos.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Item> _items = [
    Item(
      headerValue: 'Censo Escolar',
      expandedValue: 'Microdados do Censo Escolar da Educacação Básica',
      isExpanded: false,
      isFavorite: false,
      link: Uri.parse(
          'https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/censo-escolar'),
      dataAtualizacao: 'Atualizado em 08/03/2023 17h26',
    ),
    Item(
      headerValue: 'Censo da Educação Superior',
      expandedValue: 'Microdados do Censo da Educação Superior ',
      isExpanded: false,
      isFavorite: false,
      link: Uri.parse(
          'https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/censo-da-educacao-superior'),
      dataAtualizacao: 'Atualizado em 04/11/2022 10h10',
    ),
    Item(
      headerValue: 'Enade',
      expandedValue: 'Microdados do Enade',
      isExpanded: false,
      isFavorite: false,
      link: Uri.parse(
          'https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/enade'),
      dataAtualizacao: 'Atualizado em 27/10/2022 17h31',
    ),
    Item(
      headerValue: 'UFPE - Cursos de Graduação',
      expandedValue:
          'informações a cerca dos cursos de graduação existentes na Universidade Federal de Pernambuco.',
      isExpanded: false,
      isFavorite: false,
      link: Uri.parse('https://dados.ufpe.br/dataset/cursos-de-graduacao'),
      dataAtualizacao: 'Atualizado em 07/03/2023 16h15',
    ),
    Item(
      headerValue: 'Sisu - Dados Abertos - MEC',
      expandedValue:
          'Dados relacionados as inscrições realizadas nos processos seletivos do SISU.',
      isExpanded: false,
      isFavorite: false,
      dataAtualizacao: 'Atualizado em 22/02/2023',
      link: Uri.parse(
          'https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/enade'),
    ),
    Item(
      headerValue: 'UFRPE - Ensino de Graduação',
      expandedValue: 'Dados dos cursos de Graduação oferecidos pela UFRPE.',
      isExpanded: false,
      isFavorite: false,
      link: Uri.parse('http://dados.ufrpe.br/dataset/cursos-de-graduacao'),
      dataAtualizacao: 'Atualizado em 19/04/2023 08h30',
    ),
  ];
  final List<Item> _favoriteItems = [];

  void _onItemFavoriteChanged(Item item, bool isFavorite) {
    setState(() {
      item.isFavorite = isFavorite;
      if (isFavorite) {
        _favoriteItems.add(item);
      } else {
        _favoriteItems.remove(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bases Cadastradas'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            color: Colors.red,
            onPressed: () {
              _showFavorites();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: _buildPanelList(),
        ),
      ),
    );
  }

  Widget _buildPanelList() {
    return ExpansionPanelList(
      elevation: 1,
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _items[index].isExpanded = !isExpanded;
        });
      },
      children: _items.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              leading: IconButton(
                icon: Icon(
                  item.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: item.isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  setState(() {
                    item.isFavorite = !item.isFavorite;
                    if (item.isFavorite) {
                      _favoriteItems.add(item);
                    } else {
                      _favoriteItems.remove(item);
                    }
                  });
                },
              ),
              title: Text(item.headerValue),
            );
          },
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(item.expandedValue),
              ),
              if (item.link != null)
                GestureDetector(
                    onTap: () async {
                      if (await launchUrl(item.link)) {
                        await launchUrl(item.link);
                      } else {
                        throw 'Não foi possível abrir o link: ${item.link}';
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                      child: Text(
                        item.link.toString(),
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )),
              if (item.dataAtualizacao.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                  child: Text(
                    (item.dataAtualizacao),
                    textAlign: TextAlign.left,
                  ),
                ),
            ],
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  void _showFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => FavoritesPage(
          favoriteItems: _favoriteItems,
        ),
      ),
    );
  }
}

class Item {
  Item({
    required this.headerValue,
    required this.expandedValue,
    this.isExpanded = false,
    this.isFavorite = false,
    required this.dataAtualizacao,
    required this.link,
  });

  String headerValue;
  String expandedValue;
  bool isExpanded;
  bool isFavorite;
  String dataAtualizacao;
  Uri link;

  Future<void> _launchUrl() async {
    if (!await launchUrl(link)) {
      throw Exception('Could not launch $link');
    }
  }
}
