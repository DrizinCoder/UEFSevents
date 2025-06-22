import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Um botão de voltar customizado, circular e com um ícone rotacionado.
class CustomBackButton extends StatelessWidget {
  /// A função a ser chamada quando o botão é pressionado.
  final VoidCallback onPressed;

  /// A cor de fundo do círculo do botão.
  final Color backgroundColor;

  /// A cor do ícone da seta.
  final Color iconColor;

  const CustomBackButton({
    Key? key,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF2F4538),
    this.iconColor = const Color(0xFFF4B134),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Usamos IconButton para ter a área de toque adequada e feedback visual.
    return IconButton(
      padding: EdgeInsets.zero,
      icon: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        // O Transform.rotate gira o ícone para que ele aponte para trás.
        child: Transform.rotate(
          angle: math.pi, // Rotaciona 180 graus (π radianos)
          child: Icon(
            Icons.arrow_forward_ios,
            color: iconColor,
            size: 13, // Tamanho aproximado com base no design
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
} 