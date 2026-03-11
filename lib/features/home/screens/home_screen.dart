import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lingupet/core/constants/app_assets.dart';
import 'package:lingupet/features/learn/screens/learn_screen.dart';
import 'package:lingupet/features/pets/screens/build_vocabulary_page.dart';
import 'package:lingupet/features/pets/screens/pet_detail_screen.dart';
import 'package:lingupet/features/profile/screens/profile_screen.dart';

// ═══════════════════════════════════════════
// HOME SCREEN
// ═══════════════════════════════════════════
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNav = 0;

  List<Widget> get _screens => [
        _HomeTab(
          onPetSeeAll: () => setState(() => _currentNav = 1),
          onLearnSeeAll: () => setState(() => _currentNav = 2),
          onQuickFeed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const BuildVocabularyPage()),
          ),
        ),
        const PetDetailScreen(),
        const LearnScreen(),
        const ProfileScreen(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Stack(
        children: [
          IndexedStack(
            index: _currentNav,
            children: _screens,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _BottomNav(
              current: _currentNav,
              onTap: (i) => setState(() => _currentNav = i),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// HOME TAB
// ═══════════════════════════════════════════
class _HomeTab extends StatelessWidget {
  final VoidCallback onPetSeeAll;
  final VoidCallback onLearnSeeAll;
  final VoidCallback onQuickFeed;

  const _HomeTab({
    required this.onPetSeeAll,
    required this.onLearnSeeAll,
    required this.onQuickFeed,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Stack(
            children: [
              ClipPath(
                clipper: _HeaderWaveClipper(),
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF42E0FF),
                        Color(0xFFE8F6FB),
                        Colors.white
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              ),
              const SafeArea(
                bottom: false,
                child: _TopBar(),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // ── Your Pet ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _SectionHeader(
              title: 'Your Pet',
              onSeeAll: onPetSeeAll,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _PetCard(onQuickFeed: onQuickFeed),
          ),

          const SizedBox(height: 32),

          // ── Learning Track ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _SectionHeader(
              title: 'Learning Track',
              onSeeAll: onLearnSeeAll,
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: _LearningTrackCard(
              percent: 0.70,
              color: Color(0xFFFFC107),
              language: 'Javanese',
              flag: '🇮🇩',
              region: 'West Sumatra, Indonesia',
              topic: 'Topic 2 : Javanese Etiquette 101.',
              note: '3 more words to unlock the next Topic',
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: _LearningTrackCard(
              percent: 0.50,
              color: Color(0xFFEF5350),
              language: 'Javanese',
              flag: '🇮🇩',
              region: 'West Sumatra, Indonesia',
              topic: 'Topic 2 : Javanese Etiquette 101.',
              note: '',
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// TOP BAR
// ═══════════════════════════════════════════
class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF42E0FF).withOpacity(0.4),
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                AppAssets.defaultAvatar,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFF8C9EFF),
                  child: const Icon(Icons.face, color: Colors.white, size: 28),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Welcome Back, Jhon',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF05354C),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Keeping the vibes alive, one word at a time.',
                  style: TextStyle(fontSize: 11, color: Color(0xFF05354C)),
                ),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_active_rounded,
              size: 20,
              color: Color(0xFF05354C),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// PET CARD
// ═══════════════════════════════════════════
class _PetCard extends StatelessWidget {
  final VoidCallback onQuickFeed;

  const _PetCard({required this.onQuickFeed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // ── Main Card ──
        Container(
          margin: const EdgeInsets.only(top: 30),
          padding: const EdgeInsets.fromLTRB(16, 70, 16, 20),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F9FB),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 140),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Kaba The Buffalo',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD6F3FA),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Lvl. 12',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6B8499),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: const Center(
                                child: Text('🇮🇩',
                                    style: TextStyle(fontSize: 16)),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Minang',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  'West Sumatra, Indonesia',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1A1A2E),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // ── Chat Bubble ──
              Padding(
                padding: const EdgeInsets.only(left: 100),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF05354C),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "I'm getting a bit hungry for some Minang words... care to feed me?",
                        style: TextStyle(
                            fontSize: 11, color: Colors.white, height: 1.4),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Positioned(
                      top: -6,
                      left: 20,
                      child: Transform.rotate(
                        angle: pi / 4,
                        child: Container(
                          width: 12,
                          height: 12,
                          color: const Color(0xFF05354C),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ── Stats Row ── ✅ FIX: icon sekarang diteruskan ke Row icon
              Row(
                children: const [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.apple,
                      iconColor: Color(0xFFF5A623),
                      label: 'Hunger',
                      percent: 0.85,
                      progressColor: Color(0xFFEF5350),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.favorite_border_rounded,
                      iconColor: Color(0xFFF5A623),
                      label: 'Happiness',
                      percent: 0.90,
                      progressColor: Color(0xFFEF5350),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.auto_awesome,
                      iconColor: Color(0xFF42E0FF),
                      label: 'Energy',
                      percent: 0.75,
                      progressColor: Color(0xFFB0BEC5),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ── Progress Bar ──
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Progress',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF05354C),
                    ),
                  ),
                  Text(
                    '75% to Next Evolution',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Stack(
                children: [
                  Container(
                    height: 14,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.75,
                    child: Container(
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF89B29),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ── Quick Feed Button ──
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: onQuickFeed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF89B29),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Quick Feed',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // ── Pet Image Overlap ──
        Positioned(
          top: -10,
          left: -10,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFFF6ED),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFF89B29).withOpacity(0.15),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),
              Image.asset(
                AppAssets.petBaby,
                width: 150,
                height: 150,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.pets,
                  size: 80,
                  color: Color(0xFFF89B29),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════
// STAT CARD ✅ FIX: icon parameter sekarang digunakan
// ═══════════════════════════════════════════
class _StatCard extends StatelessWidget {
  final IconData icon;       // ✅ Tambah parameter icon
  final Color iconColor;
  final String label;
  final double percent;
  final Color progressColor;

  const _StatCard({
    required this.icon,      // ✅ required
    required this.iconColor,
    required this.label,
    required this.percent,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // ✅ FIX: Gunakan `icon` dari parameter, bukan hardcode
              Icon(icon, size: 14, color: iconColor),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Stack(
            children: [
              Container(
                height: 6,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percent,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: progressColor,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${(percent * 100).toInt()}%',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Color(0xFF757575),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// LEARNING TRACK CARD
// ═══════════════════════════════════════════
class _LearningTrackCard extends StatelessWidget {
  final double percent;
  final Color color;
  final String language;
  final String flag;
  final String region;
  final String topic;
  final String note;

  const _LearningTrackCard({
    required this.percent,
    required this.color,
    required this.language,
    required this.flag,
    required this.region,
    required this.topic,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF8FA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            height: 70,
            child: CustomPaint(
              painter:
                  _CircularProgressPainter(percent: percent, color: color),
              child: Center(
                child: Text(
                  '${(percent * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  language,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF05354C),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(flag, style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        region,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF05354C),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B4D6C),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.menu_book_rounded,
                          color: Colors.white, size: 14),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          topic,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                if (note.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      note,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF757575),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double percent;
  final Color color;

  _CircularProgressPainter({required this.percent, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Colors.white
        ..strokeWidth = 8
        ..style = PaintingStyle.stroke,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * percent,
      false,
      Paint()
        ..color = color
        ..strokeWidth = 8
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(_CircularProgressPainter old) => old.percent != percent;
}

// ═══════════════════════════════════════════
// SECTION HEADER
// ═══════════════════════════════════════════
class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;

  const _SectionHeader({required this.title, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.black87,
          ),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: const Text(
            'See All',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B8499),
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════
// BOTTOM NAV
// ═══════════════════════════════════════════
class _BottomNav extends StatelessWidget {
  final int current;
  final ValueChanged<int> onTap;

  const _BottomNav({required this.current, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFFE6F5FE),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(Icons.home_filled, 'Home', 0),
            _buildNavItem(Icons.pets, 'Pets', 1),
            _buildNavItem(Icons.book, 'Learn', 2),
            _buildNavItem(Icons.person, 'Profile', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isActive = index == current;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: isActive
          ? Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFBBE5FB),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Icon(icon, color: const Color(0xFF004D73), size: 24),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xFF004D73),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            )
          : Icon(icon, size: 30, color: Colors.black87),
    );
  }
}

// ═══════════════════════════════════════════
// HEADER WAVE CLIPPER
// ═══════════════════════════════════════════
class _HeaderWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(size.width * 0.25, size.height + 10,
        size.width * 0.5, size.height - 15);
    path.quadraticBezierTo(size.width * 0.75, size.height - 40,
        size.width, size.height - 10);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
