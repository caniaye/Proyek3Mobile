import 'package:flutter/material.dart';
import 'daftar_pengantaran_page.dart';

class DashboardKurirPage extends StatelessWidget {
  final Map<String, dynamic> kurirData;

  const DashboardKurirPage({
    super.key,
    required this.kurirData,
  });

  @override
  Widget build(BuildContext context) {
    final String namaKurir = kurirData['nama']?.toString() ?? 'Kurir';
    final String kodeKurir = kurirData['kode']?.toString() ?? '';

    return Scaffold(
      backgroundColor: const Color(0xFFC7E0E0),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 28, 28, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Datang, ${_getFirstName(namaKurir)}!',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF234F63),
                        ),
                      ),
                      const SizedBox(height: 28),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(22, 18, 22, 26),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F6F4),
                          borderRadius: BorderRadius.circular(34),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                _buildProfileAvatarByKode(kodeKurir),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 26,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2FA4B5),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: const Text(
                                    'Online',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 26),

                            _buildInfoCard(
                              icon: Icons.local_shipping_rounded,
                              title: 'Tugas Hari Ini:',
                              subtitle: '5 Tugas Hari Ini',
                              iconColor: const Color(0xFF1499AD),
                            ),

                            const SizedBox(height: 24),

                            _buildMenuCard(
                              icon: Icons.inventory_2_outlined,
                              title: 'Daftar Pengantaran',
                              subtitle: '5 Tugas Hari Ini',
                              isActive: true,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DaftarPengantaranPage(
                                      kurirData: kurirData,
                                    ),
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: 24),

                            _buildMenuCard(
                              icon: Icons.access_time_rounded,
                              title: 'Riwayat',
                              subtitle: '',
                              isActive: false,
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Halaman Riwayat nanti dibuat'),
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: 24),

                            _buildMenuCard(
                              icon: Icons.account_circle_outlined,
                              title: 'Profil',
                              subtitle: '',
                              isActive: false,
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Halaman Profil nanti dibuat'),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            _buildBottomNav(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAvatarByKode(String kodeKurir) {
    String? imagePath;

    if (kodeKurir == 'KUR001') {
      imagePath = 'assets/images/Ghinaa.jpg';
    } else if (kodeKurir == 'KUR002') {
      imagePath = 'assets/images/vio.jpg';
    } else if (kodeKurir == 'KUR003') {
      imagePath = 'assets/images/Cania.jpg';
    }

    if (imagePath != null) {
      return CircleAvatar(
        radius: 38,
        backgroundColor: Colors.white,
        child: ClipOval(
          child: Image.asset(
            imagePath,
            width: 76,
            height: 76,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return const CircleAvatar(
      radius: 38,
      backgroundColor: Colors.white,
      child: Icon(
        Icons.person,
        size: 42,
        color: Color(0xFF2F89C3),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFD7EFF3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF234F63),
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF234F63),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    final Color bgColor =
        isActive ? const Color(0xFF2FA4B5) : const Color(0xFFEAF0F0);
    final Color textColor =
        isActive ? Colors.white : const Color(0xFF234F63);

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
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
            Icon(icon, color: textColor, size: 34),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 15,
                      color: textColor,
                    ),
                  ),
              ],
            ),
            const Spacer(),
            Icon(Icons.chevron_right, color: textColor),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(34, 0, 34, 28),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F1F1),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _BottomNavItem(
            icon: Icons.home_rounded,
            label: 'Daftar Pengantaran',
            selected: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DaftarPengantaranPage(
                    kurirData: kurirData,
                  ),
                ),
              );
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

  String _getFirstName(String fullName) {
    if (fullName.trim().isEmpty) return 'Kurir';
    return fullName.split(' ').first;
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