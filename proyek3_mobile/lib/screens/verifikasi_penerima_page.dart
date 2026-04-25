import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'konfirmasi_pengantaran_page.dart';

class VerifikasiPenerimaPage extends StatefulWidget {
  const VerifikasiPenerimaPage({super.key});

  @override
  State<VerifikasiPenerimaPage> createState() =>
      _VerifikasiPenerimaPageState();
}

class _VerifikasiPenerimaPageState extends State<VerifikasiPenerimaPage> {
  File? fotoPenerima;

  Future<void> ambilFoto() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        fotoPenerima = File(image.path);
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
            // HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, size: 30),
                    color: const Color(0xFF24576A),
                    onPressed: () {
                      Navigator.pop(context);
                    },
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

            // AREA KAMERA
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

                    // TEXT
                    Positioned(
                      bottom: 95,
                      left: 0,
                      right: 0,
                      child: Text(
                        fotoPenerima == null
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

                    // BUTTON (SUDAH DIPERBAIKI)
                    Positioned(
                      bottom: 40,
                      left: 40,
                      right: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          await ambilFoto();

                          if (fotoPenerima != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const KonfirmasiPengantaranPage(),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3498B5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          fotoPenerima == null ? "Ambil Foto" : "Foto Ulang",
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