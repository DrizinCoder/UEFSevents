import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'home_page.dart';

class LocationPermissionPage extends StatefulWidget {
  LocationPermissionPage({Key? key}) : super(key: key);

  @override
  State<LocationPermissionPage> createState() => _LocationPermissionPageState();
}

class _LocationPermissionPageState extends State<LocationPermissionPage> {
  bool _showPermissionScreen = false;

  @override
  void initState() {
    super.initState();
    _checkPermissionStatus();
  }

  Future<void> _checkPermissionStatus() async {
    LocationPermission permission = await Geolocator.checkPermission();
    print('DEBUG: Status da permissão: $permission');
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      _getAndGoToHome();
    } else if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) {
      setState(() => _showPermissionScreen = true);
    } else {
      setState(() => _showPermissionScreen = true);
    }
  }

  Future<void> _getAndGoToHome() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print('DEBUG: position = ${position.latitude}, ${position.longitude}');
      String cityState = 'Localização não informada';
      if (kIsWeb) {
        cityState = '${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}';
      } else {
        List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
        print('DEBUG: placemarks = $placemarks');
        if (placemarks.isNotEmpty) {
          final p = placemarks.first;
          cityState = ((p.locality ?? p.subAdministrativeArea ?? '') + ', ' + (p.administrativeArea ?? '')).trim();
          if (cityState == ',') cityState = 'Localização não informada';
        }
      }
      print('DEBUG: cityState = $cityState');
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            userLocation: cityState,
          ),
        ),
      );
    } catch (e, stack) {
      print('DEBUG: erro ao obter localização: $e');
      print('DEBUG: stacktrace: $stack');
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            userLocation: 'Localização não informada',
          ),
        ),
      );
    }
  }

  Future<void> _requestPermission() async {
    print('DEBUG: _requestPermission chamado');
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      print('DEBUG: Permissão concedida');
      _getAndGoToHome();
    } else {
      print('DEBUG: Permissão negada');
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            userLocation: 'Localização não informada',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('DEBUG: LocationPermissionPage build chamada');
    if (!_showPermissionScreen) {
      return Scaffold(
        backgroundColor: const Color(0xFFD3E0D1),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xFFD3E0D1),
      body: Center(
        child: Container(
          width: 320,
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F1E8),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('point.png', height: 70),
              const SizedBox(height: 12),
              const Text(
                'Pesquisar eventos por perto?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F4F2F),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Divider(height: 1, thickness: 1, color: Color(0xFFB0B0B0)),
              const SizedBox(height: 12),
              const Text(
                'Ajudamos você a descobrir eventos perto do seu local atual. Sua localização não será armazenada.',
                style: TextStyle(fontSize: 14, color: Color(0xFF2F4F2F)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print('DEBUG: Botão Ativar o GPS pressionado');
                    _requestPermission();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F4F2F),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Ativar o GPS',
                    style: TextStyle(color: Color(0xFFFF8C00), fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print('DEBUG: Botão Não permitir pressionado');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          userLocation: 'Localização não informada',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F4F2F),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Não permitir',
                    style: TextStyle(color: Color(0xFFFF8C00), fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 