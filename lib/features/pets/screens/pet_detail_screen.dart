import 'package:flutter/material.dart';
import 'package:lingupet/core/constants/app_assets.dart';

// ═══════════════════════════════════════════
// PET DETAIL SCREEN
// ═══════════════════════════════════════════
class PetDetailScreen extends StatefulWidget {
  final String name;
  final String region;
  final String asset;
  final int level;
  final double progress;
  final double hunger;
  final double happiness;
  final double energy;

  const PetDetailScreen({
    super.key,
    required this.name,
    required this.region,
    required this.asset,
    required this.level,
    required this.progress,
    required this.hunger,
    required this.happiness,
    required this.energy,
  });

  @override
  State<PetDetailScreen> createState() => _PetDetailScreenState();
}

class _PetDetailScreenState extends State<PetDetailScreen> {
  // State lokal untuk simulasi perubahan stats
  late double _hunger;
  late double _happiness;
  late double _energy;

  @override
  void initState() {
    super.initState();
    _hunger = widget.hunger;
    _happiness = widget.happiness;
    _energy = widget.energy;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFDE4D3),
              Color(0xFFD4E8F5),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // ── Top bar ──
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Detail badge (kiri)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: const Row(
                          children: [
                            Icon(Icons.info_outline_rounded,
                                color: Color(0xFF0066CC), size: 18),
                            SizedBox(width: 8),
                            Text(
                              'Detail',
                              style: TextStyle(
                                color: Color(0xFF0066CC),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Level badge (kanan)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            const Icon(Icons.trending_up_rounded,
                                color: Color(0xFF333333), size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'Level ${widget.level}',
                              style: const TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ── Nama & Lokasi ──
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on_rounded,
                          size: 16, color: Color(0xFF666666)),
                      const SizedBox(width: 4),
                      Text(
                        widget.region,
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xFF666666)),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ── Stat Cards ──
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          icon: '🍽️',
                          label: 'Hunger',
                          value: _hunger,
                          barColor: const Color(0xFFFF9800),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          icon: '❤️',
                          label: 'Happiness',
                          value: _happiness,
                          barColor: const Color(0xFFE91E63),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          icon: '⚡',
                          label: 'Energy',
                          value: _energy,
                          barColor: const Color(0xFF00A8CC),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // ── Pet Image ──
                  Center(
                    child: SizedBox(
                      width: 220,
                      height: 260,
                      child: Image.asset(
                        widget.asset,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.pets_rounded,
                          size: 120,
                          color: Color(0xFFB0BEC5),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ── Action Buttons ──
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          icon: '🍖',
                          label: 'Feed',
                          backgroundColor: const Color(0xFFFDB913),
                          textColor: Colors.white,
                          onTap: () => _showFeedSheet(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildActionButton(
                          icon: '📚',
                          label: 'Vocabulary',
                          backgroundColor: Colors.white,
                          textColor: const Color(0xFF1A2E4A),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ── Level Progress ──
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Level Progress',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1A1A1A),
                              ),
                            ),
                            Text(
                              '${(widget.progress * 100).toInt()}%',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFFF6B6B),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: widget.progress,
                            minHeight: 12,
                            backgroundColor: const Color(0xFFE5E5E5),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              const Color(0xFFFDB913).withOpacity(0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Stat Card ──
  Widget _buildStatCard({
    required String icon,
    required String label,
    required double value,
    required Color barColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 8,
              backgroundColor: const Color(0xFFE5E5E5),
              valueColor: AlwaysStoppedAnimation<Color>(barColor),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${(value * 100).toInt()}%',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
        ],
      ),
    );
  }

  // ── Action Button ──
  Widget _buildActionButton({
    required String icon,
    required String label,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Feed Bottom Sheet ──
  void _showFeedSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              'Feed ${widget.name.split(' ').first}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF011E2F),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Choose a food item to feed your pet',
              style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 20),

            // Food items
            Row(
              children: [
                Expanded(
                  child: _FoodItem(
                    emoji: '🍖',
                    name: 'Meat',
                    xp: '+15 XP',
                    onTap: () {
                      setState(() {
                        _hunger = (_hunger + 0.3).clamp(0.0, 1.0);
                        _happiness = (_happiness + 0.1).clamp(0.0, 1.0);
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _FoodItem(
                    emoji: '🌾',
                    name: 'Grain',
                    xp: '+8 XP',
                    onTap: () {
                      setState(() {
                        _hunger = (_hunger + 0.15).clamp(0.0, 1.0);
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _FoodItem(
                    emoji: '🍎',
                    name: 'Fruit',
                    xp: '+10 XP',
                    onTap: () {
                      setState(() {
                        _hunger = (_hunger + 0.2).clamp(0.0, 1.0);
                        _energy = (_energy + 0.1).clamp(0.0, 1.0);
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _FoodItem(
                    emoji: '🫙',
                    name: 'Premium',
                    xp: '+30 XP',
                    onTap: () {
                      setState(() {
                        _hunger = (_hunger + 0.5).clamp(0.0, 1.0);
                        _happiness = (_happiness + 0.3).clamp(0.0, 1.0);
                        _energy = (_energy + 0.2).clamp(0.0, 1.0);
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// FOOD ITEM WIDGET
// ═══════════════════════════════════════════
class _FoodItem extends StatelessWidget {
  final String emoji;
  final String name;
  final String xp;
  final VoidCallback onTap;

  const _FoodItem({
    required this.emoji,
    required this.name,
    required this.xp,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 26)),
            const SizedBox(height: 4),
            Text(
              name,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF334155),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              xp,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Color(0xFF10B981),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
