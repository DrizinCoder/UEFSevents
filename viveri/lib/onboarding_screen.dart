import 'package:flutter/material.dart';
import 'dart:async';
import 'welcome_screen.dart';

// Widget da tela de onboarding
class OnboardingScreen extends StatefulWidget {
  final int initialPage;
  
  const OnboardingScreen({Key? key, this.initialPage = 0}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Controlador para gerenciar a navegação entre páginas
  late final PageController _controller;
  // Índice da página atual
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // Inicializa o controlador com a página inicial especificada
    _controller = PageController(initialPage: widget.initialPage);
    _currentPage = widget.initialPage;
  }

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
        child: Column(
          children: [
            Expanded(
              // Implementa o PageView para navegação entre páginas
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                // Permite o gesto de deslizar para navegar entre páginas
                physics: PageScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onDoubleTap: (){
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => WelcomeScreen(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            var begin = Offset(1.0, 0.0);
                            var end = Offset.zero;
                            var curve = Curves.easeInOut;
                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                          transitionDuration: Duration(milliseconds: 400),
                        ),
                      );
                    },
                    onHorizontalDragEnd: (details) {
                      if (index == pages.length - 1 && details.primaryVelocity! < 0) {
                        // Deslizar da direita para a esquerda na última página
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => WelcomeScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              var begin = Offset(1.0, 0.0);
                              var end = Offset.zero;
                              var curve = Curves.easeInOut;
                              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                            transitionDuration: Duration(milliseconds: 400),
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: pages[index],
                    ),
                  );
                },
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
      ),
    );
  }
} 