import 'package:flutter/material.dart';

// Model data kosakata
class VocabularyWord {
  final String word;
  final String translation;
  final String example;
  final String exampleTranslation;
  final String addedBy;
  final String addedByInitial;
  final int likes;
  final String infoNote;
  final bool isAccurate;

  VocabularyWord({
    required this.word,
    required this.translation,
    this.example = '',
    this.exampleTranslation = '',
    required this.addedBy,
    required this.addedByInitial,
    this.likes = 0,
    this.infoNote = '',
    this.isAccurate = true,
  });
}

class LanguageDictionaryPage extends StatefulWidget {
  final String petName;
  final String languageName;

  const LanguageDictionaryPage({
    Key? key,
    this.petName = 'Kaba The Buffalo',
    this.languageName = 'Minang Language',
  }) : super(key: key);

  @override
  State<LanguageDictionaryPage> createState() => _LanguageDictionaryPageState();
}

class _LanguageDictionaryPageState extends State<LanguageDictionaryPage> {
  int _selectedChipIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  int? _expandedIndex;

  // Dummy data — nanti ganti dengan API/provider
  final List<VocabularyWord> _allWords = [
    VocabularyWord(
      word: 'Sila',
      translation: 'Please / Go ahead',
      example: 'Sila singgah, indak ado nan malarang doh.',
      exampleTranslation: 'Please come in / feel free to stop by, no one is stopping you.',
      addedBy: 'Budi Santoso',
      addedByInitial: 'B',
      likes: 234,
      infoNote: 'Kata ini umum digunakan dalam percakapan informal sehari-hari dengan teman sebaya.',
      isAccurate: true,
    ),
    VocabularyWord(
      word: 'Iyo',
      translation: 'Yes',
      addedBy: 'Rina Putri',
      addedByInitial: 'R',
      likes: 189,
      isAccurate: true,
    ),
    VocabularyWord(
      word: 'Baa',
      translation: 'How',
      addedBy: 'Andi Kurnia',
      addedByInitial: 'A',
      likes: 97,
      isAccurate: true,
    ),
  ];

  List<VocabularyWord> _filteredWords = [];
  final List<String> _chips = ['All Languages', 'Popular', 'Verified'];

  @override
  void initState() {
    super.initState();
    _filteredWords = _allWords;
    _searchController.addListener(_filterWords);
  }

  void _filterWords() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredWords = _allWords.where((w) =>
        w.word.toLowerCase().contains(query) ||
        w.translation.toLowerCase().contains(query),
      ).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Column(
        children: [
          // HEADER
          ClipPath(
            clipper: DictionaryHeaderClipper(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 50, left: 24, right: 24, bottom: 40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF42E0FF), Color(0xFFF1F9FF), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.6, 1.0],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Color(0xFF00334E), size: 22),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Language Dictionary',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF05354C),
                            ),
                          ),
                          Text(
                            widget.languageName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF757575),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Search Bar
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Cari kata atau terjemahan...',
                        hintStyle: const TextStyle(color: Color(0xFF9E9E9E), fontSize: 14),
                        prefixIcon: const Icon(Icons.search, color: Color(0xFF05354C), size: 20),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear, color: Color(0xFF9E9E9E), size: 18),
                                onPressed: () {
                                  _searchController.clear();
                                  _filterWords();
                                },
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // FILTER CHIPS & STATUS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Row(
                  children: List.generate(_chips.length, (i) => Padding(
                    padding: EdgeInsets.only(right: i < _chips.length - 1 ? 12 : 0),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedChipIndex = i),
                      child: _buildChip(_chips[i], isSelected: _selectedChipIndex == i),
                    ),
                  )),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_filteredWords.length} Words Found',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF757575),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.menu_book_rounded, color: Color(0xFF9E9E9E), size: 16),
                        const SizedBox(width: 6),
                        Text(
                          widget.petName,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF9E9E9E),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // LIST
          Expanded(
            child: _filteredWords.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    itemCount: _filteredWords.length,
                    itemBuilder: (context, index) {
                      final word = _filteredWords[index];
                      final isExpanded = _expandedIndex == index;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _expandedIndex = isExpanded ? null : index;
                            });
                          },
                          child: isExpanded
                              ? _buildDetailedCard(word)
                              : _buildCollapsedCard(word),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off_rounded, size: 64, color: Color(0xFFB0BEC5)),
          const SizedBox(height: 16),
          const Text(
            'Kata tidak ditemukan',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF607D8B)),
          ),
          const SizedBox(height: 8),
          Text(
            'Coba kata kunci lain',
            style: TextStyle(fontSize: 13, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String text, {required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFBBE5FB) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Colors.transparent : const Color(0xFFE0E0E0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? const Color(0xFF00334E) : const Color(0xFF4A4A4A),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildDetailedCard(VocabularyWord word) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFB3C5CC), width: 0.8),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(word.word, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(width: 12),
              if (word.isAccurate) _buildAccurateBadge(),
              const Spacer(),
              _buildSpeakerIcon(word.word),
            ],
          ),
          const SizedBox(height: 8),
          Text(word.translation, style: const TextStyle(fontSize: 15, color: Color(0xFF616161), fontWeight: FontWeight.w500)),

          if (word.example.isNotEmpty) ...[
            const SizedBox(height: 24),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFAFA),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFEEEEEE)),
                  ),
                  child: Text(
                    '"${word.example}"\n(${word.exampleTranslation})',
                    style: const TextStyle(fontSize: 14, color: Color(0xFF424242), height: 1.5),
                  ),
                ),
                Positioned(
                  top: -10,
                  left: 16,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: const Text('Example Usage', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF9E9E9E))),
                  ),
                ),
              ],
            ),
          ],

          const SizedBox(height: 24),
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(color: Color(0xFF1EA3B8), shape: BoxShape.circle),
                child: Center(
                  child: Text(word.addedByInitial, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Added by', style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
                  Text(word.addedBy, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  // TODO: toggle like, update ke backend/provider
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.thumb_up_outlined, size: 16, color: Color(0xFF757575)),
                      const SizedBox(width: 6),
                      Text('${word.likes}', style: const TextStyle(fontSize: 14, color: Color(0xFF424242), fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ],
          ),

          if (word.infoNote.isNotEmpty) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF7FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline, color: Color(0xFF1976D2), size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(word.infoNote, style: const TextStyle(fontSize: 12, color: Color(0xFF1976D2), height: 1.4)),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCollapsedCard(VocabularyWord word) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEAEAEA)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(word.word, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(width: 12),
                  if (word.isAccurate) _buildAccurateBadge(),
                ],
              ),
              const SizedBox(height: 8),
              Text(word.translation, style: const TextStyle(fontSize: 14, color: Color(0xFF616161), fontWeight: FontWeight.w500)),
            ],
          ),
          const Spacer(),
          _buildSpeakerIcon(word.word),
        ],
      ),
    );
  }

  Widget _buildAccurateBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: const Color(0xFF1EA3B8), borderRadius: BorderRadius.circular(12)),
      child: const Row(
        children: [
          Icon(Icons.check, color: Colors.white, size: 12),
          SizedBox(width: 4),
          Text('Accurate', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSpeakerIcon(String word) {
    return GestureDetector(
      onTap: () {
        // TODO: FlutterTts().speak(word) 
        // atau play audio URL dari server
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(color: Color(0xFFFFF3E0), shape: BoxShape.circle),
        child: const Icon(Icons.volume_up, color: Color(0xFFE65100), size: 20),
      ),
    );
  }
}

class DictionaryHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(size.width * 0.25, size.height + 10, size.width * 0.5, size.height - 15);
    path.quadraticBezierTo(size.width * 0.75, size.height - 40, size.width, size.height - 10);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}