import 'package:flutter/material.dart';
import 'dart:async';

// ═══════════════════════════════════════════
// ENTRY POINT
// ═══════════════════════════════════════════
class LessonScreen extends StatefulWidget {
  final String petAsset;
  const LessonScreen({super.key, required this.petAsset});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int _taskIndex = 0;
  int _lives = 5;
  bool _showComplete = false;

  void _onTaskComplete() {
    if (_taskIndex < 2) {
      setState(() => _taskIndex++);
    } else {
      setState(() => _showComplete = true);
    }
  }

  void _onWrongAnswer() {
    setState(() {
      if (_lives > 0) _lives--;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showComplete) {
      return _LessonCompleteScreen(
        petAsset: widget.petAsset,
        onContinue: () => Navigator.of(context).pop(),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(
              progress: (_taskIndex + 1) / 3.0,
              lives: _lives,
              onClose: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                transitionBuilder: (child, anim) => SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(1, 0), end: Offset.zero)
                      .animate(anim),
                  child: child,
                ),
                child: _taskIndex == 0
                    ? _Task1TranslateDragDrop(
                        key: const ValueKey('task1'),
                        petAsset: widget.petAsset,
                        onComplete: _onTaskComplete,
                        onWrong: _onWrongAnswer,
                      )
                    : _taskIndex == 1
                        ? _Task2SelectImage(
                            key: const ValueKey('task2'),
                            petAsset: widget.petAsset,
                            onComplete: _onTaskComplete,
                            onWrong: _onWrongAnswer,
                          )
                        : _Task3PairWords(
                            key: const ValueKey('task3'),
                            onComplete: _onTaskComplete,
                            onWrong: _onWrongAnswer,
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// TOP BAR
// ═══════════════════════════════════════════
class _TopBar extends StatelessWidget {
  final double progress;
  final int lives;
  final VoidCallback onClose;

  const _TopBar({
    required this.progress,
    required this.lives,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFB8E4F5), Color(0xFFE8F6FB)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onClose,
            child: Container(
              width: 32, height: 32,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close_rounded,
                  size: 16, color: Color(0xFF1A1A2E)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                backgroundColor: const Color(0xFFE2E8F0),
                valueColor:
                    const AlwaysStoppedAnimation(Color(0xFF4CAF50)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // ── Lives: Icon widget, bukan AppAssets ──
          Row(
            children: [
              const Icon(Icons.favorite_rounded,
                  color: Color(0xFFE53935), size: 22),
              const SizedBox(width: 4),
              Text('$lives',
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A1A2E))),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// TASK 1 — Translate Sentence (Tap & Drop)
// Soal: "Ambo Lapa" → "I am Hungry"
// ═══════════════════════════════════════════
class _Task1TranslateDragDrop extends StatefulWidget {
  final String petAsset;
  final VoidCallback onComplete;
  final VoidCallback onWrong;

  const _Task1TranslateDragDrop({
    super.key,
    required this.petAsset,
    required this.onComplete,
    required this.onWrong,
  });

  @override
  State<_Task1TranslateDragDrop> createState() =>
      _Task1TranslateDragDropState();
}

class _Task1TranslateDragDropState
    extends State<_Task1TranslateDragDrop> {
  static const _correctAnswer = ['I', 'am', 'Hungry'];
  final List<String> _wordBank = [
    'I', 'you', 'Hungry', 'Happy', 'am', 'Sad'
  ];
  final List<String> _dropped = [];
  bool? _checked;

  void _tapWord(String word) {
    if (_checked != null) return;
    setState(() => _dropped.add(word));
  }

  void _removeWord(int idx) {
    if (_checked != null) return;
    setState(() => _dropped.removeAt(idx));
  }

  void _check() {
    if (_dropped.length != _correctAnswer.length) return;
    final isCorrect = List.generate(
            _dropped.length, (i) => _dropped[i] == _correctAnswer[i])
        .every((e) => e);
    setState(() => _checked = isCorrect);
    if (!isCorrect) {
      widget.onWrong();
      Future.delayed(const Duration(milliseconds: 900), () {
        if (mounted) setState(() => _checked = null);
      });
    } else {
      Future.delayed(const Duration(milliseconds: 700), widget.onComplete);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Track per kata supaya kata sama bisa muncul 2x di bank
    // tapi hanya 1 instance yang bisa ditap
    final droppedCopy = List<String>.from(_dropped);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _QuestionCard(petAsset: widget.petAsset, word: 'Ambo Lapa'),

        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Translate This Sentence',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A1A2E))),
              const SizedBox(height: 16),

              // ── DROP ZONE — fix: ConstrainedBox ganti min: ──
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 56),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: _checked == null
                          ? const Color(0xFFCFD8DC)
                          : _checked!
                              ? const Color(0xFF4CAF50)
                              : const Color(0xFFE53935),
                      width: 1.5,
                    ),
                  ),
                  child: _dropped.isEmpty
                      ? const Text('Tap words below',
                          style: TextStyle(
                              color: Color(0xFFB0BEC5), fontSize: 14))
                      : Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _dropped
                              .asMap()
                              .entries
                              .map((e) => GestureDetector(
                                    onTap: () => _removeWord(e.key),
                                    child: Container(
                                      padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 14,
                                              vertical: 8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF0F9FF),
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        border: Border.all(
                                            color:
                                                const Color(0xFF38D1F5),
                                            width: 1),
                                      ),
                                      child: Text(e.value,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Color(0xFF1A1A2E))),
                                    ),
                                  ))
                              .toList(),
                        ),
                ),
              ),

              const SizedBox(height: 24),

              // ── WORD BANK ──
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _wordBank.map((w) {
                  // Cek apakah kata ini sudah ada di dropped
                  // (hanya disable 1 instance per kata)
                  final tempCopy = List<String>.from(droppedCopy);
                  final isUsed = tempCopy.remove(w);

                  return GestureDetector(
                    onTap: isUsed ? null : () => _tapWord(w),
                    child: AnimatedOpacity(
                      opacity: isUsed ? 0.3 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                              color: const Color(0xFFCFD8DC),
                              width: 1.5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2))
                          ],
                        ),
                        child: Text(w,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1A1A2E))),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        const Spacer(),
        _CheckButton(
          enabled: _dropped.length == _correctAnswer.length,
          checked: _checked,
          onCheck: _check,
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════
// TASK 2 — Select Correct Image
// Soal: "Dapua" → Kitchen
// ═══════════════════════════════════════════
class _Task2SelectImage extends StatefulWidget {
  final String petAsset;
  final VoidCallback onComplete;
  final VoidCallback onWrong;

  const _Task2SelectImage({
    super.key,
    required this.petAsset,
    required this.onComplete,
    required this.onWrong,
  });

  @override
  State<_Task2SelectImage> createState() => _Task2SelectImageState();
}

class _Task2SelectImageState extends State<_Task2SelectImage> {
  int? _selected;
  bool? _checked;

  static const _options = [
    _ImageOption(emoji: '🍽️', label: 'Plate'),
    _ImageOption(emoji: '👨‍🍳', label: 'Kitchen'),
    _ImageOption(emoji: '🏠', label: 'Home'),
    _ImageOption(emoji: '☕', label: 'Cofee'),
  ];
  static const _correctIndex = 1;

  void _check() {
    if (_selected == null) return;
    final isCorrect = _selected == _correctIndex;
    setState(() => _checked = isCorrect);
    if (!isCorrect) {
      widget.onWrong();
      Future.delayed(const Duration(milliseconds: 900), () {
        if (mounted) setState(() {
          _checked = null;
          _selected = null;
        });
      });
    } else {
      Future.delayed(const Duration(milliseconds: 700), widget.onComplete);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _QuestionCard(petAsset: widget.petAsset, word: 'Dapua'),

        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select the correct image',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A1A2E))),
              const SizedBox(height: 20),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.1,
                ),
                itemCount: _options.length,
                itemBuilder: (_, i) {
                  final opt = _options[i];
                  final isSelected = _selected == i;
                  Color borderColor = const Color(0xFFE2E8F0);
                  if (isSelected) {
                    if (_checked == null) {
                      borderColor = const Color(0xFF38D1F5);
                    } else if (_checked!) {
                      borderColor = const Color(0xFF4CAF50);
                    } else {
                      borderColor = const Color(0xFFE53935);
                    }
                  }
                  return GestureDetector(
                    onTap: _checked != null
                        ? null
                        : () => setState(() => _selected = i),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? borderColor.withOpacity(0.08)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: borderColor, width: 2),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 6,
                              offset: const Offset(0, 2))
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(opt.emoji,
                              style: const TextStyle(fontSize: 48)),
                          const SizedBox(height: 8),
                          Text(opt.label,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1A1A2E))),
                          const SizedBox(height: 4),
                          const Icon(Icons.volume_up_rounded,
                              size: 16, color: Color(0xFF38D1F5)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        const Spacer(),
        _CheckButton(
          enabled: _selected != null,
          checked: _checked,
          onCheck: _check,
        ),
      ],
    );
  }
}

class _ImageOption {
  final String emoji, label;
  const _ImageOption({required this.emoji, required this.label});
}

// ═══════════════════════════════════════════
// TASK 3 — Pair Matching Words
// Ambo=I'am, Home=Rumah, Dapua=Kitchen, Jawi=Cow, Hunggry=Lapa
// ═══════════════════════════════════════════
class _Task3PairWords extends StatefulWidget {
  final VoidCallback onComplete;
  final VoidCallback onWrong;

  const _Task3PairWords({
    super.key,
    required this.onComplete,
    required this.onWrong,
  });

  @override
  State<_Task3PairWords> createState() => _Task3PairWordsState();
}

class _Task3PairWordsState extends State<_Task3PairWords> {
  static const _pairs = {
    'Ambo': "I'am",
    'Home': 'Rumah',
    'Dapua': 'Kitchen',
    'Jawi': 'Cow',
    'Hunggry': 'Lapa',
  };

  late final List<String> _leftWords;
  late final List<String> _rightWords;

  int? _selectedLeft;
  int? _selectedRight;
  final Map<int, int> _matched = {};
  final Set<int> _wrongLeft = {};
  final Set<int> _wrongRight = {};
  bool? _checked;

  @override
  void initState() {
    super.initState();
    _leftWords = _pairs.keys.toList();
    _rightWords = _pairs.values.toList()..shuffle();
  }

  void _selectLeft(int i) {
    if (_matched.containsKey(i)) return;
    setState(() {
      _selectedLeft = i;
      _tryMatch();
    });
  }

  void _selectRight(int i) {
    if (_matched.values.contains(i)) return;
    setState(() {
      _selectedRight = i;
      _tryMatch();
    });
  }

  void _tryMatch() {
    if (_selectedLeft == null || _selectedRight == null) return;

    final leftWord = _leftWords[_selectedLeft!];
    final rightWord = _rightWords[_selectedRight!];
    final isCorrect = _pairs[leftWord] == rightWord;

    if (isCorrect) {
      _matched[_selectedLeft!] = _selectedRight!;
    } else {
      final snapL = _selectedLeft!;
      final snapR = _selectedRight!;
      _wrongLeft.add(snapL);
      _wrongRight.add(snapR);
      widget.onWrong();
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) {
          setState(() {
            _wrongLeft.remove(snapL);
            _wrongRight.remove(snapR);
          });
        }
      });
    }

    _selectedLeft = null;
    _selectedRight = null;

    if (_matched.length == _pairs.length) {
      setState(() => _checked = true);
      Future.delayed(const Duration(milliseconds: 700), widget.onComplete);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Pair the matching word correctly',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A1A2E))),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: _leftWords.asMap().entries.map((e) {
                        final i = e.key;
                        return GestureDetector(
                          onTap: _matched.containsKey(i)
                              ? null
                              : () => _selectLeft(i),
                          child: _PairCard(
                            label: e.value,
                            isMatched: _matched.containsKey(i),
                            isSelected: _selectedLeft == i,
                            isWrong: _wrongLeft.contains(i),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: _rightWords.asMap().entries.map((e) {
                        final i = e.key;
                        return GestureDetector(
                          onTap: _matched.values.contains(i)
                              ? null
                              : () => _selectRight(i),
                          child: _PairCard(
                            label: e.value,
                            isMatched: _matched.values.contains(i),
                            isSelected: _selectedRight == i,
                            isWrong: _wrongRight.contains(i),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const Spacer(),
        _CheckButton(
          enabled: _matched.length == _pairs.length,
          checked: _checked,
          onCheck: () {},
        ),
      ],
    );
  }
}

class _PairCard extends StatelessWidget {
  final String label;
  final bool isMatched, isSelected, isWrong;
  const _PairCard({
    required this.label,
    required this.isMatched,
    required this.isSelected,
    required this.isWrong,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    Color bgColor;
    if (isMatched) {
      borderColor = const Color(0xFF4CAF50);
      bgColor = const Color(0xFFF1FFF4);
    } else if (isWrong) {
      borderColor = const Color(0xFFE53935);
      bgColor = const Color(0xFFFFF0F0);
    } else if (isSelected) {
      borderColor = const Color(0xFF38D1F5);
      bgColor = const Color(0xFFF0FEFF);
    } else {
      borderColor = const Color(0xFFDDE3EA);
      bgColor = Colors.white;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor, width: 1.8),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 4,
              offset: const Offset(0, 2))
        ],
      ),
      child: Center(
        child: Text(label,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isMatched
                    ? const Color(0xFF2E7D32)
                    : isWrong
                        ? const Color(0xFFE53935)
                        : const Color(0xFF1A1A2E))),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// QUESTION CARD
// ═══════════════════════════════════════════
class _QuestionCard extends StatelessWidget {
  final String petAsset;
  final String word;
  const _QuestionCard({required this.petAsset, required this.word});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52, height: 52,
            decoration: const BoxDecoration(
              color: Color(0xFFEAF4F8),
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(petAsset,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                      Icons.pets_rounded,
                      size: 28,
                      color: Color(0xFFB0BEC5))),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A3A4A),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(word,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 30, height: 30,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F4FD),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.volume_up_rounded,
                      size: 18, color: Color(0xFF38D1F5)),
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
// CHECK BUTTON
// ═══════════════════════════════════════════
class _CheckButton extends StatelessWidget {
  final bool enabled;
  final bool? checked;
  final VoidCallback onCheck;
  const _CheckButton({
    required this.enabled,
    required this.checked,
    required this.onCheck,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    String label;
    if (checked == true) {
      bg = const Color(0xFF4CAF50);
      label = 'Correct! ✓';
    } else if (checked == false) {
      bg = const Color(0xFFE53935);
      label = 'Wrong! Try again';
    } else {
      bg = enabled
          ? const Color(0xFF78909C)
          : const Color(0xFFCFD8DC);
      label = 'Check';
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: enabled && checked == null ? onCheck : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: bg,
            disabledBackgroundColor: bg,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26)),
          ),
          child: Text(label,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// LESSON COMPLETE SCREEN
// ═══════════════════════════════════════════
class _LessonCompleteScreen extends StatefulWidget {
  final String petAsset;
  final VoidCallback onContinue;
  const _LessonCompleteScreen({
    required this.petAsset,
    required this.onContinue,
  });

  @override
  State<_LessonCompleteScreen> createState() =>
      _LessonCompleteScreenState();
}

class _LessonCompleteScreenState extends State<_LessonCompleteScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  final _elapsedSecs = 150;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _scale = CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  String get _timeStr {
    final m = _elapsedSecs ~/ 60;
    final s = _elapsedSecs % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB8E4F5), Color(0xFFE8F6FB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              const Positioned(
                  top: 60, left: 30,
                  child: _ConfettiIcon(icon: '🎉', angle: -0.3)),
              const Positioned(
                  top: 80, right: 30,
                  child: _ConfettiIcon(icon: '⭐', angle: 0.2)),
              const Positioned(
                  top: 130, right: 50,
                  child: _ConfettiIcon(icon: '🤍', angle: 0.1)),

              Column(
                children: [
                  const SizedBox(height: 40),

                  ScaleTransition(
                    scale: _scale,
                    child: const Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('✨ ', style: TextStyle(fontSize: 22)),
                            Text('Lesson Complete!',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFFF5A623))),
                          ],
                        ),
                        SizedBox(height: 6),
                        Text("You're doing great, keep it up!",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF4A5568))),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  ScaleTransition(
                    scale: _scale,
                    child: Container(
                      width: 200, height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFE8F6FB),
                            Color(0xFFFFECCC)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 20,
                              offset: const Offset(0, 8))
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(widget.petAsset,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => const Icon(
                                Icons.pets_rounded,
                                size: 80,
                                color: Color(0xFFB0BEC5))),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: _StatCard(
                            icon: '⚡',
                            label: 'Total XP',
                            value: '+20',
                            valueColor: const Color(0xFFF5A623),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _StatCard(
                            icon: '🎯',
                            label: 'Correct',
                            value: '100%',
                            valueColor: const Color(0xFF4CAF50),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _StatCard(
                            icon: '🕐',
                            label: 'Time',
                            value: _timeStr,
                            valueColor: const Color(0xFF38D1F5),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                    child: SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: widget.onContinue,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28)),
                        ),
                        child: const Text('Continue',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// STAT CARD
// ═══════════════════════════════════════════
class _StatCard extends StatelessWidget {
  final String icon, label, value;
  final Color valueColor;
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 26)),
          const SizedBox(height: 6),
          Text(label,
              style: const TextStyle(
                  fontSize: 11, color: Color(0xFF6B8499))),
          const SizedBox(height: 4),
          Text(value,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: valueColor)),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// CONFETTI ICON
// ═══════════════════════════════════════════
class _ConfettiIcon extends StatelessWidget {
  final String icon;
  final double angle;
  const _ConfettiIcon({required this.icon, required this.angle});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Text(icon, style: const TextStyle(fontSize: 28)),
    );
  }
}
