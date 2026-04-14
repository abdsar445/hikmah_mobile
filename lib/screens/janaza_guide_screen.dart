import 'package:flutter/material.dart';

class JanazaGuideScreen extends StatelessWidget {
  const JanazaGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF006D5B);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF121212)
          : const Color(0xFFF5F9F8),
      appBar: AppBar(
        title: const Text(
          "نمازِ جنازہ کا طریقہ",
          style: TextStyle(fontFamily: 'Jameel Noori Nastaleeq'),
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // --- METHOD SECTION ---
            _buildSectionTitle("نمازِ جنازہ کا طریقہ (خلاصہ)", primaryColor),
            _buildInfoCard(
              cardBg,
              "نمازِ جنازہ میں چار تکبیریں ہوتی ہیں اور اس میں سجدہ یا رکوع نہیں ہوتا۔ تمام تکبیروں میں ہاتھ کانوں تک اٹھانے کی ضرورت نہیں (صرف پہلی تکبیر میں اٹھائے جاتے ہیں)۔",
              textColor,
            ),

            const SizedBox(height: 20),

            // --- STEPS ---
            _buildStepCard(
              cardBg,
              "پہلی تکبیر",
              "ثنا پڑھیں",
              "سُبْحَانَكَ اللَّهُمَّ وَبِحَمْدِكَ وَتَبَارَكَ اسْمُكَ وَتَعَالَى جَدُّكَ وَجَلَّ ثَنَاؤُكَ وَلَا إِلَهَ غَيْرُكَ",
              "پاک ہے تو اے اللہ! اور تیری ہی تعریف ہے، اور تیرا نام برکت والا ہے، اور تیری شان بلند ہے، اور تیری تعریف بڑی ہے، اور تیرے سوا کوئی معبود نہیں۔",
              primaryColor,
            ),

            _buildStepCard(
              cardBg,
              "دوسری تکبیر",
              "درودِ ابراہیمی پڑھیں",
              "اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ۔ اللَّهُمَّ بَارِكْ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا بَارَكْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ",
              null,
              primaryColor,
            ),

            const SizedBox(height: 20),
            _buildSectionTitle("تیسری تکبیر (مختلف دعائیں)", primaryColor),

            // --- DUA FOR ADULTS ---
            _buildStepCard(
              cardBg,
              "بالغ مرد اور عورت کے لیے دعا",
              "",
              "اللَّهُمَّ اغْفِرْ لِحَيِّنَا وَمَيِّتِنَا وَشَاهِدِنَا وَغَائِبِنَا وَصَغِيرِنَا وَكَبِيرِنَا وَذَكَرِنَا وَأُنْثَانَا۔ اللَّهُمَّ مَنْ أَحْيَيْتَهُ مِنَّا فَأَحْيِهِ عَلَى الْإِسْلَامِ وَمَنْ تَوَفَّيْتَهُ مِنَّا فَتَوَفَّهُ عَلَى الْإِيمَانِ",
              "اے اللہ! بخش دے ہمارے ہر زندہ کو اور ہمارے ہر فوت شدہ کو، اور ہمارے ہر حاضر کو اور ہمارے ہر غائب کو، اور ہمارے ہر چھوٹے کو اور ہمارے ہر بڑے کو، اور ہمارے ہر مرد کو اور ہماری ہر عورت کو۔ اے اللہ! ہم میں سے جسے تو زندہ رکھے اسے اسلام پر زندہ رکھ اور جسے تو موت دے اسے ایمان پر موت دے۔",
              primaryColor,
            ),

            // --- DUA FOR MALE CHILD ---
            _buildStepCard(
              cardBg,
              "نابالغ لڑکے کے لیے دعا",
              "",
              "اللَّهُمَّ اجْعَلْهُ لَنَا فَرَطًا وَاجْعَلْهُ لَنَا أَجْرًا وَذُخْرًا وَاجْعَلْهُ لَنَا شَافِعًا وَمُشَفَّعًا",
              "اے اللہ! اسے ہمارے لیے آگے پہنچ کر سامانِ راحت بنانے والا بنا دے اور اسے ہمارے لیے اجر اور ذخیرہ بنا دے اور اسے ہمارے لیے وہ سفارشی بنا دے جس کی سفارش قبول کر لی گئی ہو۔",
              primaryColor,
            ),

            // --- DUA FOR FEMALE CHILD ---
            _buildStepCard(
              cardBg,
              "نابالغ لڑکی کے لیے دعا",
              "",
              "اللَّهُمَّ اجْعَلْهَا لَنَا فَرَطًا وَاجْعَلْهَا لَنَا أَجْرًا وَذُخْرًا وَاجْعَلْهَا لَنَا شَافِعَةً وَمُشَفَّعَةً",
              "اے اللہ! اسے ہمارے لیے آگے پہنچ کر سامانِ راحت بنانے والی بنا دے اور اسے ہمارے لیے اجر اور ذخیرہ بنا دے اور اسے ہمارے لیے وہ سفارشی بنا دے جس کی سفارش قبول کر لی گئی ہو۔",
              primaryColor,
            ),

            const SizedBox(height: 20),
            _buildStepCard(
              cardBg,
              "چوتھی تکبیر",
              "سلام پھیرنا",
              "السَّلَامُ عَلَيْكُمْ وَرَحْمَةُ اللَّهِ",
              "چوتھی تکبیر کے بعد بغیر کچھ پڑھے پہلے دائیں اور پھر بائیں طرف سلام پھیر دیں۔",
              primaryColor,
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontFamily: 'Jameel Noori Nastaleeq',
          color: color,
        ),
      ),
    );
  }

  Widget _buildInfoCard(Color bg, String text, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.teal.withOpacity(0.1)),
      ),
      child: Text(
        text,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 16,
          height: 1.6,
          fontFamily: 'Jameel Noori Nastaleeq',
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildStepCard(
    Color bg,
    String title,
    String subtitle,
    String arabic,
    String? translation,
    Color primary,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primary,
              fontFamily: 'Jameel Noori Nastaleeq',
            ),
          ),
          if (subtitle.isNotEmpty)
            Text(
              subtitle,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontFamily: 'Jameel Noori Nastaleeq',
              ),
            ),
          const Divider(height: 25),
          Text(
            arabic,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontSize: 24,
              fontFamily: 'Amiri',
              fontWeight: FontWeight.bold,
              color: Color(0xFF006D5B),
              height: 1.6,
            ),
          ),
          if (translation != null) ...[
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "ترجمہ: $translation",
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'Jameel Noori Nastaleeq',
                  color: Colors.brown,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
