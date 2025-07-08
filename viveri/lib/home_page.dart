import 'package:flutter/material.dart';
import 'package:viveri/bottom_nav_bar.dart';
import 'package:viveri/events/data/repositories/event_repositories.dart';
import 'package:viveri/events/data/model/event_model.dart';
import 'package:viveri/events/data/http/http_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:core';
import 'events_search.dart';
import 'events/evento_unico/notifications.dart';
import 'events/evento_unico/evento_unico.dart';
import 'events/telas_criar_evento/create_favorite.dart';
import 'package:viveri/faq/faq_tela.dart';
import 'package:viveri/preferencias.dart';

class HomePage extends StatefulWidget {
  final String? userLocation;
  const HomePage({Key? key, this.userLocation}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<EventModel> events = [];
  Map<String, dynamic>? userData;
  bool isLoading = true;
  String events_token = '';
  List<String> userInterests = [];
  List<int> recentlyViewedEvents = [];
  
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final userDataString = prefs.getString('user_data');
    if (accessToken != null) {
      events_token=accessToken;
      final repo = EventRepository(client: HttpClient());
      final fetchedEvents = await repo.getEvent(1);
      
      // Carrega interesses do usuário
      await _loadUserInterests();
      
      // Carrega eventos vistos recentemente
      await _loadRecentlyViewedEvents();
      
      setState(() {
        events = fetchedEvents;
        userData = userDataString != null ? json.decode(userDataString) : null;
        isLoading = false;
      });
    }
  }

  Future<void> _loadUserInterests() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString('user_data');
    if (userDataString != null) {
      final userData = json.decode(userDataString);
      final userEmail = userData['email'] ?? userData['username'];
      
      final selectedInterestsJson = prefs.getString('selected_interests_$userEmail');
      if (selectedInterestsJson != null) {
        final selectedInterests = List<String>.from(json.decode(selectedInterestsJson));
        setState(() {
          userInterests = selectedInterests;
        });
      }
    }
  }

  Future<void> _loadRecentlyViewedEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString('user_data');
    if (userDataString != null) {
      final userData = json.decode(userDataString);
      final userEmail = userData['email'] ?? userData['username'];
      
      final recentlyViewedJson = prefs.getString('recently_viewed_$userEmail');
      if (recentlyViewedJson != null) {
        final recentlyViewed = List<int>.from(json.decode(recentlyViewedJson));
        setState(() {
          recentlyViewedEvents = recentlyViewed;
        });
      }
    }
  }

  Future<void> _addToRecentlyViewed(int eventId) async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString('user_data');
    if (userDataString != null) {
      final userData = json.decode(userDataString);
      final userEmail = userData['email'] ?? userData['username'];
      
      // Remove o evento se já existe (para não duplicar)
      recentlyViewedEvents.remove(eventId);
      // Adiciona no início da lista
      recentlyViewedEvents.insert(0, eventId);
      
      // Mantém apenas os últimos 10 eventos vistos
      if (recentlyViewedEvents.length > 10) {
        recentlyViewedEvents = recentlyViewedEvents.take(10).toList();
      }
      
      await prefs.setString('recently_viewed_$userEmail', json.encode(recentlyViewedEvents));
      setState(() {});
    }
  }

  List<EventModel> getTodayEvents() {
    final today = DateTime.now();
    final todayString = "${today.year.toString().padLeft(4, '0')}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
    
    return events.where((event) {
      // Verifica se a data do evento é hoje
      // Primeiro tenta o formato YYYY-MM-DD
      if (event.start_date == todayString) {
        return true;
      }
      
      // Se não encontrar, tenta converter a data do evento para DateTime
      try {
        // Tenta diferentes formatos possíveis
        DateTime? eventDate;
        
        // Tenta formato YYYY-MM-DD
        if (event.start_date.contains('-')) {
          eventDate = DateTime.tryParse(event.start_date);
        }
        // Tenta formato DD/MM/YYYY
        else if (event.start_date.contains('/')) {
          final parts = event.start_date.split('/');
          if (parts.length == 3) {
            final day = int.tryParse(parts[0]);
            final month = int.tryParse(parts[1]);
            final year = int.tryParse(parts[2]);
            if (day != null && month != null && year != null) {
              eventDate = DateTime(year, month, day);
            }
          }
        }
        
        if (eventDate != null) {
          final isToday = eventDate.year == today.year && 
                         eventDate.month == today.month && 
                         eventDate.day == today.day;
          return isToday;
        }
      } catch (e) {
        // Silenciosamente ignora erros de conversão
      }
      
      return false;
    }).toList();
  }

  List<EventModel> getInterestsEvents() {
    if (userInterests.isEmpty) {
      return [];
    }
    
    // Mapeamento de interesses para categorias de eventos
    final Map<String, List<String>> interestToCategories = {
      'infantil': ['KID'],
      'festas': ['PRT', 'FST', 'CLB'],
      'passeios': ['TRS'],
      'esportes': ['SPT', 'COP'],
      'cursos': ['WRK', 'LCT'],
      'pride': ['PRD'],
      'espiritualidade': ['REL'],
      'tecnologia': ['TEC'],
    };
    
    // Coleta todas as categorias dos interesses do usuário
    final Set<String> userCategories = <String>{};
    for (final interest in userInterests) {
      if (interestToCategories.containsKey(interest)) {
        userCategories.addAll(interestToCategories[interest]!);
      }
    }
    
    // Filtra eventos que correspondem às categorias dos interesses
    return events.where((event) {
      return userCategories.contains(event.category);
    }).toList();
  }

  List<EventModel> getRecentlyViewedEvents() {
    if (recentlyViewedEvents.isEmpty) {
      return [];
    }
    
    // Filtra eventos que estão na lista de vistos recentemente
    // e os ordena pela ordem em que foram vistos (mais recentes primeiro)
    final List<EventModel> filteredEvents = [];
    
    // Itera pela lista de IDs na ordem que foram vistos (mais recentes primeiro)
    for (final eventId in recentlyViewedEvents) {
      final event = events.firstWhere(
        (event) => event.id == eventId,
        orElse: () => EventModel(
          id: 0,
          title: '',
          description: '',
          start_date: '',
          end_date: '',
          start_time: '',
          endtime: '',
          status: false,
          category: '',
          space: 0,
          type_event: '',
          age_range: 0,
          creator: 0,
          crated_at: '',
          documentations: '',
          participants: [],
        ),
      );
      
      // Adiciona apenas se o evento foi encontrado e não é um evento vazio
      if (event.id != 0) {
        filteredEvents.add(event);
      }
    }
    
    return filteredEvents;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xFFD3E0D1),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final userName = (userData?['first_name'] ?? '');
    final userLocation = widget.userLocation ?? userData?['adress_city'] ?? 'Localização não informada';

    return Scaffold(
      backgroundColor: const Color(0xFFD3E0D1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, userName, userLocation),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Eventos hoje:'),
                  _buildHorizontalEventList(getTodayEvents()),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Eventos em alta:'),
                  _buildHorizontalEventList(events),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Categorias:', showSeeAll: true, initialTab: 0),
                  _buildCategoryList(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Eventos em destaque:'),
                  _buildHorizontalEventList(events),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Interesses:'),
                  _buildHorizontalEventList(getInterestsEvents()),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Visto recentemente:'),
                  _buildHorizontalEventList(getRecentlyViewedEvents()),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Todos os Eventos:', showSeeAll: true, initialTab: 1),
                  _buildHorizontalEventList(events),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 0, userData: userData!, accessToken: events_token??'',),
    );
  }

  Widget _buildHeader(BuildContext context, String userName, String userLocation) {
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
              Image.asset('assets/nameless_logo.png', height: 40),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Notifications()),
                  );
                },
                child: Image.asset('assets/notifications.png', height: 30),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Olá, $userName!', style: TextStyle(color: Color(0xFF284017), fontSize: 18)),
                    Text('O que vamos fazer hoje?', style: TextStyle(color: Color(0xFF271D1C), fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EventSearch(title: 'Buscar eventos')),
                  );
                },
                child: Image.asset('assets/icons_bruno/search.png', height: 30),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.white, size: 16),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Eventos em: $userLocation',
                      style: TextStyle(color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, {bool showSeeAll = false, int initialTab = 1}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        if (showSeeAll)
          GestureDetector(
            onTap: () {
              if (title == 'Categorias:') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Preferencias(title: 'Interesses'),
                  ),
                );
              } else if (title == 'Todos os Eventos:') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventSearch(title: 'Todos os Eventos'),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateFavorite(
                      userData: userData!,
                      accessToken: events_token,
                      initialTab: initialTab,
                    ),
                  ),
                );
              }
            },
            child: const Text('ver tudo >', style: TextStyle(color: Colors.black54)),
          ),
      ],
    );
  }

  Widget _buildHorizontalEventList(List<EventModel> events) {
    if (events.isEmpty) {
      return Container(
        height: 110,
        child: Center(
          child: Text(
            'Nada para ver aqui',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      );
    }
    
    return Container(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return _buildEventCard(event);
        },
      ),
    );
  }

  Widget _buildEventCard(EventModel event) {
    return GestureDetector(
      onTap: () {
        // Adiciona o evento à lista de vistos recentemente
        _addToRecentlyViewed(event.id);
        
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventoUnico(event: event)),
        );
      },
      child: Container(
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
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black)),
                  SizedBox(height: 2),
                  Text('Local: ${event.space}', style: TextStyle(fontSize: 8, color: Colors.black)),
                  SizedBox(height: 2),
                  Text('Data: ${event.start_date}', style: TextStyle(fontSize: 7, color: Colors.black)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    final categories = [
      {'icon': 'assets/icons_bruno/festas.png', 'label': 'Festas/\nShows'},
      {'icon': 'assets/icons_bruno/spt.png', 'label': 'Passeios/\nTours'},
      {'icon': 'assets/icons_bruno/cursos.png', 'label': 'Workshops/\nCursos'},
      {'icon': 'assets/icons_bruno/espiritualidade.png', 'label': 'Espiritualidade/\nOutros'},
      {'icon': 'assets/icons_bruno/tecnologia.png', 'label': 'Tecnologia'},
      {'icon': 'assets/icons_bruno/infantil.png', 'label': 'Infantil'},
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