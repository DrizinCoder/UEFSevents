import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viveri/reset_password_page.dart';

class VerifyCodePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const VerifyCodePage({Key? key, required this.userData}) : super(key: key);

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  int _seconds = 60;
  late Timer _timer;
  bool _isLoading = false;
  String? _errorMessage;
  String _verificationCode = ''; // Código gerado para comparação

  final bgColor = Color(0xDDE8F1E8);
  final darkGreen = Color(0xFF2F4F2F);
  final lightGreen = Color(0xFFC5D3C3);
  final orange = Color(0xFFFF8C00);

  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(5, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    _startTimer();
    _generateVerificationCode(); // Gera o código de verificação
  }

  void _generateVerificationCode() {
    // Em produção, isso seria enviado por email
    // Aqui estamos apenas simulando um código de 5 dígitos
    final random = DateTime.now().millisecondsSinceEpoch;
    _verificationCode = (random % 100000).toString().padLeft(5, '0');
    print("Código de verificação: $_verificationCode"); // Para testes
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (_seconds > 0) {
        setState(() => _seconds--);
      } else {
        _timer.cancel();
      }
    });
  }

  Future<void> _validateCode() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Construir o código digitado pelo usuário
    final enteredCode = _controllers.map((c) => c.text).join();

    // Simular tempo de validação
    await Future.delayed(Duration(seconds: 1));

    if (enteredCode == _verificationCode) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResetPasswordPage(userId: widget.userData['id']),
        ),
      );
    } else {
      setState(() {
        _errorMessage = 'Código inválido. Tente novamente.';
        // Limpa os campos
        for (var controller in _controllers) {
          controller.clear();
        }
        _focusNodes[0].requestFocus();
      });
    }

    setState(() => _isLoading = false);
  }

  Future<void> _resendCode() async {
    setState(() {
      _seconds = 60;
      _errorMessage = null;
      for (var controller in _controllers) {
        controller.clear();
      }
      _focusNodes[0].requestFocus();
    });

    _generateVerificationCode();
    _startTimer();

    // Mostrar mensagem de sucesso
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Novo código enviado para ${widget.userData['email']}'),
        backgroundColor: darkGreen,
      ),
    );
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
              // Botão de voltar
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              Spacer(),

              Image.asset('assets/logo.png', height: 100),
              SizedBox(height: 8),
              
              Text(
                'Código enviado para:',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: darkGreen,
                ),
              ),
              Text(
                widget.userData['email'],
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: darkGreen,
                ),
              ),
              
              SizedBox(height: 16),
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
                        errorText: _errorMessage != null && index == 0 
                            ? _errorMessage : null,
                      ),
                      onChanged: (val) {
                        if (val.isNotEmpty && index < 4) {
                          _focusNodes[index + 1].requestFocus();
                        } else if (val.isEmpty && index > 0) {
                          _focusNodes[index - 1].requestFocus();
                        }
                        
                        // Validação automática quando todos os campos estão preenchidos
                        if (index == 4 && val.isNotEmpty) {
                          final fullCode = _controllers.map((c) => c.text).join();
                          if (fullCode.length == 5) {
                            _validateCode();
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Timer e botão de reenvio
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
              
              SizedBox(height: 8),
              TextButton(
                onPressed: _seconds == 0 ? _resendCode : null,
                child: Text(
                  'Reenviar código',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _seconds == 0 ? orange : Colors.grey,
                  ),
                ),
              ),

              SizedBox(height: 32),

              // Botão Validar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _validateCode,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkGreen,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(color: orange)
                      : Text(
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