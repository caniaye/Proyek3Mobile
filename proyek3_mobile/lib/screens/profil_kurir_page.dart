import 'package:flutter/material.dart';
import 'login_kurir_page.dart';
import 'daftar_pengantaran_page.dart';
import 'riwayat_page.dart';

class ProfilKurirPage extends StatelessWidget {
  final Map<String, dynamic> kurir;

  const ProfilKurirPage({
    super.key,
    required this.kurir,
  });

  @override
  Widget build(BuildContext context) {
    final String nama = _getValue(kurir, [
      'nama',
      'nama_kurir',
      'name',
    ], 'Nama Kurir');

    final String kodeKurir = _getValue(kurir, [
      'kode',
      'kode_kurir',
    ], '');

    final String idKurir = kodeKurir.isNotEmpty
        ? kodeKurir
        : 'KUR${_getValue(kurir, ['id'], '0').padLeft(3, '0')}';

    return Scaffold(
      backgroundColor: const Color(0xFFCFE8E6),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Color(0xFF174B5B),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Profil Kurir',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF174B5B),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 110),
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(30, 60, 30, 32),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.92),
                            borderRadius: BorderRadius.circular(45),
                          ),
                          child: Column(
                            children: [
                              Text(
                                nama,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF174B5B),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'ID Kurir: $idKurir',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF174B5B),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 13),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDCEDEA),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'ID Kurir: $idKurir',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF174B5B),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 14),
                              SizedBox(
                                width: double.infinity,
                                height: 45,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFF47D8A),
                                    foregroundColor: const Color(0xFF8A2E3D),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginKurirPage(),
                                      ),
                                      (route) => false,
                                    );
                                  },
                                  icon: const Icon(Icons.logout),
                                  label: const Text(
                                    'Logout',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: -58,
                          child: _buildProfileAvatarByKode(idKurir),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 35,
              right: 35,
              bottom: 35,
              child: Container(
                height: 95,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.65),
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _bottomNavItem(
                      icon: Icons.home_rounded,
                      label: 'Daftar\nPengantaran',
                      active: false,
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
                    _bottomNavItem(
                      icon: Icons.receipt_long_rounded,
                      label: 'Riwayat',
                      active: false,
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RiwayatPage(
                              kurir: kurir,
                            ),
                          ),
                        );
                      },
                    ),
                    _bottomNavItem(
                      icon: Icons.account_circle_outlined,
                      label: 'Profil',
                      active: true,
                      onTap: () {},
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

  Widget _buildProfileAvatarByKode(String kodeKurir) {
    String imagePath = 'assets/images/vio.jpg';

    if (kodeKurir == 'KUR001') {
      imagePath = 'assets/images/Ghinaa.jpg';
    } else if (kodeKurir == 'KUR002') {
      imagePath = 'assets/images/vio.jpg';
    } else if (kodeKurir == 'KUR003') {
      imagePath = 'assets/images/Cania.jpg';
    }

    return CircleAvatar(
      radius: 58,
      backgroundColor: Colors.white,
      child: ClipOval(
        child: Image.asset(
          imagePath,
          width: 110,
          height: 110,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  static String _getValue(
    Map<String, dynamic> data,
    List<String> keys,
    String defaultValue,
  ) {
    for (final key in keys) {
      final value = data[key];
      if (value != null && value.toString().isNotEmpty) {
        return value.toString();
      }
    }
    return defaultValue;
  }

  Widget _bottomNavItem({
    required IconData icon,
    required String label,
    required bool active,
    required VoidCallback onTap,
  }) {
    final color = active ? const Color(0xFF2497B8) : const Color(0xFF7F9EAA);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 95,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 34, color: color),
            const SizedBox(height: 4),
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
