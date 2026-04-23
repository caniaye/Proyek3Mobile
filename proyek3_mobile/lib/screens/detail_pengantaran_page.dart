import 'package:flutter/material.dart';

class DetailPengantaranPage extends StatefulWidget {
  final Map<String, dynamic> kurirData;
  final Map<String, dynamic> pengantaranData;

  const DetailPengantaranPage({
    super.key,
    required this.kurirData,
    required this.pengantaranData,
  });

  @override
  State<DetailPengantaranPage> createState() => _DetailPengantaranPageState();
}

class _DetailPengantaranPageState extends State<DetailPengantaranPage> {
  bool isPelangganExpanded = false;
  bool isPesananExpanded = true;

  @override
  Widget build(BuildContext context) {
    final String nama = widget.pengantaranData['nama']?.toString() ?? 'Pelanggan';
    final String alamat = widget.pengantaranData['alamat']?.toString() ?? '-';
    final String noHp = widget.pengantaranData['no_hp']?.toString() ?? '081234567890';
    final String catatan = widget.pengantaranData['catatan']?.toString() ??
        'Mohon Pastikan Pesanan Benar Sebelum Mengantar';

    final List<Map<String, dynamic>> items =
        (widget.pengantaranData['items'] as List<dynamic>? ?? [])
            .map((e) => Map<String, dynamic>.from(e as Map))
            .toList();

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
                      'Detail Pengantaran',
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(18, 22, 18, 18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F6F4),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAlamatCard(
                        nama: nama,
                        alamat: alamat,
                        noHp: noHp,
                      ),
                      const SizedBox(height: 14),

                      const Text(
                        'Pesanan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF234F63),
                        ),
                      ),
                      const SizedBox(height: 8),

                      _buildPesananCard(items),

                      const SizedBox(height: 18),

                      const Text(
                        'Catatan Untuk Kurir',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF234F63),
                        ),
                      ),
                      const SizedBox(height: 8),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF0F0),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          catatan,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF7A8A8E),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Mulai Pengantaran diklik'),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2FA4B5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
                          ),
                          child: const Text(
                            'Mulai Pengantaran',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Nanti lanjut ke Verifikasi Penerima'),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEAF0F0),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Verifikasi Penerima',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF234F63),
                            ),
                          ),
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

  Widget _buildAlamatCard({
    required String nama,
    required String alamat,
    required String noHp,
  }) {
    return Container(
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
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () {
              setState(() {
                isPelangganExpanded = !isPelangganExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                          maxLines: isPelangganExpanded ? null : 2,
                          overflow: isPelangganExpanded
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF5D7078),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Icon(
                    isPelangganExpanded
                        ? Icons.keyboard_arrow_down_rounded
                        : Icons.chevron_right_rounded,
                    color: const Color(0xFF8CA3AA),
                    size: 32,
                  ),
                ],
              ),
            ),
          ),

          if (isPelangganExpanded) ...[
            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFC8D7DB),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailInfoRow('Nama', nama),
                  const SizedBox(height: 8),
                  _buildDetailInfoRow('Alamat', alamat),
                  const SizedBox(height: 8),
                  _buildDetailInfoRow('No HP', noHp),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 58,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF234F63),
            ),
          ),
        ),
        const Text(
          ': ',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF234F63),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF5D7078),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPesananCard(List<Map<String, dynamic>> items) {
    final List<Map<String, dynamic>> displayedItems =
        isPesananExpanded ? items : (items.isNotEmpty ? [items.first] : []);

    return Container(
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
      child: Column(
        children: [
          for (int i = 0; i < displayedItems.length; i++) ...[
            _buildPesananItem(
              namaItem: displayedItems[i]['nama']?.toString() ?? '-',
              imagePath: displayedItems[i]['imagePath']?.toString(),
              showArrow: i == 0,
            ),
            if (i != displayedItems.length - 1)
              const Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFC8D7DB),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildPesananItem({
    required String namaItem,
    required String? imagePath,
    required bool showArrow,
  }) {
    return InkWell(
      onTap: showArrow
          ? () {
              setState(() {
                isPesananExpanded = !isPesananExpanded;
              });
            }
          : null,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(21),
              ),
              child: ClipOval(
                child: imagePath != null
                    ? Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.local_shipping,
                          color: Color(0xFF2F89C3),
                        ),
                      )
                    : const Icon(
                        Icons.local_shipping,
                        color: Color(0xFF2F89C3),
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                namaItem,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF234F63),
                ),
              ),
            ),
            if (showArrow)
              Icon(
                isPesananExpanded
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                color: const Color(0xFF8CA3AA),
                size: 28,
              ),
          ],
        ),
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
            onTap: () => Navigator.pop(context),
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