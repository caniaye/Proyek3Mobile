import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/api_service.dart';
import 'konfirmasi_pengantaran_page.dart';

class VerifikasiPenerimaPage extends StatefulWidget {
  final int pengantaranId;
  final Map<String, dynamic> kurirData;

  const VerifikasiPenerimaPage({
    super.key,
    required this.pengantaranId,
    required this.kurirData,
  });

  @override
  State<VerifikasiPenerimaPage> createState() => _VerifikasiPenerimaPageState();
}

class _VerifikasiPenerimaPageState extends State<VerifikasiPenerimaPage> {
  File? fotoPenerima;
  bool isLoading = false;

  Future<void> ambilFotoDanVerifikasi() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image == null) return;

    setState(() {
      fotoPenerima = File(image.path);
      isLoading = true;
    });

    try {
      final result = await ApiService.verifikasiPengantaran(
        pengantaranId: widget.pengantaranId,
        foto: fotoPenerima!,
      );

      if (!mounted) return;

      final bool faceMatch = result['data']?['face_match'] == true;
      final String? fotoVerifikasi =
          result['data']?['foto_verifikasi']?.toString();

      if (faceMatch) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => KonfirmasiPengantaranPage(
              fotoVerifikasi: fotoVerifikasi,
              kurirData: widget.kurirData,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wajah tidak cocok')),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Verifikasi gagal: $e')),
      );
    } finally {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC8E8E4),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, size: 30),
                    color: const Color(0xFF24576A),
                    onPressed: isLoading ? null : () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Verifikasi Penerima",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF24576A),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 330,
              height: 520,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(28),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    fotoPenerima == null
                        ? Container(
                            color: Colors.black54,
                            child: const Center(
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 80,
                              ),
                            ),
                          )
                        : Image.file(
                            fotoPenerima!,
                            fit: BoxFit.cover,
                          ),
                    if (isLoading)
                      Container(
                        color: Colors.black45,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    Positioned(
                      bottom: 95,
                      left: 0,
                      right: 0,
                      child: Text(
                        isLoading
                            ? "Memproses Face\nRecognition..."
                            : fotoPenerima == null
                                ? "Arahkan Kamera Ke\nWajah Penerima"
                                : "Foto Penerima Berhasil\nDiambil",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      left: 40,
                      right: 40,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : ambilFotoDanVerifikasi,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3498B5),
                          disabledBackgroundColor: const Color(0xFF8BBAC7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          isLoading
                              ? "Memproses..."
                              : fotoPenerima == null
                                  ? "Ambil Foto"
                                  : "Foto Ulang",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}