import 'package:flutter/material.dart';
import '../controllers/theme_controller.dart';
import '../widgets/akanga_app_bar.dart';
import 'menu_screen.dart';

class AjudaScreen extends StatefulWidget {
  @override
  _AjudaScreenState createState() => _AjudaScreenState();
}

class _AjudaScreenState extends State<AjudaScreen> {
  String _searchText = '';
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocus = FocusNode();
  Map<String, String> _faqDetails = {
    'Como adicionar um novo card?':
        'Para adicionar um novo card, vá para a tela principal e clique no ícone de "Mais" no canto inferior direito, após preencha as informações necessárias e clique em "Salvar".',
    'Como editar meu perfil?':
        'Você pode editar seu perfil na tela de "Editar Perfil". Lá você pode atualizar suas informações, como Nome, Email e Senha.',
    'Como excluir um card?':
        'Na tela de visualização do card, clique no ícone de "lixeira" e excluirá automaticamente o card.',
    'Como alterar o nome do deck ou excluí-lo?':
        'Na tela principal, clique no ícone de "engrenagem", após aparecerá um editor para que haja a alteração do deck desejado ou que ele possa ser excluído.',
    'O que é o Navegar por cards?':
        'Na opção Navegar por cards ao clicar no menu você poderá ver todos os seus cards salvos em respectivos decks, podendo excluí-los ou revê-los.',
    'Como ativar o modo escuro?':
        'Na tela principal, clique no menu e no canto inferior direito haverá um ícone para escolha do modo escuro.',
    'Como excluir minha conta?':
        'Na tela principal, clique no menu e entre na aba Editar Perfil, após isso se depará com um ícone de "lixeira", clicando nela excluirá sua conta automaticamente.',
  };

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });

    _searchFocus.addListener(() {
      if (_searchFocus.hasFocus) {
        setState(() {
          _searchText = '';
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  List<String> _filteredFaqs() {
    return _faqDetails.keys.where((faq) {
      return faq.toLowerCase().contains(_searchText.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AkangaAppBar(),
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
        child: Drawer(child: MenuPage()),
      ),
      drawerScrimColor: ThemeController.instance.isdartTheme
          ? const Color(0xFF2D2D2D)
          : Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  FocusScope.of(context).requestFocus(_searchFocus);
                });
              },
              child: AbsorbPointer(
                absorbing: true,
                child: TextField(
                  controller: _searchController,
                  focusNode: _searchFocus,
                  decoration: InputDecoration(
                      hintText: _searchText.isEmpty ? 'Pesquisar' : '',
                      prefixIcon: Icon(Icons.search,
                          color: Color.fromRGBO(105, 44, 133, 1)),
                      filled: false,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xFF4A148C),
                        width: 2,
                      ))),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Perguntas Frequentes:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(74, 20, 140, 1),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredFaqs().length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Card(
                        color: Color.fromRGBO(235, 235, 235, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide.none),
                        child: ExpansionTile(
                          title: Text(
                            _filteredFaqs()[index],
                            style: TextStyle(
                              color: Color.fromRGBO(74, 20, 140, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                _faqDetails[_filteredFaqs()[index]] ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Sobre Nós',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(74, 20, 140, 1),
              ),
            ),
            SizedBox(height: 10),
            Card(
              color: Color.fromRGBO(235, 235, 235, 1),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bem-vindo ao Akangá!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Somos uma equipe dedicada a criar aplicativos incríveis para ajudar você a organizar suas informações de maneira simples e eficiente. Estamos sempre trabalhando para melhorar sua experiência.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
