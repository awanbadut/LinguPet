import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lingupet/core/constants/app_assets.dart';
import 'package:lingupet/features/learn/screens/learn_screen.dart';
import 'package:lingupet/features/profile/screens/profile_screen.dart';
import 'package:lingupet/features/pets/screens/pet_detail_screen.dart';

// ═══════════════════════════════════════════
// HOME SCREEN (Scaffold utama + BottomNav)
// ═══════════════════════════════════════════
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNav = 0;

  // ── Daftar semua tab screen ──
  static const List<Widget> _screens = [
    _HomeTab(),
    PetDetailScreen(), // 0 - Home
    LearnScreen(), // 2 - Learn
    ProfileScreen(), // 3 - Profile ← terdaftar
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F6FB),
      // IndexedStack agar state tiap tab tidak hilang saat pindah tab
      body: SafeArea(
        child: IndexedStack(
          index: _currentNav,
          children: _screens,
        ),
      ),
      bottomNavigationBar: _BottomNav(
        current: _currentNav,
        onTap: (i) => setState(() => _currentNav = i),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// PETS PLACEHOLDER (tab index 1)
// ═══════════════════════════════════════════
class _PetsPlaceholder extends StatelessWidget {
  const _PetsPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Pets',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// HOME TAB
// ═══════════════════════════════════════════
class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _TopBar(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _SectionHeader(title: 'Your Pet', onSeeAll: () {}),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: _PetCard(),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _SectionHeader(title: 'Learning Track', onSeeAll: () {}),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: _LearningTrackCard(
              percent: 0.70,
              color: Color(0xFFF5A623),
              language: 'Javanese',
              flag: '🇮🇩',
              region: 'West Sumatra, Indonesia',
              topic: 'Topic 2 : Javanese Etiquette 101.',
              note: '3 more words to unlock the next Topic',
            ),
          ),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: _LearningTrackCard(
              percent: 0.50,
              color: Color(0xFFEF5350),
              language: 'Javanese',
              flag: '🇮🇩',
              region: 'West Sumatra, Indonesia',
              topic: 'Topic 2 : Javanese Etiquette 101',
              note: '',
            ),
          ),
          const SizedBox(height: 24),
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
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFB8E4F5), Color(0xFFE8F6FB)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF38D1F5), width: 2),
              color: const Color(0xFFFFE0B2),
            ),
            child: ClipOval(
              child: Image.asset(
                AppAssets.petAdult,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.person,
                    color: Color(0xFFF5A623), size: 24),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome Back, Jhon',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E))),
                Text('Keeping the vibes alive, one word at a time.',
                    style: TextStyle(fontSize: 11.5, color: Color(0xFF6B8499))),
              ],
            ),
          ),
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Stack(
              children: [
                const Center(
                  child: Icon(Icons.notifications_outlined,
                      size: 20, color: Color(0xFF1A1A2E)),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                        color: Color(0xFFF5A623), shape: BoxShape.circle),
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
// PET CARD
// ═══════════════════════════════════════════
class _PetCard extends StatelessWidget {
  const _PetCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 110,
                  height: 130,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFFFF8EC),
                            border: Border.all(
                                color: const Color(0xFFF5A623).withOpacity(0.3),
                                width: 2),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Image.asset(
                          AppAssets.petAdult,
                          width: 105,
                          height: 125,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Icon(Icons.pets,
                              size: 90, color: Color(0xFFF5A623)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Flexible(
                            child: Text('Kaba The Buffalo',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1A1A2E))),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F6FB),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text('Lvl. 12',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF38D1F5))),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        children: [
                          Text('🇮🇩', style: TextStyle(fontSize: 18)),
                          SizedBox(width: 6),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Minang',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1A1A2E))),
                              Text('West Sumatra, Indonesia',
                                  style: TextStyle(
                                      fontSize: 11, color: Color(0xFF6B8499))),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A2A4A),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "I'm getting a bit hungry for some Minang words... care to feed me?",
                          style: TextStyle(
                              fontSize: 11, color: Colors.white, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                    child: _StatCard(
                        icon: Icons.favorite_outline_rounded,
                        iconColor: Color(0xFFEF5350),
                        label: 'Lapar',
                        percent: 0.15)),
                SizedBox(width: 8),
                Expanded(
                    child: _StatCard(
                        icon: Icons.favorite_outline_rounded,
                        iconColor: Color(0xFFEF5350),
                        label: 'Senang',
                        percent: 0.10)),
                SizedBox(width: 8),
                Expanded(
                    child: _StatCard(
                        icon: Icons.bolt_rounded,
                        iconColor: Color(0xFF38D1F5),
                        label: 'Energi',
                        percent: 0.02)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Progress',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1A2E))),
                    Text('75% to Next Evolution',
                        style:
                            TextStyle(fontSize: 11, color: Color(0xFF38D1F5))),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const LinearProgressIndicator(
                    value: 0.75,
                    minHeight: 10,
                    backgroundColor: Color(0xFFE8F0F7),
                    valueColor: AlwaysStoppedAnimation(Color(0xFFF5A623)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5A623),
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shadowColor: const Color(0xFFF5A623).withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                child: const Text('Quick Feed',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              ),
            ),
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
  final Color iconColor;
  final String label;
  final double percent;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: iconColor),
              const SizedBox(width: 4),
              Text(label,
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A2E))),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 5,
              backgroundColor: const Color(0xFFE8F0F7),
              valueColor: const AlwaysStoppedAnimation(Color(0xFFEF5350)),
            ),
          ),
          const SizedBox(height: 4),
          Text('${(percent * 100).toInt()}%',
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B8499))),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 3))
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 64,
            height: 64,
            child: CustomPaint(
              painter: _CircularProgressPainter(percent: percent, color: color),
              child: Center(
                child: Text(
                  '${(percent * 100).toInt()}%',
                  style: TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w800, color: color),
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(language,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E))),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Text(flag, style: const TextStyle(fontSize: 13)),
                    const SizedBox(width: 4),
                    Text(region,
                        style: const TextStyle(
                            fontSize: 11, color: Color(0xFF6B8499))),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A2A4A),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.menu_book_rounded,
                          color: Colors.white, size: 14),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(topic,
                            style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                if (note.isNotEmpty) ...[
                  const SizedBox(height: 5),
                  Text(note,
                      style: const TextStyle(
                          fontSize: 10.5, color: Color(0xFF6B8499))),
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
    final radius = size.width / 2 - 5;

    canvas.drawCircle(
        center,
        radius,
        Paint()
          ..color = const Color(0xFFE8F0F7)
          ..strokeWidth = 6
          ..style = PaintingStyle.stroke);

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2,
        2 * pi * percent,
        false,
        Paint()
          ..color = color
          ..strokeWidth = 6
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke);
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
        Text(title,
            style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E))),
        GestureDetector(
          onTap: onSeeAll,
          child: const Text('See All',
              style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF38D1F5),
                  fontWeight: FontWeight.w600)),
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
      height: 68,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, -4))
        ],
      ),
      child: Row(
        children: [
          _NavItem(
              icon: Icons.home_rounded,
              label: 'Home',
              index: 0,
              current: current,
              onTap: onTap),
          _NavItem(
              icon: Icons.pets_rounded,
              label: 'Pets',
              index: 1,
              current: current,
              onTap: onTap),
          _NavItem(
              icon: Icons.book_outlined,
              label: 'Learn',
              index: 2,
              current: current,
              onTap: onTap),
          _NavItem(
              icon: Icons.person_outline_rounded,
              label: 'Profile',
              index: 3,
              current: current,
              onTap: onTap),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int current;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.current,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index == current;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isActive)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F6FB),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 20, color: const Color(0xFF38D1F5)),
                    const SizedBox(width: 4),
                    Text(label,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF38D1F5))),
                  ],
                ),
              )
            else
              Icon(icon, size: 22, color: const Color(0xFFB0BEC5)),
          ],
        ),
      ),
    );
  }
}
