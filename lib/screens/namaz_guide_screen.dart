import 'package:flutter/material.dart';

class NamazGuideScreen extends StatelessWidget {
  const NamazGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF004D40);
    const accentGold = Color(0xFFC49102);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: isDark
            ? const Color(0xFF0D0D0D)
            : const Color(0xFFF5F8F5),
        appBar: AppBar(
          title: const Text(
            "نماز کا مکمل طریقہ",
            style: TextStyle(
              fontFamily: 'Jameel Noori Nastaleeq',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          bottom: const TabBar(
            indicatorColor: accentGold,
            indicatorWeight: 3,
            labelStyle: TextStyle(
              fontFamily: 'Jameel Noori Nastaleeq',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            tabs: [
              Tab(text: "روزانہ کی نماز"),
              Tab(text: "عید کی نماز"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildDetailedDailyNamaz(isDark, primaryColor, accentGold),
            _buildDetailedEidNamaz(isDark, primaryColor, accentGold),
          ],
        ),
      ),
    );
  }

  // --- TAB 1: DAILY NAMAZ (Full Details) ---
  Widget _buildDetailedDailyNamaz(bool isDark, Color primary, Color gold) {
    final List<Map<String, String>> steps = [
      {
        "step": "1. نیت (Intention)",
        "desc":
            "دل میں ارادہ کریں کہ میں اللہ کے لیے فلاں نماز (جیسے فجر کے 2 فرض) ادا کر رہا ہوں۔",
        "arabic":
            "نَوَيْتُ أَنْ أُصَلِّيَ لِلَّهِ تَعَالَى رَكْعَتَيْ صَلَاةِ الْفَجْرِ فَرْضُ اللَّهِ تَعَالَى مُتَوَجِّهًا إِلَى جِهَةِ الْكَعْبَةِ الشَّرِيفَةِ",
        "urdu":
            "ترجمہ: میں نے نیت کی اللہ کے لیے، دو رکعت نماز فجر فرض، رخ میرا کعبہ شریف کی طرف۔",
      },
      {
        "step": "2. تکبیرِ تحریمہ",
        "desc": "ہاتھ کانوں تک اٹھائیں اور 'اللہ اکبر' کہہ کر ہاتھ باندھ لیں۔",
        "arabic": "اللَّهُ أَكْبَرُ",
        "urdu": "ترجمہ: اللہ سب سے بڑا ہے۔",
      },
      {
        "step": "3. ثناء (Sana)",
        "desc": "ہاتھ باندھنے کے بعد ثناء پڑھیں:",
        "arabic":
            "سُبْحَانَكَ اللَّهُمَّ وَبِحَمْدِكَ وَتَبَارَكَ اسْمُكَ وَتَعَالَى جَدُّكَ وَلَا إِلَهَ غَيْرُكَ",
        "urdu":
            "ترجمہ: اے اللہ! تو پاک ہے اور تمام تعریفیں تیرے ہی لیے ہیں، تیرا نام بابرکت ہے، تیری شان بلند ہے اور تیرے سوا کوئی معبود نہیں۔",
      },
      {
        "step": "4. تعوذ اور تسمیہ",
        "desc": "ثناء کے بعد یہ پڑھیں:",
        "arabic":
            "أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ\nبِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ",
        "urdu":
            "ترجمہ: میں پناہ مانگتا ہوں اللہ کی شیطان مردود سے۔ اللہ کے نام سے شروع جو بڑا مہربان نہایت رحم والا ہے۔",
      },
      {
        "step": "5. سورہ فاتحہ اور سورت",
        "desc":
            "پہلے سورہ فاتحہ پڑھیں اور اس کے بعد کوئی بھی سورت (جیسے سورہ اخلاص) ملائیں۔",
        "arabic":
            "الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ الرَّحْمَنِ الرَّحِيمِ مَالِكِ يَوْمِ الدِّينِ إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ۔\n\nبِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ\nقُلْ هُوَ اللَّهُ أَحَدٌ اللَّهُ الصَّمَدُ لَمْ يَلِدْ وَلَمْ يُولَدْ وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ",
        "urdu":
            "سورہ فاتحہ ترجمہ: سب تعریفیں اللہ کے لیے ہیں جو تمام جہانوں کا پالنے والا ہے۔ بڑا مہربان نہایت رحم والا ہے۔ جزا کے دن کا مالک ہے۔ ہم تیری ہی عبادت کرتے ہیں اور تجھ ہی سے مدد مانگتے ہیں۔ ہمیں سیدھے راستے پر چلا۔ ان لوگوں کے راستے پر جن پر تو نے انعام کیا، نہ ان کے راستے پر جن پر غضب ہوا اور نہ گمراہوں کے۔\n\nسورہ اخلاص ترجمہ: کہو: وہ اللہ ایک ہے۔ اللہ بے نیاز ہے۔ نہ اس کی کوئی اولاد ہے اور نہ وہ کسی کی اولاد ہے۔ اور اس کے برابر کا کوئی ایک بھی نہیں۔",
      },
      {
        "step": "6. رکوع",
        "desc": "جھک کر کم از کم 3 بار یہ تسبیح پڑھیں:",
        "arabic": "سُبْحَانَ رَبِّيَ الْعَظِيمِ",
        "urdu": "ترجمہ: پاک ہے میرا رب جو بہت عظمت والا ہے۔",
      },
      {
        "step": "7. قومہ",
        "desc": "رکوع سے سیدھا کھڑا ہوتے وقت یہ کہیں:",
        "arabic": "سَمِعَ اللَّهُ لِمَنْ حَمِدَهُ\nرَبَّنَا لَكَ الْحَمْدُ",
        "urdu":
            "ترجمہ: اللہ نے اس کی سن لی جس نے اس کی تعریف کی۔ اے ہمارے رب! تمام تعریفیں تیرے ہی لیے ہیں۔",
      },
      {
        "step": "8. سجدہ",
        "desc": "اللہ اکبر کہتے ہوئے سجدے میں جائیں اور 3 بار یہ تسبیح پڑھیں:",
        "arabic": "سُبْحَانَ رَبِّيَ الْأَعْلَى",
        "urdu": "ترجمہ: پاک ہے میرا رب جو سب سے بلند ہے۔",
      },
      {
        "step": "9. تشہد (Attahiyat)",
        "desc": "بیٹھ کر یہ پڑھیں:",
        "arabic":
            "التَّحِيَّاتُ لِلَّهِ وَالصَّلَوَاتُ وَالطَّيِّبَاتُ السَّلَامُ عَلَيْكَ أَيُّهَا النَّبِيُّ وَرَحْمَةُ اللَّهِ وَبَرَكَاتُهُ السَّلَامُ عَلَيْنَا وَعَلَى عِبَادِ اللَّهِ الصَّالِحِينَ أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا اللَّهُ وَأَشْهَدُ أَنْ مُحَمَّدًا عَبْدُهُ وَرَسُولُهُ",
        "urdu":
            "ترجمہ: تمام قولی، بدنی اور مالی عبادتیں اللہ ہی کے لیے ہیں۔ سلام ہو آپ پر اے نبی ﷺ اور اللہ کی رحمتیں اور برکتیں ہوں۔ سلام ہو ہم پر اور اللہ کے نیک بندوں پر۔ میں گواہی دیتا ہوں کہ اللہ کے سوا کوئی معبود نہیں اور محمد ﷺ اس کے بندے اور رسول ہیں۔",
      },
      {
        "step": "10. درودِ ابراہیم",
        "desc": "تشہد کے بعد یہ درود پڑھیں:",
        "arabic":
            "اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ۔ اللَّهُمَّ بَارِكْ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا بَارَكْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ",
        "urdu":
            "ترجمہ: اے اللہ! رحمتیں نازل فرما محمد ﷺ اور ان کی آل پر، جس طرح تو نے رحمتیں نازل کیں ابراہیم علیہ السلام اور ان کی آل پر، بے شک تو قابلِ تعریف اور بزرگ ہے۔",
      },
      {
        "step": "11. دعا",
        "desc": "سلام سے پہلے یہ دعا پڑھیں:",
        "arabic":
            "رَبِّ اجْعَلْنِي مُقِيمَ الصَّلَاةِ وَمِنْ ذُرِّيَّتِي رَبَّنَا وَتَقَبَّلْ دُعَاءِ",
        "urdu":
            "ترجمہ: اے میرے رب! مجھے اور میری اولاد کو نماز قائم کرنے والا بنا، اے ہمارے رب! میری دعا قبول فرما۔",
      },
      {
        "step": "12. سلام",
        "desc": "پہلے دائیں اور پھر بائیں طرف سلام پھیریں۔",
        "arabic": "السَّلَامُ عَلَيْكُمْ وَرَحْمَةُ اللَّهِ",
        "urdu": "ترجمہ: تم پر سلامتی ہو اور اللہ کی رحمت ہو۔",
      },
    ];

    return _buildScrollableList(steps, isDark, primary, gold);
  }

  // --- TAB 2: EID NAMAZ ---
  Widget _buildDetailedEidNamaz(bool isDark, Color primary, Color gold) {
    final List<Map<String, String>> steps = [
      {
        "step": "1. نیت",
        "desc":
            "میں نیت کرتا ہوں 2 رکعت نماز عید الفطر/الاضحیٰ کی، مع 6 زائد تکبیروں کے، پیچھے اس امام کے، منہ میرا کعبہ شریف کی طرف۔",
      },
      {
        "step": "2. پہلی رکعت",
        "desc":
            "تکبیرِ تحریمہ اور ثناء کے بعد امام صاحب 3 زائد تکبیریں کہیں گے۔ پہلی 2 میں ہاتھ اٹھا کر چھوڑ دیں، تیسری کے بعد ہاتھ باندھ لیں۔",
        "arabic": "اللَّهُ أَكْبَرُ (3 بار)",
      },
      {
        "step": "3. دوسری رکعت",
        "desc":
            "دوسری رکعت میں قرات کے بعد رکوع سے پہلے 3 زائد تکبیریں ہوں گی۔ تینوں میں ہاتھ اٹھا کر چھوڑ دیں، چوتھی تکبیر پر ہاتھ اٹھائے بغیر رکوع میں جائیں۔",
        "arabic": "اللَّهُ أَكْبَرُ (4 بار)",
      },
    ];
    return _buildScrollableList(steps, isDark, primary, gold);
  }

  Widget _buildScrollableList(
    List<Map<String, String>> data,
    bool isDark,
    Color primary,
    Color gold,
  ) {
    final cardColor = isDark ? const Color(0xFF1A1A1A) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: primary.withOpacity(0.1),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: gold,
                      child: Text(
                        "${index + 1}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      item['step']!,
                      style: TextStyle(
                        color: primary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Jameel Noori Nastaleeq',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      item['desc']!,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 15,
                        color: textColor,
                        height: 1.5,
                        fontFamily: 'Jameel Noori Nastaleeq',
                      ),
                    ),
                    if (item.containsKey('arabic')) ...[
                      const SizedBox(height: 15),
                      const Divider(),
                      const SizedBox(height: 10),
                      Text(
                        item['arabic']!,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color(0xFF004D40),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Amiri',
                          height: 1.8,
                        ),
                      ),
                    ],
                    if (item.containsKey('urdu')) ...[
                      const SizedBox(height: 10),
                      Text(
                        item['urdu']!,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Jameel Noori Nastaleeq',
                          height: 1.6,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
