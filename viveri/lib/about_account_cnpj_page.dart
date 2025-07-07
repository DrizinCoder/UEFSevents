import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:viveri/custom_back_button.dart';
import 'package:viveri/pdf_viewer_page.dart';
import 'package:file_picker/file_picker.dart';

class AboutAccountCnpjPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  final String accessToken;

  const AboutAccountCnpjPage({
    Key? key,
    required this.userData,
    required this.accessToken,
  }) : super(key: key);

  @override
  _AboutAccountCnpjPageState createState() => _AboutAccountCnpjPageState();
}

class _AboutAccountCnpjPageState extends State<AboutAccountCnpjPage> {
  PlatformFile? selectedDocument;
  bool isDocumentAttached = false;

  Future<void> _pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
      );

      if (result != null && mounted) {
        setState(() {
          selectedDocument = result.files.first;
          isDocumentAttached = true;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao selecionar documento: $e')),
        );
      }
    }
  }

  void _viewDocument() {
    if (selectedDocument != null) {
      print('Visualizando documento: ${selectedDocument!.name}');
      print('Tamanho do arquivo: ${selectedDocument!.size} bytes');
      print('É web: $kIsWeb');
      
      if (kIsWeb) {
        print('Bytes disponíveis: ${selectedDocument!.bytes != null}');
        print('Tamanho dos bytes: ${selectedDocument!.bytes?.length}');
        // No web, usamos os bytes diretamente
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PDFViewerPage(
              fileBytes: selectedDocument!.bytes!,
              fileName: selectedDocument!.name,
              isWeb: true,
            ),
          ),
        );
      } else {
        print('Path disponível: ${selectedDocument!.path != null}');
        print('Path: ${selectedDocument!.path}');
        // No mobile, usamos o path
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PDFViewerPage(
              filePath: selectedDocument!.path!,
              fileName: selectedDocument!.name,
              isWeb: false,
            ),
          ),
        );
      }
    } else {
      print('Nenhum documento selecionado');
    }
  }

  void _removeDocument() {
    setState(() {
      selectedDocument = null;
      isDocumentAttached = false;
    });
  }

  void _changeDocument() {
    _pickDocument();
  }

  String _truncateFileName(String fileName) {
    if (fileName.length > 18) {
      return '${fileName.substring(0, 15)}...';
    }
    return fileName;
  }

  @override
  Widget build(BuildContext context) {
    // Extrai dados do usuário (CNPJ)
    final companyName = widget.userData['company_name'] ?? '';
    final respFirstName = widget.userData['first_name'] ?? '';
    final respLastName = widget.userData['last_name'] ?? '';
    final email = widget.userData['email'] ?? '';
    final vat = widget.userData['vat']?.toString() ?? '';
    final phone = widget.userData['phone']?.toString() ?? '000000000';
    final userId = widget.userData['id']?.toString() ?? '';

    // Formata o CNPJ (se tiver 14 dígitos)
    String formattedVat = '**.***.***/****-**';
    if (vat.length == 14) {
      formattedVat = '${vat.substring(0, 2)}.${vat.substring(2, 5)}.${vat.substring(5, 8)}/${vat.substring(8, 12)}-${vat.substring(12)}';
    }

    // Formata o telefone
    String formattedPhone = phone;
    if (phone.length == 10) {
      formattedPhone = '(${phone.substring(0, 2)}) ${phone.substring(2, 6)}-${phone.substring(6)}';
    } else if (phone.length == 11) {
      formattedPhone = '(${phone.substring(0, 2)}) ${phone.substring(2, 7)}-${phone.substring(7)}';
    }

    return Scaffold(
      backgroundColor: const Color(0xFFD3E0D1),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20.0, 80.0, 20.0, 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Seção do tipo de documento
                  const Text('Tipo de documento:', style: TextStyle(color: Colors.black54)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text('CNPJ:', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(formattedVat),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: _pickDocument,
                    child: const Text('Enviar documento', style: TextStyle(color: Color(0xFF425C44))),
                  ),
                  
                  // Seção do documento anexado
                  if (isDocumentAttached) ...[
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'Documento anexado',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const Spacer(),
                        // Botão para alterar documento
                        TextButton(
                          onPressed: _changeDocument,
                          child: const Text(
                            'Alterar',
                            style: TextStyle(
                              color: Color(0xFF425C44),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        // Botão para remover documento
                        TextButton(
                          onPressed: _removeDocument,
                          child: const Text(
                            'Remover',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: _viewDocument,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFF425C44), width: 1),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.picture_as_pdf,
                              color: Colors.red,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _truncateFileName(selectedDocument?.name ?? 'Documento.pdf'),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Toque para visualizar',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF425C44),
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  
                  const Divider(),
                  // Informações da empresa
                  _buildInfoRow('Nome vinculado ao CNPJ:', '$respFirstName $respLastName'),
                  _buildInfoRow('Nome fantasia:', companyName),
                  _buildInfoRow('ID da conta:', userId),
                  _buildInfoRow('Telefone de Contato:', formattedPhone),
                  _buildInfoRow('Email:', email),
                  _buildInfoRow('Nome do responsável:', '$respFirstName $respLastName'),
                  const Divider(),
                  TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ChangePasswordPage(
                      //       accessToken: widget.accessToken,
                      //     ),
                      //   ),
                      // );
                    },
                    child: const Text('Alterar senha', style: TextStyle(color: Color(0xFF425C44))),
                  ),
                  // Opção para desativar conta
                  TextButton(
                    onPressed: () {
                      // Ação para desativar conta
                    },
                    child: const Text('Desativar conta', style: TextStyle(color: Color(0xFF425C44))),
                  ),
                  // Opção para excluir conta
                  TextButton(
                    onPressed: () {
                      // Ação para excluir conta
                    },
                    child: const Text('Excluir conta', style: TextStyle(color: Color(0xFF425C44))),
                  ),
                  const SizedBox(height: 50),
                  // Rodapé com informações de versão
                  const Center(
                    child: Text(
                      'Version 1.0',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
            // Header fixo que fica sobre o conteúdo
            Container(
              height: 60,
              color: const Color(0xFF425C44),
              child: const Center(
                child: Text('Sobre a conta', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            // Botão de voltar posicionado sobre tudo
            Positioned(
              left: 16,
              top: 8,
              child: CustomBackButton(
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para construir uma linha de informação
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}