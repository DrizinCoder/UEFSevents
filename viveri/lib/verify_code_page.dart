import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viveri/reset_password_page.dart';

class VerifyCodePage extends StatefulWidget {
  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  int _seconds = 60;
  late Timer _timer;

  final bgColor = Color(0xDDE8F1E8);
  final darkGreen = Color(0xFF2F4F2F);
  final lightGreen = Color(0xFFC5D3C3);
  final orange = Color(0xFFFF8C00);

  final List<FocusNode> _focusNodes =
      List.generate(5, (_) => FocusNode()); // 5 campos
  final List<TextEditingController> _controllers =
      List.generate(5, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controllers.forEach((c) => c.dispose());
    _focusNodes.forEach((f) => f.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              Spacer(),
              Image.asset('../assets/logo.png', height: 100),
              SizedBox(height: 8),
              Text(
                'Informe o código recebido por email',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: darkGreen,
                ),
              ),
              SizedBox(height: 16),

              // Caixa dos dígitos
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  5,
                  (index) => SizedBox(
                    width: 50,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        color: darkGreen,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: lightGreen,
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (val) {
                        if (val.isNotEmpty && index < 4) {
                          _focusNodes[index + 1].requestFocus();
                        }
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Timer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tentar novamente em:  ',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: darkGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    _formatTime(_seconds),
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32),

              // Botão Validar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ResetPasswordPage()),
                      );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkGreen,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(
                    'Validar',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: orange,
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }
}
