import 'package:flutter/material.dart';
import 'dart:async';
import 'welcome_screen.dart';

// Widget da tela de onboarding
class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Controlador para gerenciar a navegação entre páginas
  final PageController _controller = PageController();
  // Índice da página atual
  int _currentPage = 0;
  // Variável para controlar o gesto de swipe
  bool _isLastPage = false;

  // Método que constrói as páginas do onboarding
  List<Widget> _buildPages() {
    return [
      // Página 1 - Apresentação dos eventos
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/person_phone.png', width: 180),
          SizedBox(height: 32),
          Text(
            'Seus eventos favoritos sempre em seu celular',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF425C44),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Eventos Nacionais, streaming, música, teatro e muito mais!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
      // Página 2 - Criação de eventos
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/megaphone.png', width: 140),
          SizedBox(height: 32),
          Text(
            'Use sua voz e crie seus próprios eventos!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF425C44),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Publique seus eventos e compartilhe com seus amigos!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    ];
  }

  // Método que constrói os indicadores de página
  Widget _buildIndicator(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        // Cor amarela para a página atual, cinza para as outras
        color: _currentPage == index ? Color(0xFFFFB300) : Colors.black45,
        shape: BoxShape.circle,
      ),
    );
  }

  // Método para navegar para a próxima página
  void _nextPage() {
    if (_currentPage < _buildPages().length - 1) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      // Navega para a tela de boas-vindas quando estiver na última página
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    }
  }

  // Método para navegar para a página anterior
  void _previousPage() {
    if (_currentPage > 0) {
      _controller.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  void dispose() {
    // Limpa os recursos quando o widget for destruído
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = _buildPages();
    return Scaffold(
      // Define a cor de fundo como verde claro
      backgroundColor: Color(0xFFD3E0D1),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  // Implementa o PageView para navegação entre páginas
                  child: GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (_currentPage == pages.length - 1 && details.primaryVelocity! > 0) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => WelcomeScreen()),
                        );
                      }
                    },
                    child: PageView.builder(
                      controller: _controller,
                      itemCount: pages.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: pages[index],
                      ),
                    ),
                  ),
                ),
                // Indicadores de página
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(pages.length, _buildIndicator),
                ),
                SizedBox(height: 56),
              ],
            ),
            // Área clicável da esquerda para navegação
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: MediaQuery.of(context).size.width * 0.2,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: _previousPage,
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            // Área clicável da direita para navegação
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: MediaQuery.of(context).size.width * 0.2,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: _nextPage,
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 