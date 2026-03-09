import 'package:flutter/material.dart';
import 'package:lingupet/core/constants/app_assets.dart';

// ═══════════════════════════════════════════
// PROFILE SCREEN
// ═══════════════════════════════════════════
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFC),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            _buildLanguagesExplored(),
            const SizedBox(height: 24),
            _buildGuardianCollection(),
            const SizedBox(height: 24),
            _buildAccountSettings(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // ── HEADER ──
  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        // Background wave gradient
        ClipPath(
          clipper: _HeaderWaveClipper(),
          child: Container(
            height: 320,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF2AE2F6),
                  Color(0xFFDDF3FD),
                ],
              ),
            ),
          ),
        ),

        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 24.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Profile',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1E293B)),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Track your learning progress and manage your account',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF334155)),
                ),
                const SizedBox(height: 30),

                // ── AVATAR ──
                Center(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: const BoxDecoration(
                              color: Color(0xFF6366F1),
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: CircleAvatar(
                              backgroundColor: const Color(0xFFFFD8C4),
                              backgroundImage: AssetImage(
                                  AppAssets.defaultAvatar),
                              onBackgroundImageError: (_, __) {},
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2))
                                ],
                              ),
                              child: const Icon(Icons.edit,
                                  size: 16, color: Color(0xFF475569)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Jhon',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── LANGUAGES EXPLORED ──
  Widget _buildLanguagesExplored() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Languages Explored',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  child: _StatCard(
                      icon: Icons.menu_book_rounded,
                      title: 'Region',
                      value: '10')),
              const SizedBox(width: 12),
              Expanded(
                  child: _StatCard(
                      icon: Icons.star_rounded,
                      title: 'Master',
                      value: '5')),
              const SizedBox(width: 12),
              Expanded(
                  child: _StatCard(
                      icon: Icons.assignment_rounded,
                      title: 'Words',
                      value: '2354')),
            ],
          ),
        ],
      ),
    );
  }

  // ── GUARDIAN COLLECTION ──
  Widget _buildGuardianCollection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Guardian Collection',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87)),
              GestureDetector(
                onTap: () {},
                child: const Text('See All',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3B82F6),
                        decoration: TextDecoration.underline)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _GuardianCard(
                  name: 'Kaba The Buffalo',
                  level: 'Lvl. 12',
                  progress: 0.7,
                  // Ganti ke AppAssets.petKaba jika asset tersedia
                  petAsset: AppAssets.petBaby,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _GuardianCard(
                  name: 'Oru The Borneo',
                  level: 'Lvl. 12',
                  progress: 0.65,
                  // Ganti ke AppAssets.petOru jika asset tersedia
                  petAsset: AppAssets.petBaby,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── ACCOUNT & SETTINGS ──
  Widget _buildAccountSettings(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Account & Settings',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87)),
          const SizedBox(height: 16),
          _SettingsTile(
            title: 'Akun',
            icon: Icons.person,
            bgColor: const Color(0xFFE6F3FB),
            iconBgColor: const Color(0xFFD3E4FF),
            iconColor: const Color(0xFF4338CA),
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _SettingsTile(
            title: 'Keamanan',
            icon: Icons.shield,
            bgColor: const Color(0xFFF4F0FB),
            iconBgColor: const Color(0xFFFFEDD5),
            iconColor: const Color(0xFFEA580C),
            onTap: () {},
          ),
          const SizedBox(height: 12),
          // ── LOGOUT ──
          _SettingsTile(
            title: 'Keluar',
            icon: Icons.logout_rounded,
            bgColor: const Color(0xFFFFF0F0),
            iconBgColor: const Color(0xFFFFDDDD),
            iconColor: const Color(0xFFE53935),
            onTap: () => _showLogoutDialog(context),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Keluar?',
            style:
                TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
        content: const Text('Apakah kamu yakin ingin keluar?',
            style: TextStyle(color: Color(0xFF4A5568))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal',
                style: TextStyle(color: Color(0xFF94A3B8))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: logout logic / navigate to login
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// STAT CARD
// ═══════════════════════════════════════════
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 14, color: const Color(0xFFF97316)),
              const SizedBox(width: 4),
              Text(title,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF475569))),
            ],
          ),
          const SizedBox(height: 8),
          Text(value,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// GUARDIAN CARD
// ═══════════════════════════════════════════
class _GuardianCard extends StatelessWidget {
  final String name;
  final String level;
  final double progress;
  final String petAsset;

  const _GuardianCard({
    required this.name,
    required this.level,
    required this.progress,
    required this.petAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: const Color(0xFFFFF0E6),
                  child: ClipOval(
                    child: Image.asset(
                      petAsset,
                      width: 80, height: 80,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(
                          Icons.pets_rounded,
                          size: 36,
                          color: Color(0xFFB0BEC5)),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -8, left: 0, right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDBEAFE),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(level,
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2563EB))),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(name,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          const SizedBox(height: 8),
          const Text('Progress',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF475569))),
          const SizedBox(height: 6),
          // Progress bar
          Container(
            height: 12,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(6),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF9A826),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// SETTINGS TILE
// ═══════════════════════════════════════════
class _SettingsTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color bgColor;
  final Color iconBgColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.title,
    required this.icon,
    required this.bgColor,
    required this.iconBgColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 16),
            Text(title,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87)),
            const Spacer(),
            const Icon(Icons.chevron_right, color: Color(0xFF94A3B8)),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// HEADER WAVE CLIPPER
// ═══════════════════════════════════════════
class _HeaderWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
        size.width * 0.25, size.height,
        size.width * 0.5, size.height - 20);
    path.quadraticBezierTo(
        size.width * 0.75, size.height - 40,
        size.width, size.height - 15);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
