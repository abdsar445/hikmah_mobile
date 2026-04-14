import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {
  int _count = 0;
  int _target = 33;
  int _selectedIndex = 0;

  // --- COMPLETE ZIKAR LIST ---
  final List<Map<String, String>> _zikarList = [
    {
      'name': 'SubhanAllah',
      'arabic': 'سُبْحَانَ ٱللَّٰهِ',
      'urdu': 'اللہ پاک ہے',
    },
    {
      'name': 'Alhamdulillah',
      'arabic': 'ٱلْحَمْدُ لِلَّٰهِ',
      'urdu': 'تمام تعریفیں اللہ کے لیے ہیں',
    },
    {
      'name': 'Allahu Akbar',
      'arabic': 'ٱللَّٰهُ أَكْبَرُ',
      'urdu': 'اللہ سب سے بڑا ہے',
    },
    {
      'name': 'Astaghfirullah',
      'arabic': 'أَسْتَغْفِرُ ٱللَّٰهَ',
      'urdu': 'میں اللہ سے معافی مانگتا ہوں',
    },
    {
      'name': 'La ilaha illallah',
      'arabic': 'لَا إِلَٰهَ إِلَّا ٱللَّٰهُ',
      'urdu': 'اللہ کے سوا کوئی معبود نہیں',
    },
    {
      'name': 'Durood Sharif',
      'arabic': 'ٱللَّٰهُمَّ صَلِّ عَلَىٰ مُحَمَّدٍ',
      'urdu': 'اے اللہ! محمد ﷺ پر رحمت نازل فرما',
    },
    {
      'name': 'SubhanAllahi wa bihamdihi',
      'arabic': 'سُبْحَانَ ٱللَّٰهِ وَبِحَمْدِهِ',
      'urdu': 'پاک ہے اللہ اپنی تعریفوں کے ساتھ',
    },
  ];

  // --- INCREMENT LOGIC WITH STOP ---
  void _incrementCounter() {
    if (_count < _target) {
      setState(() {
        _count++;
        HapticFeedback.lightImpact(); // Click vibration

        if (_count == _target) {
          HapticFeedback.heavyImpact(); // Completion vibration
          _showCompletionDialog();
        }
      });
    } else {
      // Jab target poora ho jaye to user ko alert mil jaye ke counter stop hai
      HapticFeedback.vibrate();
    }
  }

  void _resetCounter() {
    setState(() {
      _count = 0;
    });
    HapticFeedback.mediumImpact();
  }

  void _setCustomTarget() {
    TextEditingController targetController = TextEditingController(
      text: _target.toString(),
    );
    showDialog(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "Set Target",
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: targetController,
            keyboardType: TextInputType.number,
            autofocus: true,
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
            decoration: InputDecoration(
              labelText: "Enter Limit",
              hintText: "e.g. 10, 33, 100",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (targetController.text.isNotEmpty) {
                  setState(() {
                    _target = int.parse(targetController.text);
                    _count = 0; // Target change karne par counter reset ho jaye
                  });
                }
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF006D5B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showCompletionDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Target of $_target Completed! Tap Reset to start again.",
        ),
        backgroundColor: const Color(0xFF006D5B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const primaryColor = Color(0xFF006D5B);
    final scaffoldBg = isDark
        ? const Color(0xFF0D0D0D)
        : const Color(0xFFF5F8F5);
    final cardColor = isDark ? const Color(0xFF1A1A1A) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final ringColor = isDark ? Colors.white10 : Colors.grey.shade200;

    final currentZikar = _zikarList[_selectedIndex];

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: const Text(
          "Digital Tasbih",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background Decorations
          _buildBackgroundIcons(
            isDark
                ? Colors.white.withOpacity(0.03)
                : primaryColor.withOpacity(0.05),
          ),

          Column(
            children: [
              // Selection Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      "SELECT ZIKAR",
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          dropdownColor: const Color(0xFF004D40),
                          value: _selectedIndex,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          isExpanded: true,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          items: List.generate(_zikarList.length, (index) {
                            return DropdownMenuItem(
                              value: index,
                              child: Text(_zikarList[index]['name']!),
                            );
                          }),
                          onChanged: (val) => setState(() {
                            _selectedIndex = val!;
                            _count = 0;
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Counter Display
              Stack(
                alignment: Alignment.center,
                children: [
                  // Progress Ring
                  SizedBox(
                    width: 280,
                    height: 280,
                    child: CircularProgressIndicator(
                      value: _count / _target,
                      strokeWidth: 12,
                      backgroundColor: ringColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _count == _target ? Colors.amber : primaryColor,
                      ),
                    ),
                  ),
                  // Tap Area
                  GestureDetector(
                    onTap: _incrementCounter,
                    child: AnimatedScale(
                      scale: _count == _target ? 1.05 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        width: 240,
                        height: 240,
                        decoration: BoxDecoration(
                          color: cardColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 30,
                              offset: const Offset(0, 15),
                            ),
                          ],
                          border: Border.all(
                            color: _count == _target
                                ? Colors.amber
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currentZikar['arabic']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 22,
                                fontFamily: 'Amiri',
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "$_count",
                              style: TextStyle(
                                fontSize: 75,
                                fontWeight: FontWeight.w900,
                                color: textColor,
                              ),
                            ),
                            Text(
                              _count == _target ? "COMPLETED" : "TAP HERE",
                              style: TextStyle(
                                color: _count == _target
                                    ? Colors.amber
                                    : Colors.grey,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Controls
              Padding(
                padding: const EdgeInsets.only(bottom: 40, left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _controlBtn(
                      Icons.refresh,
                      "Reset",
                      Colors.red,
                      _resetCounter,
                      isDark,
                    ),
                    _controlBtn(
                      Icons.track_changes,
                      "Target: $_target",
                      primaryColor,
                      _setCustomTarget,
                      isDark,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _controlBtn(
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
    bool isDark,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.05)
              : color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: isDark ? Colors.white : color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundIcons(Color color) {
    return Stack(
      children: [
        Positioned(
          top: 150,
          left: 20,
          child: Icon(Icons.star_outline, size: 40, color: color),
        ),
        Positioned(
          top: 300,
          right: 30,
          child: Icon(Icons.mosque, size: 80, color: color),
        ),
        Positioned(
          bottom: 200,
          left: -20,
          child: Icon(Icons.brightness_3, size: 100, color: color),
        ),
        Positioned(
          bottom: 100,
          right: 40,
          child: Icon(Icons.all_inclusive, size: 40, color: color),
        ),
      ],
    );
  }
}
