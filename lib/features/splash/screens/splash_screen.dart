import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  // Circle ripple
  late AnimationController _rippleController;
  late Animation<double> _ripple1, _ripple2, _ripple3;
  late Animation<double> _rippleOpacity1, _rippleOpacity2, _rippleOpacity3;

  // Background circle fill
  late AnimationController _bgController;
  late Animation<double> _bgRadius;
  late Animation<Color?> _bgColor;

  // Mascot
  late AnimationController _mascotController;
  late Animation<double> _mascotY;
  late Animation<double> _mascotScale;
  late Animation<double> _mascotOpacity;
  late Animation<double> _mascotRotation;

  // Shadow di bawah mascot
  late AnimationController _shadowController;
  late Animation<double> _shadowScale;
  late Animation<double> _shadowOpacity;

  // Glow berdenyut
  late AnimationController _glowController;
  late Animation<double> _glowSize;
  late Animation<double> _glowOpacity;

  // Particles
  late AnimationController _particleController;
  late Animation<double> _particleProgress;

  // Text
  late AnimationController _textController;
  late Animation<double> _textOpacity;
  late Animation<double> _textSlideY;
  late Animation<double> _textScale;

  // Shimmer
  late AnimationController _shimmerController;
  late Animation<double> _shimmerX;

  bool _showParticles = false;

  final List<_Particle> _particles = List.generate(12, (i) => _Particle(i));

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _setupAnimations();
    _startSequence();
  }

  void _setupAnimations() {

    // ── RIPPLE (3 lingkaran berurutan) ──
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _ripple1 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rippleController,
          curve: const Interval(0.0, 0.7, curve: Curves.easeOut)));
    _ripple2 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rippleController,
          curve: const Interval(0.15, 0.85, curve: Curves.easeOut)));
    _ripple3 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rippleController,
          curve: const Interval(0.3, 1.0, curve: Curves.easeOut)));

    _rippleOpacity1 = Tween(begin: 0.6, end: 0.0).animate(
      CurvedAnimation(parent: _rippleController,
          curve: const Interval(0.0, 0.7, curve: Curves.easeIn)));
    _rippleOpacity2 = Tween(begin: 0.4, end: 0.0).animate(
      CurvedAnimation(parent: _rippleController,
          curve: const Interval(0.15, 0.85, curve: Curves.easeIn)));
    _rippleOpacity3 = Tween(begin: 0.25, end: 0.0).animate(
      CurvedAnimation(parent: _rippleController,
          curve: const Interval(0.3, 1.0, curve: Curves.easeIn)));

    // ── BACKGROUND FILL ──
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _bgRadius = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1000.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(tween: ConstantTween(1000.0), weight: 15),
      TweenSequenceItem(
        tween: Tween(begin: 1000.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 35,
      ),
    ]).animate(_bgController);

    _bgColor = ColorTween(
      begin: const Color(0xFF38D1F5),
      end: const Color(0xFF0BBCE0),
    ).animate(CurvedAnimation(parent: _bgController, curve: Curves.easeInOut));

    // ── MASCOT ──
    _mascotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _mascotY = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 350.0, end: -30.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -30.0, end: 15.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 15.0, end: -8.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -8.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 15,
      ),
    ]).animate(_mascotController);

    _mascotScale = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 50),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.82)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.82, end: 1.05)
            .chain(CurveTween(curve: Curves.elasticOut)),
        weight: 30,
      ),
    ]).animate(_mascotController);

    _mascotRotation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: -0.05, end: 0.05)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.05, end: 0.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
    ]).animate(_mascotController);

    _mascotOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mascotController,
        curve: const Interval(0.0, 0.2, curve: Curves.easeIn),
      ),
    );

    // ── SHADOW ──
    _shadowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _shadowScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.1, end: 1.2)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.2, end: 0.8)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.8, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 30,
      ),
    ]).animate(_shadowController);

    _shadowOpacity = Tween<double>(begin: 0.0, end: 0.25).animate(
      CurvedAnimation(
        parent: _shadowController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    // ── GLOW berdenyut ──
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _glowSize = Tween<double>(begin: 80.0, end: 130.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    _glowOpacity = Tween<double>(begin: 0.0, end: 0.0)
        .animate(_glowController); // diaktifkan manual

    // ── PARTICLES ──
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _particleProgress = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(
            parent: _particleController, curve: Curves.easeOut));

    // ── TEXT ──
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeIn),
    );

    _textSlideY = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );

    _textScale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.elasticOut),
    );

    // ── SHIMMER ──
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _shimmerX = Tween<double>(begin: -200.0, end: 400.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );
  }

  void _startSequence() async {
    await Future.delayed(const Duration(milliseconds: 200));

    // 1. Ripple burst + background expand bersamaan
    _rippleController.forward();
    await _bgController.forward();

    // 2. Mascot + shadow muncul bersamaan
    await Future.delayed(const Duration(milliseconds: 100));
    _shadowController.forward();

    // Aktifkan glow
    _glowOpacity = Tween<double>(begin: 0.15, end: 0.35).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    await _mascotController.forward();

    // 3. Particle burst saat mendarat
    setState(() => _showParticles = true);
    _particleController.forward();

    // 4. Text muncul
    await Future.delayed(const Duration(milliseconds: 200));
    _textController.forward();

    // 5. Shimmer sekali
    await Future.delayed(const Duration(milliseconds: 300));
    _shimmerController.forward();

    // 6. ✨ IDLE — glow terus berdenyut, user menikmati splash
    await Future.delayed(const Duration(milliseconds: 2800)); // ← TAMBAHAN

    // 7. Shimmer kedua sebelum keluar (bonus!)
    _shimmerController.reset();
    await _shimmerController.forward();

    // 8. Navigate (total ~5 detik)
    await Future.delayed(const Duration(milliseconds: 400));

    if (mounted) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );
      context.go('/welcome');
    }
  }


  @override
  void dispose() {
    _rippleController.dispose();
    _bgController.dispose();
    _mascotController.dispose();
    _shadowController.dispose();
    _glowController.dispose();
    _particleController.dispose();
    _textController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cx = size.width / 2;
    final cy = size.height / 2;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          // ── LAYER 1: Background ripple circles ──
          AnimatedBuilder(
            animation: _rippleController,
            builder: (context, _) {
              return CustomPaint(
                size: size,
                painter: _RipplePainter(
                  center: Offset(cx, cy),
                  maxRadius: 900,
                  progresses: [_ripple1.value, _ripple2.value, _ripple3.value],
                  opacities: [
                    _rippleOpacity1.value,
                    _rippleOpacity2.value,
                    _rippleOpacity3.value,
                  ],
                  color: const Color(0xFF38D1F5),
                ),
              );
            },
          ),

          // ── LAYER 2: Background fill circle ──
          AnimatedBuilder(
            animation: _bgController,
            builder: (context, _) {
              return CustomPaint(
                size: size,
                painter: _SolidCirclePainter(
                  center: Offset(cx, cy),
                  radius: _bgRadius.value,
                  color: _bgColor.value ?? const Color(0xFF38D1F5),
                ),
              );
            },
          ),

          // ── LAYER 3: Mascot area ──
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // Glow + Mascot stack
                SizedBox(
                  width: 220,
                  height: 220,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [

                      // Glow berdenyut
                      AnimatedBuilder(
                        animation: _glowController,
                        builder: (context, _) {
                          return Container(
                            width: _glowSize.value,
                            height: _glowSize.value,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF38D1F5)
                                      .withOpacity(_glowOpacity.value),
                                  blurRadius: 40,
                                  spreadRadius: 20,
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      // Mascot
                      AnimatedBuilder(
                        animation: _mascotController,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _mascotOpacity.value,
                            child: Transform.translate(
                              offset: Offset(0, _mascotY.value),
                              child: Transform.scale(
                                scale: _mascotScale.value,
                                child: Transform.rotate(
                                  angle: _mascotRotation.value,
                                  child: child,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Image.asset(
                          AppAssets.maskotWelcome,
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),

                // Shadow di bawah mascot
                AnimatedBuilder(
                  animation: _shadowController,
                  builder: (context, _) {
                    return Opacity(
                      opacity: _shadowOpacity.value,
                      child: Transform.scale(
                        scaleX: _shadowScale.value,
                        scaleY: 0.3,
                        child: Container(
                          width: 120,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF38D1F5).withOpacity(0.8),
                                blurRadius: 15,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),

                // TEXT dengan shimmer
                AnimatedBuilder(
                  animation: Listenable.merge(
                      [_textController, _shimmerController]),
                  builder: (context, child) {
                    return Opacity(
                      opacity: _textOpacity.value,
                      child: Transform.translate(
                        offset: Offset(0, _textSlideY.value),
                        child: Transform.scale(
                          scale: _textScale.value,
                          child: ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (bounds) {
                              return LinearGradient(
                                colors: const [
                                  Color(0xFF1A1A2E),
                                  Color(0xFF38D1F5),
                                  Color(0xFFFFFFFF),
                                  Color(0xFF38D1F5),
                                  Color(0xFF1A1A2E),
                                ],
                                stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
                                transform: GradientRotation(0),
                                begin: Alignment(
                                    (_shimmerX.value / bounds.width) * 2 - 1,
                                    0),
                                end: Alignment(
                                    (_shimmerX.value / bounds.width) * 2 + 1,
                                    0),
                              ).createShader(bounds);
                            },
                            child: child,
                          ),
                        ),
                      ),
                    );
                  },
                  // Ganti ShaderMask dengan ini — hapus ShaderMask wrapper, langsung child:
child: RichText(
  text: TextSpan(
    children: [
      const TextSpan(
        text: 'Lingu',
        style: TextStyle(
          fontSize: 38,
          fontWeight: FontWeight.w800,
          color: Color(0xFF1A1A2E),
          letterSpacing: -0.5,
        ),
      ),
      const TextSpan(
        text: 'Pet',
        style: TextStyle(
          fontSize: 38,
          fontWeight: FontWeight.w800,
          color: Color(0xFF38D1F5), // cyan tetap
          letterSpacing: -0.5,
        ),
      ),
    ],
  ),
),


                ),

              ],
            ),
          ),

          // ── LAYER 4: Particle burst ──
          if (_showParticles)
            AnimatedBuilder(
              animation: _particleController,
              builder: (context, _) {
                return CustomPaint(
                  size: size,
                  painter: _ParticlePainter(
                    particles: _particles,
                    progress: _particleProgress.value,
                    center: Offset(cx, cy - 10),
                  ),
                );
              },
            ),

        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// PAINTERS & HELPERS
// ─────────────────────────────────────────

class _RipplePainter extends CustomPainter {
  final Offset center;
  final double maxRadius;
  final List<double> progresses;
  final List<double> opacities;
  final Color color;

  _RipplePainter({
    required this.center,
    required this.maxRadius,
    required this.progresses,
    required this.opacities,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < progresses.length; i++) {
      final paint = Paint()
        ..color = color.withOpacity(opacities[i])
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0;
      canvas.drawCircle(center, maxRadius * progresses[i], paint);
    }
  }

  @override
  bool shouldRepaint(_RipplePainter old) => true;
}

class _SolidCirclePainter extends CustomPainter {
  final Offset center;
  final double radius;
  final Color color;

  _SolidCirclePainter(
      {required this.center, required this.radius, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(_SolidCirclePainter old) =>
      old.radius != radius || old.color != color;
}

class _Particle {
  final double angle;
  final double speed;
  final double size;
  final Color color;

  _Particle(int index)
      : angle = (index / 12) * 2 * pi + Random().nextDouble() * 0.5,
        speed = 60 + Random().nextDouble() * 80,
        size = 4 + Random().nextDouble() * 6,
        color = [
          const Color(0xFF38D1F5),
          const Color(0xFF0BBCE0),
          const Color(0xFFFFD700),
          const Color(0xFFFF6B6B),
          const Color(0xFF38D1F5),
          const Color(0xFFFFFFFF),
        ][index % 6];
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;
  final Offset center;

  _ParticlePainter(
      {required this.particles,
      required this.progress,
      required this.center});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final dist = p.speed * progress;
      final x = center.dx + cos(p.angle) * dist;
      final y = center.dy + sin(p.angle) * dist;
      final opacity = (1.0 - progress).clamp(0.0, 1.0);
      final paint = Paint()
        ..color = p.color.withOpacity(opacity)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(x, y), p.size * (1 - progress * 0.5), paint);
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => old.progress != progress;
}
