import 'package:flutter/material.dart';

class KalimasScreen extends StatelessWidget {
  const KalimasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF006D5B);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, String>> kalimas = [
      {
        "name": "پہلا کلمہ طیبہ",
        "arabic": "لَا إِلٰهَ إِلَّا اللهُ مُحَمَّدٌ رَسُولُ اللهِ",
        "urdu": "اللہ کے سوا کوئی معبود نہیں، محمد ﷺ اللہ کے رسول ہیں۔",
      },
      {
        "name": "دوسرا کلمہ شہادت",
        "arabic":
            "أَشْهَدُ أَنْ لَا إِلٰهَ إِلَّا اللهُ وَحْدَهُ لَا شَرِیکَ لَهُ وَأَشْهَدُ أَنَّ مُحَمَّدًا عَبْدُهُ وَرَسُولُهُ",
        "urdu":
            "میں گواہی دیتا ہوں کہ اللہ کے سوا کوئی معبود نہیں، وہ اکیلا ہے اس کا کوئی شریک نہیں، اور میں گواہی دیتا ہوں کہ محمد ﷺ اللہ کے بندے اور رسول ہیں۔",
      },
      {
        "name": "تیسرا کلمہ تمجید",
        "arabic":
            "سُبْحَانَ اللهِ وَالْحَمْدُ لِلهِ وَلَا إِلٰهَ إِلَّا اللهُ وَاللهُ أَکْبَرُ وَلَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللهِ الْعَلِیِّ الْعَظِیمِ",
        "urdu":
            "پاک ہے اللہ اور سب تعریفیں اللہ ہی کے لیے ہیں، اللہ کے سوا کوئی معبود نہیں اور اللہ سب سے بڑا ہے، اور گناہوں سے بچنے کی طاقت اور نیک کام کرنے کی قوت نہیں مگر اللہ کی طرف سے جو بلند مرتبہ اور عظمت والا ہے۔",
      },
      {
        "name": "چوتھا کلمہ توحید",
        "arabic":
            "لَا إِلٰهَ إِلَّا اللهُ وَحْدَهُ لَا شَرِیکَ لَهُ، لَهُ الْمُلْکُ وَلَهُ الْحَمْدُ، يُحْیِی وَيُمِيتُ وَهُوَ حَیٌّ لَا يَمُوتُ أَبَدًا أَبَدًا، ذُو الْجَلَالِ وَالْإِکْرَامِ، بِيَدِهِ الْخَيْرُ وَهُوَ عَلٰی کُلِّ شَیْءٍ قَدِيرٌ",
        "urdu":
            "اللہ کے سوا کوئی معبود نہیں وہ اکیلا ہے اس کا کوئی شریک نہیں، اسی کی بادشاہی ہے اور اسی کے لیے تمام تعریف ہے، وہی زندہ کرتا ہے اور وہی مارتا ہے اور وہ ہمیشہ زندہ ہے اسے کبھی موت نہیں آئے گی، وہ بڑی عظمت اور بزرگی والا ہے، اسی کے ہاتھ میں بھلائی ہے اور وہ ہر چیز پر قادر ہے۔",
      },
      {
        "name": "پانچواں کلمہ استغفار",
        "arabic":
            "أَسْتَغْفِرُ اللهَ رَبِّی مِنْ کُلِّ ذَنْبٍ أَذْنَبْتُهُ عَمَدًا أَوْ خَطَأً سِرًّا أَوْ عَلَانِيَةً وَأَتُوبُ إِلَيْهِ مِنَ الذَّنْبِ الَّذِی أَعْلَمُ وَمِنَ الذَّنْبِ الَّذِی لَا أَعْلَمُ، إِنَّکَ أَنْتَ عَلَّامُ الْغُيُوبِ وَسَتَّارُ الْعُيُوبِ وَغَفَّارُ الذُّنُوبِ وَلَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللهِ الْعَلِیِّ الْعَظِیمِ",
        "urdu":
            "میں اللہ سے معافی مانگتا ہوں جو میرا رب ہے، ہر اس گناہ سے جو میں نے جان بوجھ کر کیا یا بھول کر، چھپ کر کیا یا ظاہر ہو کر، اور میں اس کی بارگاہ میں توبہ کرتا ہوں اس گناہ سے جسے میں جانتا ہوں اور اس گناہ سے بھی جسے میں نہیں جانتا۔ اے اللہ! بے شک تو غیبوں کا جاننے والا اور عیبوں کو چھپانے والا اور گناہوں کو بخشنے والا ہے، اور گناہوں سے بچنے کی طاقت اور نیک کام کرنے کی قوت نہیں مگر اللہ کی طرف سے جو بلند مرتبہ اور عظمت والا ہے۔",
      },
      {
        "name": "چھٹا کلمہ ردِ کفر",
        "arabic":
            "اَللّٰهُمَّ إِنِّی أَعُوذُ بِکَ مِنْ أَنْ أُشْرِکَ بِکَ شَيْئًا وَأَنَا أَعْلَمُ بِهِ وَأَسْتَغْفِرُکَ لِمَا لَا أَعْلَمُ بِهِ تُبْتُ عَنْهُ وَتَبَرَّأْتُ مِنَ الْکُفْرِ وَالشِّرْکِ وَالْکِذْبِ وَالْغِيبَةِ وَالْبِدْعَةِ وَالنَّمِيمَةِ وَالْفَوَاحِشِ وَالْبُهْتَانِ وَالْمَعَاصِی کُلِّهَا وَأَسْلَمْتُ وَأَقُولُ لَا إِلٰهَ إِلَّا اللهُ مُحَمَّدٌ رَسُولُ اللهِ",
        "urdu":
            "اے اللہ! میں تیری پناہ مانگتا ہوں اس بات سے کہ میں تیرے ساتھ کسی چیز کو شریک کروں حالانکہ میں اسے جانتا ہوں، اور میں تجھ سے معافی مانگتا ہوں اس گناہ سے جسے میں نہیں جانتا، میں نے اس سے توبہ کی اور کفر، شرک، جھوٹ، غیبت، بدعت، چغلی، بے حیائی کے کاموں، بہتان اور تمام گناہوں سے بیزار ہوا، اور میں اسلام لایا اور میں کہتا ہوں کہ اللہ کے سوا کوئی معبود نہیں، محمد ﷺ اللہ کے رسول ہیں۔",
      },
    ];

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF121212)
          : const Color(0xFFF5F9F8),
      appBar: AppBar(
        title: const Text(
          "شش کلمے",
          style: TextStyle(fontFamily: 'Jameel Noori Nastaleeq', fontSize: 24),
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: kalimas.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: ExpansionTile(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              collapsedShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              iconColor: primaryColor,
              title: Text(
                kalimas[index]['name']!,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: primaryColor,
                  fontFamily: 'Jameel Noori Nastaleeq',
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  child: Column(
                    children: [
                      const Divider(),
                      const SizedBox(height: 10),
                      // Arabic Text
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          kalimas[index]['arabic']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Amiri',
                            height: 1.6,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Urdu Translation
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          kalimas[index]['urdu']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: isDark ? Colors.white70 : Colors.black87,
                            fontFamily: 'Jameel Noori Nastaleeq',
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
