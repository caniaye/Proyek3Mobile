import 'package:flutter/material.dart';
import 'package:proyek3_mobile/screens/profil_kurir_page.dart';
import 'package:proyek3_mobile/screens/riwayat_page.dart';

import '../services/api_service.dart';
import 'detail_pengantaran_page.dart';

class DaftarPengantaranPage extends StatefulWidget {
  final Map<String, dynamic> kurirData;

  const DaftarPengantaranPage({
    super.key,
    required this.kurirData,
  });

  @override
  State<DaftarPengantaranPage> createState() => _DaftarPengantaranPageState();
}

class _DaftarPengantaranPageState extends State<DaftarPengantaranPage> {
  bool isLoading = true;
  String? errorMessage;
  List<dynamic> daftarPengantaran = [];

  @override
  void initState() {
    super.initState();
    loadPengantaran();
  }

  Future<void> loadPengantaran() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final kurirId = widget.kurirData['id'].toString();
      final result = await ApiService.getPengantaranKurir(kurirId);

      if (!mounted) return;

      setState(() {
        daftarPengantaran = result;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC7E0E0),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 26, 20, 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF234F63),
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Expanded(
                    child: Text(
                      'Daftar Pengantaran',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF234F63),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                padding: const EdgeInsets.fromLTRB(18, 22, 18, 18),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F6F4),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: _buildContent(),
              ),
            ),
            _buildBottomNav(context),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF2FA4B5),
        ),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 48,
                color: Color(0xFF234F63),
              ),
              const SizedBox(height: 12),
              const Text(
                'Gagal mengambil data pengantaran',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF234F63),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF5D7078),
                ),
              ),
              const SizedBox(height: 14),
              ElevatedButton(
                onPressed: loadPengantaran,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2FA4B5),
                ),
                child: const Text(
                  'Coba Lagi',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (daftarPengantaran.isEmpty) {
      return RefreshIndicator(
        onRefresh: loadPengantaran,
        color: const Color(0xFF2FA4B5),
        child: ListView(
          children: const [
            SizedBox(height: 180),
            Center(
              child: Text(
                'Belum ada pengantaran',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF234F63),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: loadPengantaran,
      color: const Color(0xFF2FA4B5),
      child: ListView.separated(
        itemCount: daftarPengantaran.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final item = Map<String, dynamic>.from(daftarPengantaran[index]);

          return _buildPengantaranCard(
            context: context,
            pengantaranData: item,
          );
        },
      ),
    );
  }

  Widget _buildPengantaranCard({
    required BuildContext context,
    required Map<String, dynamic> pengantaranData,
  }) {
    final pelanggan = Map<String, dynamic>.from(
      pengantaranData['pelanggan'] ?? {},
    );

    final pesanan = Map<String, dynamic>.from(
      pengantaranData['pesanan'] ?? {},
    );

    final String nama = pelanggan['nama']?.toString() ?? '-';
    final String alamat = pelanggan['alamat']?.toString() ?? '-';
    final String kodePesanan = pesanan['kode']?.toString() ?? '';

    final String status = pengantaranData['status']?.toString() ?? '-';
    final String statusLabel =
        pengantaranData['status_label']?.toString() ?? _statusLabel(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF0F0),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFD7EFF3),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.home_rounded,
              color: Color(0xFF2F89C3),
              size: 30,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF234F63),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  alamat,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF5D7078),
                  ),
                ),
                if (kodePesanan.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    kodePesanan,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF829CA5),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _statusColor(status),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  statusLabel,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF234F63),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPengantaranPage(
                        kurirData: widget.kurirData,
                        pengantaranData: pengantaranData,
                      ),
                    ),
                  ).then((_) {
                    loadPengantaran();
                  });
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD7EFF3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Detail',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF234F63),
                        ),
                      ),
                      SizedBox(width: 2),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 18,
                        color: Color(0xFF234F63),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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

  Color _statusColor(String status) {
    switch (status) {
      case 'belum_dikirim':
        return const Color(0xFFF4D35E);
      case 'dalam_perjalanan':
        return const Color(0xFF8FD3D1);
      case 'berhasil':
        return const Color(0xFF9BDE7E);
      case 'dibatalkan':
        return const Color(0xFFFF8A8A);
      default:
        return const Color(0xFFEAF0F0);
    }
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(34, 18, 34, 28),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F1F1),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: const Color(0xFFA9BCBE),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _BottomNavItem(
            icon: Icons.home_rounded,
            label: 'Daftar Pengantaran',
            selected: true,
            onTap: loadPengantaran,
          ),
          _BottomNavItem(
            icon: Icons.receipt_long_rounded,
            label: 'Riwayat',
            selected: false,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RiwayatPage(
                    kurir: widget.kurirData,
                  ),
                ),
              );
            },
          ),
          _BottomNavItem(
            icon: Icons.account_circle_outlined,
            label: 'Profil',
            selected: false,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilKurirPage(
                    kurir: widget.kurirData,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = const Color(0xFF2F89C3);
    final Color inactiveColor = const Color(0xFF829CA5);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 32,
              color: selected ? activeColor : inactiveColor,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: selected ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}