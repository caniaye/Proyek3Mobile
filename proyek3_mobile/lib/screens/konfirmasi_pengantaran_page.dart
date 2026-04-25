import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class KonfirmasiPengantaranPage extends StatelessWidget {
  const KonfirmasiPengantaranPage({super.key});

  @override
  Widget build(BuildContext context) {

    final now = DateTime.now();
    final tanggal = DateFormat('dd MMMM yyyy').format(now);
    final jam = DateFormat('HH:mm').format(now);

    return Scaffold(
      backgroundColor: const Color(0xFFC8E8E4),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 150),

            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: 360,
                  padding: const EdgeInsets.fromLTRB(26, 70, 26, 34),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F6F4),
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Pengantaran Berhasil !',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF234F63),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tanggal,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF234F63),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            jam,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF234F63),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF0F0),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Text(
                          'Mohon Pastikan Pesanan Benar Sebelum Mengantar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF7A8A8E),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2FA4B5),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          child: const Text(
                            'Lihat Foto',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // 🔥 BAGIAN YANG SUDAH DITAMBAHIN CENTANG
                Positioned(
                  top: -50,
                  child: Container(
                    width: 100,
                    height: 100,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFA8DE89),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            _buildBottomNav(context),

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 34),
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
            onTap: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
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