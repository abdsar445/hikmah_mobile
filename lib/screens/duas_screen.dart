import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DuasScreen extends StatefulWidget {
  const DuasScreen({super.key});

  @override
  State<DuasScreen> createState() => _DuasScreenState();
}

class _DuasScreenState extends State<DuasScreen> {
  final Set<int> _savedIndices = {};
  int? _loadingIndex;

  // --- 50 MASNOON DUAS (Urdu Translation) ---
  final List<Map<String, String>> _duas = const [
    {
      "title": "Before Sleeping",
      "arabic": "اللَّهُمَّ بِاسْمِكَ أَمُوتُ وَأَحْيَا",
      "urdu": "اے اللہ! تیرے ہی نام سے میں مرتا ہوں اور جیتا ہوں۔",
    },
    {
      "title": "Waking Up",
      "arabic":
          "الْحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُورُ",
      "urdu":
          "تمام تعریفیں اللہ کے لئے ہیں جس نے ہمیں مارنے کے بعد زندہ کیا اور اسی کی طرف لوٹنا ہے۔",
    },
    {
      "title": "Before Eating",
      "arabic": "بِسْمِ اللَّهِ وَعَلَى بَرَكَةِ اللَّهِ",
      "urdu": "اللہ کے نام سے اور اللہ کی برکت پر۔",
    },
    {
      "title": "After Eating",
      "arabic":
          "الْحَمْدُ لِلَّهِ الَّذِي أَطْعَمَنَا وَسَقَانَا وَجَعَلَنَا مُسْلِمِينَ",
      "urdu": "شکر ہے اللہ کا جس نے ہمیں کھلایا، پلایا اور مسلمان بنایا۔",
    },
    {
      "title": "Leaving Home",
      "arabic":
          "بِسْمِ اللَّهِ تَوَكَّلْتُ عَلَى اللَّهِ، لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ",
      "urdu":
          "اللہ کے نام سے، میں نے اللہ پر بھروسہ کیا، اللہ کے سوا کوئی طاقت نہیں۔",
    },
    {
      "title": "Entering Home",
      "arabic":
          "بِسْمِ اللَّهِ وَلَجْنَا، وَبِسْمِ اللَّهِ خَرَجْنَا، وَعَلَى رَبِّنَا تَوَكَّلْنَا",
      "urdu":
          "اللہ کے نام سے ہم داخل ہوئے اور اللہ کے نام سے ہم نکلے اور اپنے رب پر بھروسہ کیا۔",
    },
    {
      "title": "Entering Mosque",
      "arabic": "اللَّهُمَّ افْتَحْ لِي أَبْوَابَ رَحْمَتِكَ",
      "urdu": "اے اللہ! میرے لئے اپنی رحمت کے دروازے کھول دے۔",
    },
    {
      "title": "Leaving Mosque",
      "arabic": "اللَّهُمَّ إِنِّي أَسْأَلُكَ مِنْ فَضْلِكَ",
      "urdu": "اے اللہ! میں تجھ سے تیرے فضل ka sawal کرتا ہوں۔",
    },
    {
      "title": "Toilet Entry",
      "arabic": "اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْخُبُثِ وَالْخَبَائِثِ",
      "urdu": "اے اللہ! میں تیری پناہ مانگتا ہوں ناپاک جنوں سے۔",
    },
    {
      "title": "Toilet Exit",
      "arabic": "غُفْرَانَكَ",
      "urdu": "اے اللہ! میں تجھ سے بخشش مانگتا ہوں۔",
    },
    {
      "title": "Before Wudu",
      "arabic": "بِسْمِ اللَّهِ",
      "urdu": "اللہ کے نام سے شروع۔",
    },
    {
      "title": "After Wudu",
      "arabic":
          "أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ",
      "urdu": "میں گواہی دیتا ہوں کہ اللہ کے سوا کوئی معبود نہیں، وہ اکیلا ہے۔",
    },
    {
      "title": "Travel Dua",
      "arabic":
          "سُبْحَانَ الَّذِي سَخَّرَ لَنَا هَذَا وَمَا كُنَّا لَهُ مُقْرِنِينَ",
      "urdu": "پاک ہے وہ ذات جس نے اس سواری کو ہمارے تابع کر دیا۔",
    },
    {
      "title": "Increase in Knowledge",
      "arabic": "رَبِّ زِدْنِي عِلْمًا",
      "urdu": "اے میرے رب! میرے علم میں اضافہ فرما۔",
    },
    {
      "title": "For Parents",
      "arabic": "رَبِّ ارْحَمْهُمَا كَمَا رَبَّيَانِي صَغِيرًا",
      "urdu":
          "اے میرے رب! ان دونوں پر رحم کر جیسا انہوں نے بچپن میں مجھے پالا۔",
    },
    {
      "title": "Grief and Anxiety",
      "arabic": "اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ",
      "urdu": "اے اللہ! میں فکر اور غم سے تیری پناہ مانگتا ہوں۔",
    },
    {
      "title": "Debt Relief",
      "arabic": "اللَّهُمَّ اكْفِنِي بِحَلَالِكَ عَنْ حَرَامِكَ",
      "urdu": "اے اللہ! مجھے حلال رزق دے کر حرام سے بچا۔",
    },
    {
      "title": "New Clothes",
      "arabic": "الْحَمْدُ لِلَّهِ الَّذِي كَسَانِي هَذَا",
      "urdu": "شکر ہے اللہ کا جس نے مجھے یہ لباس پہنایا۔",
    },
    {
      "title": "Looking in Mirror",
      "arabic": "اللَّهُمَّ أَنْتَ حَسَّنْتَ خَلْقِي فَحَسِّنْ خُلُقِي",
      "urdu": "اے اللہ! میری سیرت کو بھی میری صورت کی طرح اچھا کر دے۔",
    },
    {
      "title": "Rain Dua",
      "arabic": "اللَّهُمَّ صَيِّبًا نَافِعًا",
      "urdu": "اے اللہ! اسے نفع دینے والی بارش بنا دے۔",
    },
    {
      "title": "Fast Breaking (Iftar)",
      "arabic": "اللَّهُمَّ لَكَ صُمْتُ وَبِكَ آمَنْتُ",
      "urdu": "اے اللہ! میں نے تیرے لئے روزہ رکھا اور تجھ پر ایمان لایا۔",
    },
    {
      "title": "Morning Dua",
      "arabic": "اللَّهُمَّ بِكَ أَصْبَحْنَا وَبِكَ أَمْسَيْنَا",
      "urdu": "اے اللہ! تیری ہی توفیق سے ہم نے صبح کی اور شام کی۔",
    },
    {
      "title": "Evening Dua",
      "arabic": "اللَّهُمَّ بِكَ أَمْسَيْنَا وَبِكَ أَصْبَحْنَا",
      "urdu": "اے اللہ! تیری ہی توفیق سے ہم نے شام کی اور صبح کی۔",
    },
    {
      "title": "Against Enemies",
      "arabic": "اللَّهُمَّ إِنَّا نَجْعَلُكَ فِي نُحُورِهِمْ",
      "urdu": "اے اللہ! ہم تجھے ان کے مقابلے میں لاتے ہیں۔",
    },
    {
      "title": "Visiting Sick",
      "arabic": "لَا بَأْسَ طَهُورٌ إِنْ شَاءَ اللَّهُ",
      "urdu": "کوئی بات نہیں، یہ بیماری گناہوں سے پاک کرنے والی ہے۔",
    },
    {
      "title": "Forgiveness",
      "arabic": "أَسْتَغْفِرُ اللَّهَ رَبِّي مِنْ كُلِّ ذَنْبٍ",
      "urdu": "میں اللہ سے معافی مانگتا ہوں جو میرا رب ہے ہر گناہ سے۔",
    },
    {
      "title": "Success in Exams",
      "arabic": "رَبِّ اشْرَحْ لِي صَدْرِي",
      "urdu": "اے میرے رب! میرا سینہ کھول دے۔",
    },
    {
      "title": "Firm Faith",
      "arabic": "يَا مُقَلِّبَ الْقُلُوبِ ثَبِّتْ قَلْبِي عَلَى دِينِكَ",
      "urdu": "اے دلوں کو پھیرنے والے! میرے دل کو اپنے دین پر ثابت قدم رکھ۔",
    },
    {
      "title": "Seeking Jannah",
      "arabic": "اللَّهُمَّ إِنِّي أَسْأَلُكَ الْجَنَّةَ",
      "urdu": "اے اللہ! میں تجھ سے جنت کا سوال کرتا ہوں۔",
    },
    {
      "title": "Protection from Hell",
      "arabic": "اللَّهُمَّ أَجِرْنِي مِنَ النَّارِ",
      "urdu": "اے اللہ! مجھے آگ کے عذاب سے بچا لے۔",
    },
    {
      "title": "Good News",
      "arabic": "الْحَمْدُ لِلَّهِ الَّذِي بِنِعْمَتِهِ تَتِمُّ الصَّالِحَاتُ",
      "urdu":
          "تمام تعریفیں اللہ کے لئے ہیں جس کی نعمت سے اچھے کام مکمل ہوتے ہیں۔",
    },
    {
      "title": "On Sneezing",
      "arabic": "الْحَمْدُ لِلَّهِ",
      "urdu": "تمام تعریفیں اللہ کے لئے ہیں۔",
    },
    {
      "title": "Response to Sneeze",
      "arabic": "يَرْحَمُكَ اللَّهُ",
      "urdu": "اللہ تم پر رحم فرمائے۔",
    },
    {
      "title": "Entering Market",
      "arabic": "لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِیکَ لَهُ",
      "urdu": "اللہ کے سوا کوئی معبود نہیں، وہ اکیلا ہے۔",
    },
    {
      "title": "During Affliction",
      "arabic": "إِنَّا لِلَّهِ وَإِنَّا إِلَيْهِ رَاجِعُونَ",
      "urdu": "ہم اللہ کے ہیں اور ہمیں اسی کی طرف لوٹ کر جانا ہے۔",
    },
    {
      "title": "Durood Sharif",
      "arabic": "اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ",
      "urdu": "اے اللہ! رحمت نازل فرما محمد ﷺ پر اور ان کی آل پر۔",
    },
    {
      "title": "Good in Both Worlds",
      "arabic":
          "رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً",
      "urdu": "اے ہمارے رب! ہمیں دنیا اور آخرت میں بھلائی عطا کر۔",
    },
    {
      "title": "Istikhara Dua",
      "arabic": "اللَّهُمَّ خِرْ لِي وَاخْتَرْ لِي",
      "urdu": "اے اللہ! میرے لئے خیر فرما اور میرا انتخاب کر۔",
    },
    {
      "title": "Against Evil Eye",
      "arabic": "أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّةِ",
      "urdu": "میں اللہ کے کامل کلمات کے ذریعے پناہ مانگتا ہوں۔",
    },
    {
      "title": "Bad Thoughts",
      "arabic": "أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ",
      "urdu": "میں اللہ کی پناہ مانگتا ہوں شیطان مردود سے۔",
    },
    {
      "title": "Steadfastness",
      "arabic": "حَسْبُنَا اللَّهُ وَنِعْمَ الْوَكِيلُ",
      "urdu": "ہمارے لئے اللہ کافی ہے اور وہ بہترین کارساز ہے۔",
    },
    {
      "title": "Healing Dua",
      "arabic":
          "أَسْأَلُ اللَّهَ الْعَظِيمَ رَبَّ الْعَرْشِ الْعَظِيمِ أَنْ يَشْفِيَكَ",
      "urdu": "میں اللہ عظیم سے سوال کرتا ہوں کہ وہ تجھے شفا دے۔",
    },
    {
      "title": "Leaving Gathering",
      "arabic": "سُبْحَانَكَ اللَّهُمَّ وَبِحَمْدِكَ",
      "urdu": "پاک ہے تو اے اللہ اپنی تعریفوں کے ساتھ۔",
    },
    {
      "title": "New Moon",
      "arabic": "اللَّهُمَّ أَهِلَّهُ عَلَيْنَا بِالْأَمْنِ وَالْإِيمَانِ",
      "urdu": "اے اللہ! اس چاند کو ہم پر امن اور ایمان کے ساتھ نکال۔",
    },
    {
      "title": "After Milk",
      "arabic": "اللَّهُمَّ بَارِكْ لَنَا فِيهِ وَزِدْنَا مِنْهُ",
      "urdu": "اے اللہ! ہمارے لئے اس میں برکت دے اور مزید عطا کر۔",
    },
    {
      "title": "Protection",
      "arabic": "بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ",
      "urdu": "اللہ کے نام سے، جس کے نام کی برکت سے کوئی چیز نقصان نہیں دیتی۔",
    },
    {
      "title": "Sayyidul Istighfar",
      "arabic": "اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ",
      "urdu": "اے اللہ! تو میرا رب ہے، تیرے سوا کوئی معبود نہیں۔",
    },
    {
      "title": "During Fear",
      "arabic": "لَا إِلَهَ إِلَّا اللَّهُ",
      "urdu": "اللہ کے سوا کوئی معبود نہیں۔",
    },
    {
      "title": "Sajda Tilawat",
      "arabic": "سَجَدَ وَجْهِي لِلَّذِي خَلَقَهُ",
      "urdu": "میرے چہرے نے اس کے لئے سجدہ کیا جس نے اسے پیدا کیا۔",
    },
    {
      "title": "After Adhan",
      "arabic": "اللَّهُمَّ رَبَّ هَذِهِ الدَّعْوَةِ التَّامَّةِ",
      "urdu": "اے اللہ! اس کامل پکار کے رب، محمد ﷺ کو وسیلہ عطا فرما۔",
    },
  ];

  // --- SAVE BOOKMARK (MANDATORY RULE 1 & 3 COMPLIANCE) ---
  Future<void> _saveBookmark(int index, Map<String, String> dua) async {
    if (_savedIndices.contains(index)) return;

    setState(() => _loadingIndex = index);

    final auth = FirebaseAuth.instance;
    final db = FirebaseFirestore.instance;

    try {
      // RULE 3: AUTH FIRST
      User? user = auth.currentUser;
      if (user == null) {
        final cred = await auth.signInAnonymously();
        user = cred.user;
      }

      if (user == null) throw Exception("Auth Failed");

      // RULE 1: STRICT PATH COMPLIANCE (Must be /artifacts/{appId}/users/{userId}/{collectionName})
      const String appId = "hikmah-ai-app";
      final String userId = user.uid;

      await db
          .collection('artifacts')
          .doc(appId)
          .collection('users')
          .doc(userId)
          .collection('bookmarks')
          .add({
            'title': dua['title'],
            'arabic': dua['arabic'],
            'urdu': dua['urdu'],
            'timestamp': FieldValue.serverTimestamp(),
          });

      setState(() {
        _savedIndices.add(index);
        _loadingIndex = null;
      });

      _showMsg("Saved Successfully!", const Color(0xFF006D5B));
    } catch (e) {
      setState(() => _loadingIndex = null);
      _showMsg("Permission Denied: Check Firestore Rules.", Colors.red);
      print("Firestore Error: $e");
    }
  }

  void _showMsg(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    _showMsg("Copied to Clipboard", Colors.green);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const primaryColor = Color(0xFF006D5B);
    final cardColor = isDark ? const Color(0xFF1A1A1A) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0D0D0D)
          : const Color(0xFFF5F8F5),
      appBar: AppBar(
        title: const Text(
          "Masnoon Duain",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _duas.length,
        itemBuilder: (context, index) {
          final dua = _duas[index];
          final bool isSaved = _savedIndices.contains(index);
          final bool isLoading = _loadingIndex == index;

          return Card(
            color: cardColor,
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ExpansionTile(
              iconColor: primaryColor,
              tilePadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              leading: CircleAvatar(
                backgroundColor: primaryColor.withOpacity(0.1),
                child: Text(
                  "${index + 1}",
                  style: const TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                dua['title']!,
                style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        dua['arabic']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontFamily: 'Amiri',
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        dua['urdu']!,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 17,
                          color: textColor.withOpacity(0.85),
                          fontFamily: 'Jameel Noori Nastaleeq',
                          height: 1.6,
                        ),
                      ),
                      const Divider(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _actionBtn(
                            Icons.copy,
                            "Copy",
                            () => _copyText("${dua['arabic']}\n${dua['urdu']}"),
                          ),
                          isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: primaryColor,
                                  ),
                                )
                              : _actionBtn(
                                  isSaved
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  isSaved ? "Saved" : "Save",
                                  () => _saveBookmark(index, dua),
                                  active: isSaved,
                                ),
                          _actionBtn(
                            Icons.share,
                            "Share",
                            () => _showMsg("Coming Soon", Colors.blue),
                          ),
                        ],
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

  Widget _actionBtn(
    IconData icon,
    String label,
    VoidCallback onTap, {
    bool active = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: active ? const Color(0xFF006D5B) : Colors.grey,
            size: 26,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: active ? const Color(0xFF006D5B) : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
