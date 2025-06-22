import 'package:flutter/material.dart';
import 'package:viveri/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD3E0D1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Eventos hoje:'),
                  _buildHorizontalEventList(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Eventos em alta:'),
                  _buildHorizontalEventList(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Categorias:', showSeeAll: true),
                  _buildCategoryList(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Eventos em destaque:'),
                  _buildFeaturedEvents(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Interesse1:', showSeeAll: true),
                  _buildHorizontalEventList(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Visto recente:', showSeeAll: true),
                  _buildHorizontalEventList(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Tal coisa:', showSeeAll: true),
                  _buildHorizontalEventList(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: 16,
        right: 16,
        bottom: 16,
      ),
      color: const Color(0xFF5A6E58),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('nameless_logo.png', height: 40),
              Image.asset('notifications.png', height: 30),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Olá, John Doe!', style: TextStyle(color: Color(0xFF284017), fontSize: 18)),
                    Text('O que vamos fazer hoje?', style: TextStyle(color: Color(0xFF271D1C), fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Image.asset('icons_bruno/search.png', height: 30),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Icon(Icons.location_on, color: Colors.white, size: 16),
              SizedBox(width: 8),
              Text('Eventos em: Cidade - Estado', style: TextStyle(color: Colors.white)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, {bool showSeeAll = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        if (showSeeAll)
          const Text('ver tudo >', style: TextStyle(color: Colors.black54)),
      ],
    );
  }

  Widget _buildHorizontalEventList() {
    return Container(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return _buildEventCard();
        },
      ),
    );
  }

  Widget _buildEventCard() {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(top: 8, right: 16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(40, 64, 23, 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade500, // Placeholder for image
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color.fromRGBO(40, 64, 23, 0.8),
                        const Color.fromRGBO(40, 64, 23, 0),
                      ],
                      stops: [0.0, 0.69],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Evento', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black)),
                SizedBox(height: 2),
                Text('Localização', style: TextStyle(fontSize: 8, color: Colors.black)),
                SizedBox(height: 2),
                Text('Data', style: TextStyle(fontSize: 7, color: Colors.black)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    final categories = [
      {'icon': 'icons_bruno/festas.png', 'label': 'Festas/\nShows'},
      {'icon': 'icons_bruno/spt.png', 'label': 'Passeios/\nTours'},
      {'icon': 'icons_bruno/cursos.png', 'label': 'Workshops/\nCursos'},
      {'icon': 'icons_bruno/espiritualidade.png', 'label': 'Espiritualidade/\nOutros'},
      {'icon': 'icons_bruno/tecnologia.png', 'label': 'Tecnologia'},
      {'icon': 'icons_bruno/infantil.png', 'label': 'Infantil'},
    ];

    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            width: 80,
            margin: const EdgeInsets.only(top: 8, right: 12),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFB0BFAB),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(categories[index]['icon']!),
                  ),
                ),
                const SizedBox(height: 4),
                Flexible(
                  child: Text(
                    categories[index]['label']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedEvents() {
    return Column(
      children: [
        Container(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF5A6E58),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(child: Text("Destaque", style: TextStyle(color: Colors.white))), // Placeholder
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index ? const Color(0xFFF4B134) : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }
} 