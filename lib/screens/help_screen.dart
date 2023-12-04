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
        'Para adicionar um novo card, vá até a tela principal e clique no ícone + no canto inferior direito, selecione ADICIONAR CARD e após preencher as informações necessárias, clique em SALVAR.',
    'Como excluir um card?':
        'Na tela de visualização do card, clique no ícone de lixeira, que excluirá automaticamente o card.',
    'Como alterar o nome do deck ou excluí-lo?':
        'Na tela principal, clique no ícone de engrenagem do deck que deseja alterar, aparecerá um editor para que seja feita a alteração ou exclusão do deck desejado.',
    'O que é a tela NAVEGAR POR CARDS?':
        'A opção NAVEGAR POR CARDS, no menu lateral, permite a visualização de todos os cards salvos, podendo excluí-los ou estudá-los.',
    'Como editar meu perfil?':
        'Você pode editar seu perfil na tela de EDITAR PERFIL, no menu lateral. Lá podem ser atualizadas informações como nome, e-mail e senha.',
    'Como excluir minha conta?':
        'No menu lateral, na aba EEDITAR PERFIL, há um ícone de lixeira, clicando nele a conta será excluída automaticamente.',
    'Como ativar o modo noturno?':
        'No canto inferior direito do menu lateral há a ferramenta para escolha do modo noturno.',
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
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
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
                      prefixIcon:
                          Icon(Icons.search, color: Colors.deepPurple.shade700),
                      filled: false,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.deepPurple.shade700,
                        width: 2,
                      ))),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'FAQ - PERGUNTAS FREQUENTES',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade700,
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
                      child: ExpansionTile(
                        collapsedBackgroundColor: Colors.grey.shade200,
                        backgroundColor: Colors.grey.shade200,
                        collapsedIconColor: Colors.deepPurple.shade700,
                        iconColor: Colors.deepPurple.shade700,
                        title: Text(
                          _filteredFaqs()[index],
                          style: TextStyle(
                            color: Colors.deepPurple.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                            child: Text(
                              _faqDetails[_filteredFaqs()[index]] ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SOBRE NÓS',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade700,
                  ),
                ),
                Image.asset(
                  'images/icon/COLORFUL/ColorfulLogo.png',
                  width: 50 * fem,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 8, bottom: 8, right: 8),
              child: Text(
                'Somos uma equipe que se dedicou à criação de uma plataforma que atua na dificuldade de retenção de ideias pelo cérebro humano e você, nosso usuário, tem o prazer de usufuir dessa técnica em seu smartphone.',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
