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
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              _buildLanguagesExplored(),
              const SizedBox(height: 20),
              _buildPetCollection(),
              const SizedBox(height: 20),
              _buildAccountSettings(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ── HEADER ──
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2AE2F6),
            Color(0xFFAEEEF8),
            Color(0xFFDDF3FD),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Title (rata kiri) ──
          Padding(
            padding: const EdgeInsets.only(
                top: 16, left: 16, right: 16, bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Your Profile',
                  style: TextStyle(
                    color: Color(0xFF02212A),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Track your learning progress and manage your account',
                  style: TextStyle(
                    color: Color(0xFF334155),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── Avatar (tengah) ──
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    // Avatar circle dengan border putih
                    Container(
                      width: 108,
                      height: 108,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x33000000),
                            blurRadius: 16,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          AppAssets.defaultAvatar,
                          width: 108,
                          height: 108,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: const Color(0xFFFFD8C4),
                            child: const Icon(
                              Icons.person,
                              size: 54,
                              color: Color(0xFF6366F1),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Edit button
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x33000000),
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 14,
                          color: Color(0xFF598EA7),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Jhon',
                  style: TextStyle(
                    color: Color(0xFF011E2F),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),

          // ── Wave bottom decorator ──
          ClipPath(
            clipper: _BottomWaveClipper(),
            child: Container(
              height: 36,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFAEEEF8),
                    Color(0xFFF5F7FA),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── LANGUAGES EXPLORED ──
  Widget _buildLanguagesExplored() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Languages Explored',
            style: TextStyle(
              color: Color(0xFF011E2F),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.map_rounded,
                  iconColor: const Color(0xFF3B82F6),
                  iconBg: const Color(0xFFDBEAFE),
                  label: 'Region',
                  value: '10',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _StatCard(
                  icon: Icons.star_rounded,
                  iconColor: const Color(0xFFF59E0B),
                  iconBg: const Color(0xFFFEF3C7),
                  label: 'Master',
                  value: '5',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _StatCard(
                  icon: Icons.menu_book_rounded,
                  iconColor: const Color(0xFF10B981),
                  iconBg: const Color(0xFFD1FAE5),
                  label: 'Words',
                  value: '2354',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── PET COLLECTION ──
  Widget _buildPetCollection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Pet Collection',
                style: TextStyle(
                  color: Color(0xFF011E2F),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'See All',
                  style: TextStyle(
                    color: Color(0xFF598EA7),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _PetCard(
                  name: 'Kaba The Buffalo',
                  level: 'Lvl. 12',
                  progress: 0.7,
                  petAsset: AppAssets.petBaby,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _PetCard(
                  name: 'Oru The Borneo',
                  level: 'Lvl. 12',
                  progress: 0.65,
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Account & Settings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF011E2F),
            ),
          ),
          const SizedBox(height: 14),
          _SettingsTile(
            title: 'Akun',
            icon: Icons.person_rounded,
            bgColor: const Color(0xFFE6F3FB),
            iconBgColor: const Color(0xFFD3E4FF),
            iconColor: const Color(0xFF4338CA),
            onTap: () {},
          ),
          const SizedBox(height: 10),
          _SettingsTile(
            title: 'Keamanan',
            icon: Icons.shield_rounded,
            bgColor: const Color(0xFFF4F0FB),
            iconBgColor: const Color(0xFFFFEDD5),
            iconColor: const Color(0xFFEA580C),
            onTap: () {},
          ),
          const SizedBox(height: 10),
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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: const Text('Keluar?',
            style: TextStyle(
                fontWeight: FontWeight.w800, fontSize: 18)),
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
              // TODO: logout logic
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
// STAT CARD — pakai Icons bawaan (tidak perlu network)
// ═══════════════════════════════════════════
class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF011E2F),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// PET CARD — layout diperbaiki, pet image centered
// ═══════════════════════════════════════════
class _PetCard extends StatelessWidget {
  final String name;
  final String level;
  final double progress;
  final String petAsset;

  const _PetCard({
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
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Pet image + level badge ──
          Center(
            child: Column(
              children: [
                // Pet avatar background
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF7ED),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      petAsset,
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.pets_rounded,
                        size: 40,
                        color: Color(0xFFB0BEC5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                // Level badge di bawah image (bukan Positioned)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDEF4FE),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    level,
                    style: const TextStyle(
                      color: Color(0xFF598EA7),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // ── Pet name ──
          Text(
            name,
            style: const TextStyle(
              color: Color(0xFF011E2F),
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 8),

          // ── Progress ──
          const Text(
            'Progress',
            style: TextStyle(
              color: Color(0xFF64748B),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),

          // Progress bar dengan ClipRRect agar corner benar
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Stack(
              children: [
                // Track
                Container(
                  height: 10,
                  width: double.infinity,
                  color: const Color(0xFFF1F5F9),
                ),
                // Fill
                FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFF9F1C),
                          Color(0xFFFFCA6E),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x66FF9F1C),
                          blurRadius: 8,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
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
            const SizedBox(width: 14),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
            const Spacer(),
            const Icon(Icons.chevron_right,
                color: Color(0xFF94A3B8), size: 20),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// BOTTOM WAVE CLIPPER
// ═══════════════════════════════════════════
class _BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height,
      size.width * 0.5,
      size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      0,
      size.width,
      size.height * 0.6,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
