import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'daftar_pengantaran_page.dart';
import 'profil_kurir_page.dart';

class RiwayatPage extends StatelessWidget {
  final Map<String, dynamic> kurir;

  const RiwayatPage({
    super.key,
    required this.kurir,
  });

  @override
  Widget build(BuildContext context) {
    final String kurirId = kurir['id']?.toString() ??
        kurir['kode_kurir']?.toString() ??
        '';

    return Scaffold(
      backgroundColor: const Color(0xFFCFE8E6),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 28,
                          color: Color(0xFF174B5B),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Riwayat Pengantaran",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF174B5B),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: FutureBuilder<List<dynamic>>(
                        future: ApiService.getRiwayatKurir(kurirId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.hasError) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  "Gagal mengambil data riwayat\n\n${snapshot.error}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            );
                          }

                          final riwayat = snapshot.data ?? [];

                          if (riwayat.isEmpty) {
                            return const Center(
                              child: Text(
                                "Belum ada riwayat pengantaran",
                                style: TextStyle(color: Colors.grey),
                              ),
                            );
                          }

                          final Map<String, List<dynamic>> grouped = {};

                          for (final item in riwayat) {
                            final tanggal = item['tanggal'] ?? '-';

                            if (!grouped.containsKey(tanggal)) {
                              grouped[tanggal] = [];
                            }

                            grouped[tanggal]!.add(item);
                          }

                          return ListView(
                            children: grouped.entries.map((entry) {
                              return _buildDateSection(
                                entry.key,
                                entry.value.map((item) {
                                  return _buildItem(
                                    nama: item['nama_penerima'] ?? '-',
                                    alamat: item['alamat'] ?? '-',
                                    status: item['status'] ?? '-',
                                  );
                                }).toList(),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Container(
                height: 85,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: Colors.black12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _navItem(
                      Icons.home,
                      "Daftar\nPengantaran",
                      false,
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DaftarPengantaranPage(
                              kurirData: kurir,
                            ),
                          ),
                        );
                      },
                    ),
                    _navItem(
                      Icons.receipt,
                      "Riwayat",
                      true,
                      onTap: () {},
                    ),
                    _navItem(
                      Icons.person,
                      "Profil",
                      false,
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilKurirPage(
                              kurir: kurir,
                            ),
                          ),
                        );
                      },
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

  Widget _buildDateSection(String tanggal, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tanggal,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF174B5B),
          ),
        ),
        const SizedBox(height: 8),
        ...items,
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildItem({
    required String nama,
    required String alamat,
    required String status,
  }) {
    final bool berhasil = status.toLowerCase() == 'berhasil';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3F2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFFBFE0E5),
            child: Icon(
              Icons.home,
              color: Color(0xFF2497B8),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF174B5B),
                  ),
                ),
                Text(
                  alamat,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: berhasil ? Colors.green[300] : Colors.red[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              berhasil ? "Berhasil ✓" : "Gagal ✕",
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(
    IconData icon,
    String label,
    bool active, {
    required VoidCallback onTap,
  }) {
    final color = active ? const Color(0xFF2497B8) : Colors.grey;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 95,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: color),
            const SizedBox(height: 5),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: color),
            ),
          ],
        ),
      ),
    );
  }
}