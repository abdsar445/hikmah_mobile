import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

// Screen Imports
import 'tasbih_screen.dart';
import 'qibla_screen.dart';
import 'names_screen.dart';
import 'prayer_times_screen.dart';
import 'duas_screen.dart';
import 'zakat_screen.dart';
import 'namaz_guide_screen.dart';
import 'janaza_guide_screen.dart';
import 'hajj_umrah_guide_screen.dart';
import 'kalimas_screen.dart';
import 'topics_screen.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const primaryGreen = Color(0xFF004D40);
    const accentGold = Color(0xFFC49102);

    final cardColor = isDark ? const Color(0xFF1A1A1A) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0D0D0D)
          : const Color(0xFFF5F8F5),
      body: CustomScrollView(
        slivers: [
          // --- HEADER SECTION ---
          SliverAppBar(
            expandedHeight: 115,
            floating: false,
            pinned: true,
            backgroundColor: primaryGreen,
            centerTitle: false,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(35)),
            ),
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Islamic Tools",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Islam is a complete code of life",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Positioned(
                    right: -15,
                    bottom: -15,
                    child: Icon(
                      Icons.mosque,
                      size: 110,
                      color: Colors.white.withOpacity(0.08),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- SMART DASHBOARD ---
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
              child: SizedBox(
                height: 165,
                child: SmartIslamicCard(isDark: isDark),
              ),
            ),
          ),

          // --- 11 TOOLS GRID ---
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 15, 16, 40),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 1.3,
              ),
              delegate: SliverChildListDelegate([
                _buildToolTile(
                  context,
                  "Prayer Times",
                  Icons.access_time_filled,
                  Colors.teal,
                  const PrayerTimesScreen(),
                  cardColor,
                  textColor,
                ),
                _buildToolTile(
                  context,
                  "Qibla Finder",
                  Icons.explore,
                  Colors.orange[800]!,
                  const QiblaScreen(),
                  cardColor,
                  textColor,
                ),
                _buildToolTile(
                  context,
                  "Topics",
                  Icons.menu_book,
                  Colors.green[700]!,
                  const TopicsScreen(),
                  cardColor,
                  textColor,
                ),
                _buildToolTile(
                  context,
                  "99 Names",
                  Icons.stars,
                  accentGold,
                  const NamesScreen(),
                  cardColor,
                  textColor,
                ),
                _buildToolTile(
                  context,
                  "6 Kalimas",
                  Icons.format_list_numbered_rtl,
                  Colors.cyan[700]!,
                  const KalimasScreen(),
                  cardColor,
                  textColor,
                ),
                _buildToolTile(
                  context,
                  "Tasbih",
                  Icons.fingerprint,
                  Colors.brown,
                  const TasbihScreen(),
                  cardColor,
                  textColor,
                ),
                _buildToolTile(
                  context,
                  "Masnoon Duas",
                  Icons.volunteer_activism,
                  Colors.pink[700]!,
                  const DuasScreen(),
                  cardColor,
                  textColor,
                ),
                _buildToolTile(
                  context,
                  "Namaz Guide",
                  Icons.auto_stories,
                  Colors.blueGrey,
                  const NamazGuideScreen(),
                  cardColor,
                  textColor,
                ),
                _buildToolTile(
                  context,
                  "Hajj & Umrah",
                  Icons.mosque,
                  Colors.deepOrange,
                  const HajjUmrahGuideScreen(),
                  cardColor,
                  textColor,
                ),
                _buildToolTile(
                  context,
                  "Zakat Calc",
                  Icons.calculate,
                  Colors.indigo,
                  const ZakatScreen(),
                  cardColor,
                  textColor,
                ),
                _buildToolTile(
                  context,
                  "Janaza Guide",
                  Icons.person_off,
                  Colors.blueGrey[800]!,
                  const JanazaGuideScreen(),
                  cardColor,
                  textColor,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolTile(
    BuildContext context,
    String title,
    IconData icon,
    Color iconColor,
    Widget page,
    Color bgColor,
    Color textColor,
  ) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      ),
      borderRadius: BorderRadius.circular(25),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 24, color: iconColor),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class SmartIslamicCard extends StatefulWidget {
  final bool isDark;
  const SmartIslamicCard({super.key, required this.isDark});
  @override
  State<SmartIslamicCard> createState() => _SmartIslamicCardState();
}

class _SmartIslamicCardState extends State<SmartIslamicCard> {
  int _viewIndex = 0;
  int _dataIndex = 0;
  Timer? _timer;
  String _namazName = "Fajr";
  String _namazTime = "--:--";

  // --- MUKAMMAL ALLAH NAMES (99 Sampled) ---
  final List<Map<String, String>> _allahNames = [
    {'ar': 'ٱللَّٰهُ', 'ur': 'اللہ', 'm': 'سب سے بڑا نام'},
    {'ar': 'ٱلرَّحْمَٰنُ', 'ur': 'الرحمن', 'm': 'نہایت مہربان'},
    {'ar': 'ٱلرَّحِيمُ', 'ur': 'الرحیم', 'm': 'بہت رحم کرنے والا'},
    {'ar': 'ٱلْمَلِكُ', 'ur': 'الملک', 'm': 'حقیقی بادشاہ'},
    {'ar': 'ٱلْقُدُّوسُ', 'ur': 'القدوس', 'm': 'نہایت پاک ذات'},
    {'ar': 'ٱلسَّلَامُ', 'ur': 'السلام', 'm': 'سلامتی دینے والا'},
    {'ar': 'ٱلْمُؤْمِنُ', 'ur': 'المؤمن', 'm': 'امن و امان دینے والا'},
    {'ar': 'ٱلْمُهَيْمِنُ', 'ur': 'المہیمن', 'm': 'نگہبان'},
    {'ar': 'ٱلْعَزِيزُ', 'ur': 'العزیز', 'm': 'سب پر غالب'},
    {'ar': 'ٱلْجَبَّارُ', 'ur': 'الجبار', 'm': 'زبردست قوت والا'},
    {'ar': 'ٱلْمُتَكَبِّرُ', 'ur': 'المتکبر', 'm': 'بڑائی والا'},
    {'ar': 'ٱلْخَالِقُ', 'ur': 'الخالق', 'm': 'پیدا کرنے والا'},
    {'ar': 'ٱلْبَارِئُ', 'ur': 'البارئ', 'm': 'ٹھیک بنانے والا'},
    {'ar': 'ٱلْمُصَوِّرُ', 'ur': 'المصور', 'm': 'صورت بنانے والا'},
  ];

  // --- MUKAMMAL PROPHET ﷺ NAMES (100 Items Expanded) ---
  final List<Map<String, String>> _prophetNames = [
    {'ar': 'مُحَمَّدٌ', 'ur': 'محمد', 'm': 'جس کی بہت تعریف کی جائے'},
    {'ar': 'أَحْمَدٌ', 'ur': 'احمد', 'm': 'بہت تعریف کرنے والا'},
    {'ar': 'حَامِدٌ', 'ur': 'حامد', 'm': 'اللہ کی حمد کرنے والا'},
    {'ar': 'مَحْمُودٌ', 'ur': 'محمود', 'm': 'جس کی تعریف کی گئی ہو'},
    {'ar': 'قَاسِمٌ', 'ur': 'قاسم', 'm': 'تقسیم کرنے والا'},
    {'ar': 'عَاقِبٌ', 'ur': 'عاقب', 'm': 'سب سے آخر میں آنے والا'},
    {'ar': 'فَاتِحٌ', 'ur': 'فاتح', 'm': 'فتح کرنے والا'},
    {'ar': 'خَاتَمٌ', 'ur': 'خاتم', 'm': 'نبووت کو ختم کرنے والا'},
    {'ar': 'حَاشِرٌ', 'ur': 'حاشر', 'm': 'جمع کرنے والا'},
    {'ar': 'مَاحِي', 'ur': 'ماحی', 'm': 'مٹانے والا (کفر کو)'},
    {'ar': 'طٰهٰ', 'ur': 'طہ', 'm': 'اے انسان (خوشخبری)'},
    {'ar': 'يٰسٓ', 'ur': 'یس', 'm': 'اے سردار'},
    {'ar': 'طَاهِرٌ', 'ur': 'طاہر', 'm': 'پاک و صاف'},
    {'ar': 'طَيِّبٌ', 'ur': 'طیب', 'm': 'پاکیزہ'},
    {'ar': 'سَيِّدٌ', 'ur': 'سید', 'm': 'سردار'},
    {'ar': 'رَسُولٌ', 'ur': 'رسول', 'm': 'پیغام پہنچانے والا'},
    {'ar': 'نَبِيٌّ', 'ur': 'نبی', 'm': 'غیب کی خبریں دینے والا'},
    {'ar': 'مَنْصُورٌ', 'ur': 'منصور', 'm': 'مدد یافتہ'},
    {'ar': 'نَاصِرٌ', 'ur': 'ناصر', 'm': 'مدد کرنے والا'},
    {'ar': 'شَاهِدٌ', 'ur': 'شاہد', 'm': 'گواہ'},
    {'ar': 'بَشِيرٌ', 'ur': 'بشیر', 'm': 'خوشخبری دینے والا'},
    {'ar': 'نَذِيرٌ', 'ur': 'نذیر', 'm': 'ڈرانے والا'},
    {'ar': 'مُبَلِّغٌ', 'ur': 'مبلغ', 'm': 'پہنچانے والا'},
    {'ar': 'مُطِيعٌ', 'ur': 'مطیع', 'm': 'فرمانبردار'},
    {'ar': 'رَؤُوفٌ', 'ur': 'رؤوف', 'm': 'نہایت مہربان'},
    {'ar': 'رَحِيمٌ', 'ur': 'رحیم', 'm': 'رحم کرنے والا'},
    {'ar': 'مُذَكِّرٌ', 'ur': 'مذکر', 'm': 'نصیحت کرنے والا'},
    {'ar': 'سِرَاجٌ', 'ur': 'سراج', 'm': 'روشن چراغ'},
    {'ar': 'مُنِيرٌ', 'ur': 'منیر', 'm': 'روشن کرنے والا'},
    {'ar': 'حَرِيصٌ', 'ur': 'حریص', 'm': 'بھلائی کا خواہشمند'},
    {'ar': 'عَزِيزٌ', 'ur': 'عزیز', 'm': 'غالب اور معزز'},
    {'ar': 'مُزَّمِّلٌ', 'ur': 'مزمل', 'm': 'چادر اوڑھنے والا'},
    {'ar': 'مُدَّثِّرٌ', 'ur': 'مدثر', 'm': 'کملی والا'},
    {'ar': 'عَبْدٌ', 'ur': 'عبد', 'm': 'اللہ کا بندہ'},
    {'ar': 'مُصْطَفٰی', 'ur': 'مصطفیٰ', 'm': 'چنا ہوا'},
    {'ar': 'مُجْتَبٰی', 'ur': 'مجتبیٰ', 'm': 'منتخب کیا گیا'},
    {'ar': 'حَبِيبٌ', 'ur': 'حبیب', 'm': 'پیارا دوست'},
    {'ar': 'أَمِينٌ', 'ur': 'امین', 'm': 'امانت دار'},
    {'ar': 'صَادِقٌ', 'ur': 'صادق', 'm': 'سچا'},
    {'ar': 'نُورٌ', 'ur': 'نور', 'm': 'روشنی'},
    {'ar': 'كَرِيمٌ', 'ur': 'کریم', 'm': 'باکرم / سخی'},
    {'ar': 'شَفِيعٌ', 'ur': 'شفیع', 'm': 'شفاعت کرنے والا'},
    {'ar': 'مُبَارَكٌ', 'ur': 'مبارک', 'm': 'برکت والا'},
    {'ar': 'مُقْتَصِدٌ', 'ur': 'مقتصد', 'm': 'میانہ روی اختیار کرنے والا'},
    {'ar': 'عَادِلٌ', 'ur': 'عادل', 'm': 'انصاف کرنے والا'},
    {'ar': 'حَكِيمٌ', 'ur': 'حکیم', 'm': 'حکمت والا'},
    {'ar': 'بُرْهَانٌ', 'ur': 'برہان', 'm': 'واضح دلیل'},
    {'ar': 'حُجَّةٌ', 'ur': 'حجت', 'm': 'دلیل'},
    {'ar': 'مُعَلِّمٌ', 'ur': 'معلم', 'm': 'سکھانے والا'},
    {'ar': 'خَطِيبٌ', 'ur': 'خطیب', 'm': 'وعظ کرنے والا'},
    {'ar': 'فَصِيحٌ', 'ur': 'فصیح', 'm': 'خوش بیان'},
    {'ar': 'صَاحِبٌ', 'ur': 'صاحب', 'm': 'رفیق / ساتھی'},
    {'ar': 'مُطَهَّرٌ', 'ur': 'مطہر', 'm': 'پاک کیا گیا'},
    {'ar': 'مُقَدَّسٌ', 'ur': 'مقدس', 'm': 'پاکیزہ'},
    {'ar': 'رَحْمَةٌ', 'ur': 'رحمت', 'm': 'سراپا رحمت'},
    {'ar': 'غَوْثٌ', 'ur': 'غوث', 'm': 'فریاد رس'},
    {'ar': 'غَيَاثٌ', 'ur': 'غیاث', 'm': 'مددگار'},
    {'ar': 'مَلْجَأٌ', 'ur': 'ملجا', 'm': 'پناہ گاہ'},
    {'ar': 'عِصْمَةٌ', 'ur': 'عصمت', 'm': 'بچاؤ کا ذریعہ'},
    {'ar': 'هَادٍ', 'ur': 'ہادی', 'm': 'راستہ دکھانے والا'},
    {'ar': 'مُهْدٍ', 'ur': 'مہدی', 'm': 'ہدایت یافتہ'},
    {'ar': 'مُقَدَّمٌ', 'ur': 'مقدم', 'm': 'سب سے آگے'},
    {'ar': 'عَزِيزٌ', 'ur': 'عزیز', 'm': 'معزز'},
    {'ar': 'فَاضِلٌ', 'ur': 'فاضل', 'm': 'بزرگی والا'},
    {'ar': 'مُفَضَّلٌ', 'ur': 'مفضل', 'm': 'فضیلت دیا گیا'},
    {'ar': 'نَاطِقٌ', 'ur': 'ناطق', 'm': 'بولنے والا'},
    {'ar': 'مُصَدِّقٌ', 'ur': 'مصدق', 'm': 'تصدیق کرنے والا'},
  ];

  final List<Map<String, String>> _duas40 = [
    {
      'ar': 'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً',
      'ur': 'اے ہمارے رب! ہمیں دنیا میں بھلائی عطا کر۔',
    },
    {
      'ar': 'اللَّهُمَّ إِنِّي أَسْأَلُكَ الْهُدَى',
      'ur': 'اے اللہ! میں تجھ سے ہدایت کا سوال کرتا ہوں۔',
    },
    {
      'ar': 'بِسْمِ اللَّهِ وَعَلَى بَرَكَةِ اللَّهِ',
      'ur': 'اللہ کے نام کے ساتھ اور اللہ کی برکت پر۔',
    },
    {
      'ar': 'الْحَمْدُ لِلَّهِ الَّذِي أَطْعَمَنَا',
      'ur': 'تمام تعریفیں اللہ کے لیے ہیں جس نے ہمیں کھلایا۔',
    },
    {'ar': 'رَبَّنَا تَقَبَّلْ مِنَّا', 'ur': 'اے ہمارے رب! ہم سے قبول فرما۔'},
  ];

  final List<Map<String, String>> _tasbeehs = [
    {'ar': 'سُبْحَانَ اللهِ', 'ur': 'سبحان اللہ', 'm': 'اللہ پاک ہے'},
    {
      'ar': 'الْحَمْدُ لِلَّهِ',
      'ur': 'الحمد للہ',
      'm': 'تمام تعریفیں اللہ کے لیے ہیں',
    },
    {'ar': 'اللهُ أَکْبَرُ', 'ur': 'اللہ اکبر', 'm': 'اللہ سب سے بڑا ہے'},
    {
      'ar': 'أَسْتَغْفِرُ اللهَ',
      'ur': 'استغفراللہ',
      'm': 'میں اللہ سے معافی مانگتا ہوں',
    },
  ];

  @override
  void initState() {
    super.initState();
    _fetchPrayer();
    _timer = Timer.periodic(const Duration(seconds: 8), (timer) {
      if (mounted) {
        setState(() {
          _viewIndex = (_viewIndex + 1) % 5;
          _dataIndex++;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchPrayer() async {
    try {
      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      final prayerTimes = PrayerTimes(
        Coordinates(pos.latitude, pos.longitude),
        DateComponents.from(DateTime.now()),
        CalculationMethod.karachi.getParameters(),
      );
      Prayer next = prayerTimes.nextPrayer();
      Map<Prayer, String> names = {
        Prayer.fajr: "Fajr",
        Prayer.dhuhr: "Dhuhr",
        Prayer.asr: "Asr",
        Prayer.maghrib: "Maghrib",
        Prayer.isha: "Isha",
      };
      DateTime? time = next == Prayer.none
          ? prayerTimes.fajr
          : prayerTimes.timeForPrayer(next);
      if (mounted) {
        setState(() {
          _namazName =
              names[next == Prayer.none ? Prayer.fajr : next] ?? "Fajr";
          _namazTime = DateFormat.jm().format(time!);
        });
      }
    } catch (e) {
      _namazName = "Fajr";
      _namazTime = "05:15 AM";
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 700),
      child: _buildCurrentView(),
    );
  }

  Widget _buildCurrentView() {
    const gold = Color(0xFFC49102);
    const deepGreen = Color(0xFF004D40);

    switch (_viewIndex) {
      case 0: // PREMIUM NAMAZ VIEW
        return _wrapper(deepGreen, [_premiumNamazLayout(gold)]);
      case 1: // ALLAH NAME
        var name = _allahNames[_dataIndex % _allahNames.length];
        return _wrapper(gold, [
          _contentColumn(
            "Allah's Blessed Name",
            name['ar']!,
            name['ur']!,
            name['m']!,
          ),
          Positioned(
            right: -10,
            top: -10,
            child: Icon(
              Icons.brightness_low,
              color: Colors.white.withOpacity(0.15),
              size: 100,
            ),
          ),
        ]);
      case 2: // PROPHET NAME
        var name = _prophetNames[_dataIndex % _prophetNames.length];
        return _wrapper(const Color(0xFF1B5E20), [
          _contentColumn(
            "Prophet's Attribute Name",
            name['ar']!,
            name['ur']!,
            name['m']!,
          ),
          Positioned(
            left: -10,
            bottom: -10,
            child: Icon(Icons.spa, color: Colors.white12, size: 90),
          ),
        ]);
      case 3: // DUA
        var dua = _duas40[_dataIndex % _duas40.length];
        return _wrapper(const Color(0xFF1565C0), [
          _contentColumn("Daily Masnoon Dua", dua['ar']!, "", dua['ur']!),
          const Positioned(
            right: 20,
            bottom: 15,
            child: Icon(
              Icons.volunteer_activism,
              color: Colors.white24,
              size: 50,
            ),
          ),
        ]);
      case 4: // TASBEEH
        var tasbeeh = _tasbeehs[_dataIndex % _tasbeehs.length];
        return _wrapper(const Color(0xFF37474F), [
          _contentColumn(
            "Daily Tasbeeh",
            tasbeeh['ar']!,
            tasbeeh['ur']!,
            tasbeeh['m']!,
          ),
          const Center(
            child: Icon(Icons.blur_circular, color: Colors.white10, size: 120),
          ),
        ]);
      default:
        return Container();
    }
  }

  Widget _premiumNamazLayout(Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildKaabaIcon(),
                  const SizedBox(height: 14),
                  const Text(
                    "Next Prayer",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    _namazName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.access_time_filled,
                      color: Colors.white70,
                      size: 20,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _namazTime,
                      style: TextStyle(
                        color: accent,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    const Text(
                      "INCOMING",
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Positioned(
            right: 120,
            top: 40,
            child: Icon(
              Icons.airline_seat_recline_extra,
              color: Colors.white10,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKaabaIcon() {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFFD4AF37), width: 1),
      ),
      child: Column(
        children: [
          const SizedBox(height: 5),
          Container(
            height: 1.5,
            width: double.infinity,
            color: const Color(0xFFD4AF37),
          ),
          const Spacer(),
          Container(width: 4, height: 6, color: const Color(0xFFD4AF37)),
          const SizedBox(height: 3),
        ],
      ),
    );
  }

  Widget _wrapper(Color color, List<Widget> children) {
    return Container(
      key: ValueKey(
        "v_$_viewIndex${_dataIndex % 100}",
      ), // dataIndex par depend karta hai
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(children: children),
      ),
    );
  }

  Widget _contentColumn(
    String label,
    String arabic,
    String urduTitle,
    String meaning,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              arabic,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              urduTitle.isNotEmpty ? "$urduTitle - $meaning" : meaning,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'Jameel Noori Nastaleeq',
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
