import 'package:flutter/material.dart';
import 'detail_pengantaran_page.dart';

class DaftarPengantaranPage extends StatelessWidget {
  final Map<String, dynamic> kurirData;

  const DaftarPengantaranPage({
    super.key,
    required this.kurirData,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> daftarPengantaran = [
      {
        'nama': 'Agus Setiawan',
        'alamat': 'Jl. Merdeka No. 123, RT/RW.08/01, Jakarta Pusat, DKI Jakarta',
        'no_hp': '082262235682',
        'status': 'Belum Dikirim',
        'statusColor': const Color(0xFFF4D35E),
        'catatan': 'Mohon Pastikan Pesanan Benar Sebelum Mengantar',
        'items': [
          {
            'nama': '1 X GAS 12 Kg',
            'imagePath': 'assets/images/Logo Berdiri.png',
          },
          {
            'nama': '5 X GAS 3 Kg',
            'imagePath': 'assets/images/Logo Berdiri.png',
          },
        ],
      },
      {
        'nama': 'Agus Setiawan',
        'alamat': 'Jl. Merdeka No. 123, Jakarta',
        'no_hp': '082198765432',
        'status': 'Dalam Perjalanan',
        'statusColor': const Color(0xFF8FD3D1),
        'catatan': 'Mohon Pastikan Pesanan Benar Sebelum Mengantar',
        'items': [
          {
            'nama': '2 X GAS 12 Kg',
            'imagePath': 'assets/images/Logo Berdiri.png',
          },
          {
            'nama': '10 X GAS 3 Kg',
            'imagePath': 'assets/images/Logo Berdiri.png',
          },
        ],
      },
    ];

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
                  const Text(
                    'Daftar Pengantaran',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF234F63),
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
                child: ListView.separated(
                  itemCount: daftarPengantaran.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final item = daftarPengantaran[index];
                    return _buildPengantaranCard(
                      context: context,
                      pengantaranData: item,
                    );
                  },
                ),
              ),
            ),

            _buildBottomNav(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPengantaranCard({
    required BuildContext context,
    required Map<String, dynamic> pengantaranData,
  }) {
    final String nama = pengantaranData['nama'] as String;
    final String alamat = pengantaranData['alamat'] as String;
    final String status = pengantaranData['status'] as String;
    final Color statusColor = pengantaranData['statusColor'] as Color;

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
                  color: statusColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  status,
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
                        kurirData: kurirData,
                        pengantaranData: pengantaranData,
                      ),
                    ),
                  );
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
            onTap: () {},
          ),
          _BottomNavItem(
            icon: Icons.receipt_long_rounded,
            label: 'Riwayat',
            selected: false,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Halaman Riwayat nanti dibuat')),
              );
            },
          ),
          _BottomNavItem(
            icon: Icons.account_circle_outlined,
            label: 'Profil',
            selected: false,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Halaman Profil nanti dibuat')),
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