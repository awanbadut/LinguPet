import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:lingupet/features/learn/screens/lesson_screen.dart';

// ═══════════════════════════════════════════
// MODULE START SCREEN
// ═══════════════════════════════════════════
class ModuleStartScreen extends StatelessWidget {
  final String moduleName;
  final String flag;
  final String region;
  final String petAsset;
  final Color bgColor;
  final double percent;

  const ModuleStartScreen({
    super.key,
    required this.moduleName,
    required this.flag,
    required this.region,
    required this.petAsset,
    required this.bgColor,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F8FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CourseProgressCard(
                        petAsset: petAsset, percent: percent),
                    const SizedBox(height: 16),
                    _Topic1Card(
                      petAsset: petAsset,
                      onStartLesson: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              LessonScreen(petAsset: petAsset),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const _LockedTopicCard(
                        title: 'Topic 2 : Sollicitudin pellentesque',
                        stepCount: 5),
                    const SizedBox(height: 10),
                    const _LockedTopicCard(
                        title: 'Topic 3 : Vulputate ultrices quisque',
                        stepCount: 5),
                    const SizedBox(height: 10),
                    const _LockedTopicCard(
                        title: 'Topic 4: ut maecenas accumsan.',
                        stepCount: 5),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF9FD8F0), Color(0xFFD6EEF8)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // ── CLOSE → pop() ──
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close_rounded,
                      size: 18, color: Color(0xFF1A1A2E)),
                ),
              ),
              Expanded(
                child: Text(
                  moduleName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A1A2E)),
                ),
              ),
              const SizedBox(width: 36),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(flag, style: const TextStyle(fontSize: 14)),
              const SizedBox(width: 6),
              Text(region,
                  style: const TextStyle(
                      fontSize: 13, color: Color(0xFF4A5568))),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// COURSE PROGRESS CARD
// ═══════════════════════════════════════════
class _CourseProgressCard extends StatelessWidget {
  final String petAsset;
  final double percent;
  const _CourseProgressCard(
      {required this.petAsset, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60, height: 60,
            decoration: const BoxDecoration(
              color: Color(0xFFEAF4F8),
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(petAsset,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                      Icons.pets_rounded,
                      size: 32,
                      color: Color(0xFFB0BEC5))),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Course Progress',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1A2E))),
                    Text('${(percent * 100).toInt()}%',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFF5A623))),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: percent,
                    minHeight: 8,
                    backgroundColor: const Color(0xFFE2E8F0),
                    valueColor: const AlwaysStoppedAnimation(
                        Color(0xFFF5A623)),
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
// TOPIC 1 CARD — menerima callback onStartLesson
// ═══════════════════════════════════════════
class _Topic1Card extends StatelessWidget {
  final String petAsset;
  final VoidCallback onStartLesson;

  const _Topic1Card(
      {required this.petAsset, required this.onStartLesson});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34, height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFF2A5298).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.menu_book_rounded,
                    size: 18, color: Color(0xFF2A5298)),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Topic 1:  facilisi tellus at blandit. Ac',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1A2E))),
                    SizedBox(height: 2),
                    Text('5 Steps to level up',
                        style: TextStyle(
                            fontSize: 11, color: Color(0xFF6B8499))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _ZigzagPath(onStartLesson: onStartLesson),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// ZIGZAG PATH
// ═══════════════════════════════════════════
class _ZigzagPath extends StatelessWidget {
  final VoidCallback onStartLesson;
  const _ZigzagPath({required this.onStartLesson});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width - 32 - 28 - 40;
    const double rightX = 0.62;
    const double leftX = 0.12;
    const double nodeSize = 52.0;
    const double rowH = 100.0;

    final nodes = [
      _NodeData(status: 'done',   xFrac: rightX, label: 'Intro', showStar: true),
      _NodeData(status: 'active', xFrac: leftX,  label: '',      showStar: false),
      _NodeData(status: 'locked', xFrac: rightX, label: '',      showStar: false, showStart: true),
      _NodeData(status: 'locked', xFrac: leftX,  label: '',      showStar: false),
      _NodeData(status: 'gift',   xFrac: rightX, label: '',      showStar: false),
    ];

    return SizedBox(
      height: rowH * nodes.length - 20,
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _ZigzagPainter(
                nodes: nodes,
                rowH: rowH,
                nodeSize: nodeSize,
                totalWidth: w,
              ),
            ),
          ),
          ...nodes.asMap().entries.map((e) {
            final i = e.key;
            final node = e.value;
            return Positioned(
              top: i * rowH,
              left: node.xFrac * w,
              child: _NodeWidget(
                node: node,
                size: nodeSize,
                number: i + 1,
                onStart: node.showStart ? onStartLesson : null,
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// NODE DATA
// ═══════════════════════════════════════════
class _NodeData {
  final String status;
  final double xFrac;
  final String label;
  final bool showStar;
  final bool showStart;
  const _NodeData({
    required this.status,
    required this.xFrac,
    required this.label,
    required this.showStar,
    this.showStart = false,
  });
}

// ═══════════════════════════════════════════
// NODE WIDGET
// ═══════════════════════════════════════════
class _NodeWidget extends StatelessWidget {
  final _NodeData node;
  final double size;
  final int number;
  final VoidCallback? onStart;

  const _NodeWidget({
    required this.node,
    required this.size,
    required this.number,
    this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    Widget inner;

    switch (node.status) {
      case 'done':
        inner = Container(
          width: size, height: size,
          decoration: const BoxDecoration(
            color: Color(0xFF4CAF50),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Color(0x554CAF50),
                  blurRadius: 8,
                  offset: Offset(0, 3))
            ],
          ),
          child: const Icon(Icons.check_rounded,
              color: Colors.white, size: 26),
        );
        break;
      case 'active':
        inner = Container(
          width: size, height: size,
          decoration: const BoxDecoration(
            color: Color(0xFF4CAF50),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Color(0x554CAF50),
                  blurRadius: 8,
                  offset: Offset(0, 3))
            ],
          ),
          child: Center(
            child: Text('$number',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.white)),
          ),
        );
        break;
      case 'gift':
        inner = Container(
          width: size, height: size,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
          ),
          child: const Center(
              child: Text('🎁', style: TextStyle(fontSize: 22))),
        );
        break;
      default:
        inner = Container(
          width: size, height: size,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
          ),
          child: Center(
            child: Text('$number',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFB0BEC5))),
          ),
        );
    }

    return SizedBox(
      width: size + 80,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          inner,

          if (node.showStar)
            Positioned(
              top: -4, right: 18,
              child: const Text('⭐',
                  style: TextStyle(fontSize: 14)),
            ),

          if (node.label.isNotEmpty)
            Positioned(
              top: size + 4,
              left: 0,
              width: size,
              child: Text(node.label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF4A5568),
                      fontWeight: FontWeight.w500)),
            ),

          // ── START BUTTON — navigasi ke LessonScreen ──
          if (node.showStart)
            Positioned(
              top: -4,
              left: size + 8,
              child: GestureDetector(
                onTap: onStart,
                child: Column(
                  children: [
                    Container(
                      width: 52, height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5A623),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xFFF5A623)
                                  .withOpacity(0.4),
                              blurRadius: 10,
                              offset: const Offset(0, 4)),
                        ],
                      ),
                      child: const Icon(Icons.play_arrow_rounded,
                          color: Colors.white, size: 28),
                    ),
                    const SizedBox(height: 4),
                    const Text('Start',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFF5A623))),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// ZIGZAG PAINTER
// ═══════════════════════════════════════════
class _ZigzagPainter extends CustomPainter {
  final List<_NodeData> nodes;
  final double rowH;
  final double nodeSize;
  final double totalWidth;

  const _ZigzagPainter({
    required this.nodes,
    required this.rowH,
    required this.nodeSize,
    required this.totalWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paintGreen = Paint()
      ..color = const Color(0xFF4CAF50)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final paintGray = Paint()
      ..color = const Color(0xFFD1D5DB)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < nodes.length - 1; i++) {
      final curr = nodes[i];
      final next = nodes[i + 1];

      final x1 = curr.xFrac * totalWidth + nodeSize / 2;
      final y1 = i * rowH + nodeSize / 2;
      final x2 = next.xFrac * totalWidth + nodeSize / 2;
      final y2 = (i + 1) * rowH + nodeSize / 2;

      final path = Path()
        ..moveTo(x1, y1)
        ..cubicTo(
          x1, y1 + (y2 - y1) * 0.4,
          x2, y2 - (y2 - y1) * 0.4,
          x2, y2,
        );

      final isGreen =
          curr.status == 'done' || curr.status == 'active';

      if (isGreen) {
        canvas.drawPath(path, paintGreen);
      } else {
        _drawDashedPath(canvas, path, paintGray);
      }
    }
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double start = 0;
      const dashLen = 8.0;
      const gapLen = 6.0;
      while (start < metric.length) {
        final end = math.min(start + dashLen, metric.length);
        canvas.drawPath(metric.extractPath(start, end), paint);
        start += dashLen + gapLen;
      }
    }
  }

  @override
  bool shouldRepaint(_ZigzagPainter _) => false;
}

// ═══════════════════════════════════════════
// LOCKED TOPIC CARD
// ═══════════════════════════════════════════
class _LockedTopicCard extends StatelessWidget {
  final String title;
  final int stepCount;
  const _LockedTopicCard(
      {required this.title, required this.stepCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34, height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.lock_rounded,
                size: 18, color: Color(0xFF94A3B8)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E))),
                const SizedBox(height: 2),
                Text('$stepCount Steps to level up',
                    style: const TextStyle(
                        fontSize: 11, color: Color(0xFF6B8499))),
              ],
            ),
          ),
          const Icon(Icons.keyboard_arrow_down_rounded,
              color: Color(0xFF6B8499), size: 22),
        ],
      ),
    );
  }
}
