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
    final String kurirId =
        kurir['id']?.toString() ?? kurir['kode_kurir']?.toString() ?? '';

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
                            grouped.putIfAbsent(tanggal, () => []);
                            grouped[tanggal]!.add(item);
                          }

                          return ListView(
                            children: grouped.entries.map((entry) {
                              return _buildDateSection(
                                context,
                                entry.key,
                                entry.value,
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
              child: _buildBottomNav(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSection(
    BuildContext context,
    String tanggal,
    List<dynamic> items,
  ) {
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
        ...items.map((item) {
          final data = Map<String, dynamic>.from(item);

          return _buildItem(
            context: context,
            data: data,
            nama: data['nama_penerima']?.toString() ?? '-',
            alamat: data['alamat']?.toString() ?? '-',
            status: data['status']?.toString() ?? '-',
          );
        }),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildItem({
    required BuildContext context,
    required Map<String, dynamic> data,
    required String nama,
    required String alamat,
    required String status,
  }) {
    final bool berhasil = status.toLowerCase() == 'berhasil';

    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailRiwayatPage(data: data),
          ),
        );
      },
      child: Container(
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
                Icons.home_rounded,
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
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
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
            Icons.home_rounded,
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
            Icons.receipt_long_rounded,
            "Riwayat",
            true,
            onTap: () {},
          ),
          _navItem(
            Icons.account_circle_outlined,
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

class DetailRiwayatPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailRiwayatPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final String nama = data['nama_penerima']?.toString() ?? '-';
    final String alamat = data['alamat']?.toString() ?? '-';
    final String noHp = data['no_hp']?.toString() ?? '-';
    final String status = data['status']?.toString() ?? '-';
    final String resi = data['resi']?.toString() ?? '-';
    final String tanggal = data['tanggal']?.toString() ?? '-';
    final String waktuVerifikasi =
        data['waktu_verifikasi']?.toString() ?? '-';
    final String? fotoVerifikasi = data['foto_verifikasi']?.toString();

    final List<dynamic> rawItems = data['items'] is List ? data['items'] : [];

    return Scaffold(
      backgroundColor: const Color(0xFFCFE8E6),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
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
                  const Expanded(
                    child: Text(
                      "Detail Riwayat",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF174B5B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 28),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.88),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _headerCard(nama, alamat),
                      const SizedBox(height: 18),
                      _sectionTitle('Informasi Penerima'),
                      _infoRow('Nama', nama),
                      _infoRow('Alamat', alamat),
                      _infoRow('No HP', noHp),
                      const SizedBox(height: 18),
                      _sectionTitle('Informasi Pengantaran'),
                      _infoRow('Resi', resi),
                      _infoRow('Tanggal', tanggal),
                      _infoRow('Waktu Verifikasi', waktuVerifikasi),
                      _infoRow('Status', _statusLabel(status)),
                      const SizedBox(height: 18),
                      _sectionTitle('Pesanan'),
                      if (rawItems.isEmpty)
                        const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            'Tidak ada item pesanan',
                            style: TextStyle(
                              color: Color(0xFF7A8A8E),
                            ),
                          ),
                        )
                      else
                        ...rawItems.map((item) {
                          final map = Map<String, dynamic>.from(item);
                          return _itemPesanan(map);
                        }),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: fotoVerifikasi == null ||
                                  fotoVerifikasi.isEmpty ||
                                  fotoVerifikasi == 'null'
                              ? null
                              : () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LihatFotoBuktiPage(
                                        fotoUrl: fotoVerifikasi,
                                      ),
                                    ),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2FA4B5),
                            disabledBackgroundColor: const Color(0xFFDCEDEA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Lihat Foto Bukti',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerCard(String nama, String alamat) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3F2),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundColor: Color(0xFFBFE0E5),
            child: Icon(
              Icons.home_rounded,
              color: Color(0xFF2497B8),
              size: 34,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF174B5B),
                  ),
                ),
                Text(
                  alamat,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF174B5B),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF174B5B),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Text(
            ': ',
            style: TextStyle(
              color: Color(0xFF174B5B),
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF5D7078),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemPesanan(Map<String, dynamic> item) {
    final String namaItem = item['nama']?.toString() ??
        '${item['qty'] ?? 0} X GAS ${item['jenis_tabung'] ?? '-'}';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3F2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.local_shipping_rounded,
            color: Color(0xFF2497B8),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              namaItem,
              style: const TextStyle(
                color: Color(0xFF174B5B),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'belum_dikirim':
        return 'Belum Dikirim';
      case 'dalam_perjalanan':
        return 'Dalam Perjalanan';
      case 'berhasil':
        return 'Berhasil';
      case 'dibatalkan':
        return 'Dibatalkan';
      default:
        return status;
    }
  }
}

class LihatFotoBuktiPage extends StatelessWidget {
  final String fotoUrl;

  const LihatFotoBuktiPage({
    super.key,
    required this.fotoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCFE8E6),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
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
                    "Foto Bukti",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF174B5B),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    fotoUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Padding(
                        padding: EdgeInsets.all(30),
                        child: Text(
                          'Gagal memuat foto bukti',
                          style: TextStyle(
                            color: Color(0xFF174B5B),
                            fontSize: 16,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}