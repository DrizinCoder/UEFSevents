import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:pdfx/pdfx.dart';
import 'package:viveri/custom_back_button.dart';
import 'dart:html' as html;

class PDFViewerPage extends StatefulWidget {
  final String? filePath;
  final Uint8List? fileBytes;
  final String fileName;
  final bool isWeb;

  const PDFViewerPage({
    Key? key,
    this.filePath,
    this.fileBytes,
    required this.fileName,
    required this.isWeb,
  }) : super(key: key);

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadPDF();
  }

  Future<void> _loadPDF() async {
    try {
      // Debug para verificar os dados
      if (widget.isWeb) {
        print('Web PDF - Bytes length: ${widget.fileBytes?.length}');
        print('Web PDF - File name: ${widget.fileName}');
      } else {
        print('Mobile PDF - File path: ${widget.filePath}');
        print('Mobile PDF - File name: ${widget.fileName}');
      }
      
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Erro ao carregar PDF: $e');
      setState(() {
        isLoading = false;
        errorMessage = 'Erro ao carregar o PDF: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD3E0D1),
      body: SafeArea(
        child: Stack(
          children: [
            // Conteúdo principal
            Column(
              children: [
                // Header fixo
                Container(
                  height: 60,
                  color: const Color(0xFF425C44),
                  child: const Center(
                    child: Text(
                      'Documento',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Área do PDF
                Expanded(
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : errorMessage != null
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.error, size: 64, color: Colors.red),
                                  const SizedBox(height: 16),
                                  Text(
                                    errorMessage!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            )
                          : widget.isWeb
                              ? _buildWebPDFViewer()
                              : _buildMobilePDFViewer(),
                ),
              ],
            ),
            // Botão de voltar posicionado sobre tudo
            Positioned(
              left: 16,
              top: 8,
              child: CustomBackButton(
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWebPDFViewer() {
    if (widget.fileBytes == null) {
      return const Center(
        child: Text('Erro: Dados do PDF não encontrados'),
      );
    }
    
    print('Construindo visualizador web com ${widget.fileBytes!.length} bytes');
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.picture_as_pdf,
            size: 100,
            color: Colors.red,
          ),
          const SizedBox(height: 24),
          Text(
            widget.fileName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Tamanho: ${(widget.fileBytes!.length / 1024).toStringAsFixed(1)} KB',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => _downloadPDF(),
            icon: const Icon(Icons.download),
            label: const Text('Baixar PDF'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF425C44),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Clique em "Baixar PDF" para salvar o arquivo',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _downloadPDF() {
    if (widget.fileBytes != null) {
      final blob = html.Blob([widget.fileBytes!]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', widget.fileName);
      anchor.click();
      html.Url.revokeObjectUrl(url);
    }
  }

  Widget _buildMobilePDFViewer() {
    if (widget.filePath == null) {
      return const Center(
        child: Text('Erro: Caminho do PDF não encontrado'),
      );
    }
    // Usando Pdfx para abrir PDF local
    final pdfController = PdfController(
      document: PdfDocument.openFile(widget.filePath!),
    );
    return PdfView(
      controller: pdfController,
      onDocumentError: (error) {
        print('Erro no PDF mobile: $error');
        setState(() {
          errorMessage = 'Erro ao carregar PDF: $error';
        });
      },
    );
  }
} 