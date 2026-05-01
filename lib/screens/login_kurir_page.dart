import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'dashboard_kurir_page.dart';

class LoginKurirPage extends StatefulWidget {
  const LoginKurirPage({super.key});

  @override
  State<LoginKurirPage> createState() => _LoginKurirPageState();
}

class _LoginKurirPageState extends State<LoginKurirPage> {
  // =========================
  // CONTROLLER TARUH DI SINI
  // =========================
  final TextEditingController kodeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordHidden = true;
  bool isLoading = false;

  @override
  void dispose() {
    kodeController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // =========================
  // FUNCTION LOGIN TARUH DI SINI
  // =========================
  Future<void> handleLogin() async {
    final kode = kodeController.text.trim();
    final password = passwordController.text.trim();

    if (kode.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ID Kurir dan Password wajib diisi'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final result = await ApiService.loginKurir(
        kode: kode,
        password: password,
      );

      if (!mounted) return;

      if (result['status'] == true) {
      final Map<String, dynamic> kurirData = result['data'];

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(result['message'] ?? 'Login berhasil'),
    ),
  );

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => DashboardKurirPage(
        kurirData: kurirData,
      ),
    ),
  );

        // NANTI PINDAH HALAMAN DI SINI
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const DashboardPage()),
        // );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Login gagal'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
        ),
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
      backgroundColor: const Color(0xFFC7E0E0),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Login Kurir',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF234F63),
                  ),
                ),
                const SizedBox(height: 28),

                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 35,
                        vertical: 70,
                      ),
                      padding: const EdgeInsets.fromLTRB(18, 110, 18, 30),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F6F4),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildInputField(
                            controller: kodeController,
                            hintText: 'ID Kurir',
                            prefixIcon: Icons.mail_outline,
                            obscureText: false,
                          ),
                          const SizedBox(height: 20),
                          _buildInputField(
                            controller: passwordController,
                            hintText: 'Password',
                            prefixIcon: Icons.lock_outline,
                            obscureText: isPasswordHidden,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordHidden = !isPasswordHidden;
                                });
                              },
                              icon: Icon(
                                isPasswordHidden
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 38),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: isLoading ? null : handleLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2F89C3),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.5,
                                      ),
                                    )
                                  : const Text(
                                      'LOGIN',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Positioned(
                      top: 0,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFF4F6F4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/Logo Berdiri.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.local_shipping,
                                  size: 70,
                                  color: Color(0xFF2F89C3),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    required bool obscureText,
    Widget? suffixIcon,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFB8B8B8),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF444444),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 16,
            color: Color(0xFF888888),
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.black,
            size: 22,
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}