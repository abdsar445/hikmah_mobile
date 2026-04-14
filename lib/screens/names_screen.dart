import 'package:flutter/material.dart';

class NamesScreen extends StatelessWidget {
  const NamesScreen({super.key});

  // --- ALLAH'S 99 NAMES (Complete with Urdu Meanings) ---
  final List<Map<String, String>> _allahNames = const [
    {'arabic': 'ٱللَّٰهُ', 'urdu_title': 'اللہ', 'meaning': 'سب سے بڑا نام'},
    {
      'arabic': 'ٱلرَّحْمَٰنُ',
      'urdu_title': 'الرحمن',
      'meaning': 'نہایت مہربان',
    },
    {
      'arabic': 'ٱلرَّحِيمُ',
      'urdu_title': 'الرحیم',
      'meaning': 'بہت رحم کرنے والا',
    },
    {'arabic': 'ٱلْمَلِكُ', 'urdu_title': 'الملک', 'meaning': 'حقیقی بادشاہ'},
    {
      'arabic': 'ٱلْقُدُّوسُ',
      'urdu_title': 'القدوس',
      'meaning': 'نہایت پاک ذات',
    },
    {
      'arabic': 'ٱلسَّلَامُ',
      'urdu_title': 'السلام',
      'meaning': 'سلامتی دینے والا',
    },
    {
      'arabic': 'ٱلْمُؤْمِنُ',
      'urdu_title': 'المؤمن',
      'meaning': 'امن و امان دینے والا',
    },
    {'arabic': 'ٱلْمُهَيْمِنُ', 'urdu_title': 'المہیمن', 'meaning': 'نگہبان'},
    {'arabic': 'ٱلْعَزِيزُ', 'urdu_title': 'العزیز', 'meaning': 'سب پر غالب'},
    {
      'arabic': 'ٱلْجَبَّارُ',
      'urdu_title': 'الجبار',
      'meaning': 'زبردست قوت والا',
    },
    {
      'arabic': 'ٱلْمُتَكَبِّرُ',
      'urdu_title': 'المتکبر',
      'meaning': 'بڑائی والا',
    },
    {
      'arabic': 'ٱلْخَالِقُ',
      'urdu_title': 'الخالق',
      'meaning': 'پیدا کرنے والا',
    },
    {
      'arabic': 'ٱلْبَارِئُ',
      'urdu_title': 'البارئ',
      'meaning': 'ٹھیک بنانے والا',
    },
    {
      'arabic': 'ٱلْمُصَوِّرُ',
      'urdu_title': 'المصور',
      'meaning': 'صورت بنانے والا',
    },
    {
      'arabic': 'ٱلْغَفَّارُ',
      'urdu_title': 'الغفار',
      'meaning': 'بہت بخشنے والا',
    },
    {'arabic': 'ٱلْقَهَّارُ', 'urdu_title': 'القعار', 'meaning': 'سب پر غالب'},
    {
      'arabic': 'ٱلْوَهَّابُ',
      'urdu_title': 'الوہاب',
      'meaning': 'خوب عطا کرنے والا',
    },
    {
      'arabic': 'ٱلرَّزَّاقُ',
      'urdu_title': 'الرزاق',
      'meaning': 'رزق دینے والا',
    },
    {'arabic': 'ٱلْفَتَّاحُ', 'urdu_title': 'الفتاح', 'meaning': 'کھولنے والا'},
    {
      'arabic': 'ٱلْعَلِيمُ',
      'urdu_title': 'العلیم',
      'meaning': 'سب کچھ جاننے والا',
    },
    {
      'arabic': 'ٱلْقَابِضُ',
      'urdu_title': 'القابض',
      'meaning': 'تنگی کرنے والا',
    },
    {
      'arabic': 'ٱلْبَاسِطُ',
      'urdu_title': 'الباسط',
      'meaning': 'فراخی دینے والا',
    },
    {
      'arabic': 'ٱلْخَافِضُ',
      'urdu_title': 'الخافض',
      'meaning': 'پست کرنے والا',
    },
    {
      'arabic': 'ٱلرَّافِعُ',
      'urdu_title': 'الرافع',
      'meaning': 'بلند کرنے والا',
    },
    {'arabic': 'ٱلْمُعِزُّ', 'urdu_title': 'المعز', 'meaning': 'عزت دینے والا'},
    {'arabic': 'ٱلْمُذِلُّ', 'urdu_title': 'المذل', 'meaning': 'ذلت دینے والا'},
    {
      'arabic': 'ٱلسَّمِيعُ',
      'urdu_title': 'السمیع',
      'meaning': 'سب کچھ سننے والا',
    },
    {
      'arabic': 'ٱلْبَصِيرُ',
      'urdu_title': 'البصیر',
      'meaning': 'سب کچھ دیکھنے والا',
    },
    {
      'arabic': 'ٱلْحَكَمُ',
      'urdu_title': 'الحکم',
      'meaning': 'فیصلہ کرنے والا',
    },
    {'arabic': 'ٱلْعَدْلُ', 'urdu_title': 'العدل', 'meaning': 'سراپا انصاف'},
    {
      'arabic': 'ٱللَّطِيفُ',
      'urdu_title': 'اللطیف',
      'meaning': 'مہربان / باریک بین',
    },
    {'arabic': 'ٱلْخَبِيرُ', 'urdu_title': 'الخبیر', 'meaning': 'باخبر'},
    {'arabic': 'ٱلْحَلِيمُ', 'urdu_title': 'الحلیم', 'meaning': 'نہایت بردبار'},
    {
      'arabic': 'ٱلْعَظِيمُ',
      'urdu_title': 'العظیم',
      'meaning': 'بڑی عظمت والا',
    },
    {
      'arabic': 'ٱلْغَفُورُ',
      'urdu_title': 'الغفور',
      'meaning': 'معاف کرنے والا',
    },
    {'arabic': 'ٱلشَّكُورُ', 'urdu_title': 'الشکور', 'meaning': 'قدردان'},
    {'arabic': 'ٱلْعَلِيُّ', 'urdu_title': 'العلی', 'meaning': 'سب سے بلند'},
    {'arabic': 'ٱلْكَبِيرُ', 'urdu_title': 'الکبیر', 'meaning': 'بہت بڑا'},
    {
      'arabic': 'ٱلْحَفِيظُ',
      'urdu_title': 'الحفیظ',
      'meaning': 'حفاظت کرنے والا',
    },
    {
      'arabic': 'ٱلْمُقِيتُ',
      'urdu_title': 'المقیت',
      'meaning': 'روزی پہنچانے والا',
    },
    {
      'arabic': 'ٱلْحَسِيبُ',
      'urdu_title': 'الحسیب',
      'meaning': 'کفایت کرنے والا',
    },
    {'arabic': 'ٱلْجَلِيلُ', 'urdu_title': 'الجلیل', 'meaning': 'بزرگ و برتر'},
    {
      'arabic': 'ٱلْكَرِيمُ',
      'urdu_title': 'الکریم',
      'meaning': 'کرم کرنے والا',
    },
    {'arabic': 'ٱلرَّقِيبُ', 'urdu_title': 'الرقیب', 'meaning': 'نگہبان'},
    {
      'arabic': 'ٱلْمُجِيبُ',
      'urdu_title': 'المجیب',
      'meaning': 'قبول کرنے والا',
    },
    {'arabic': 'ٱلْوَاسِعُ', 'urdu_title': 'الواسع', 'meaning': 'وسعت والا'},
    {'arabic': 'ٱلْحَكِيمُ', 'urdu_title': 'الحکیم', 'meaning': 'حکمت والا'},
    {
      'arabic': 'ٱلْوَدُودُ',
      'urdu_title': 'الودود',
      'meaning': 'محبت کرنے والا',
    },
    {'arabic': 'ٱلْمَجِيدُ', 'urdu_title': 'المجید', 'meaning': 'بزرگی والا'},
    {'arabic': 'ٱلْبَاعِثُ', 'urdu_title': 'الباعث', 'meaning': 'اٹھانے والا'},
    {'arabic': 'ٱلشَّهِيدُ', 'urdu_title': 'الشہید', 'meaning': 'حاضر و ناظر'},
    {'arabic': 'ٱلْحَقُّ', 'urdu_title': 'الحق', 'meaning': 'برحق'},
    {'arabic': 'ٱلْوَكِيلُ', 'urdu_title': 'الوکیل', 'meaning': 'کارساز'},
    {'arabic': 'ٱلْقَوِيُّ', 'urdu_title': 'القوی', 'meaning': 'طاقتور'},
    {'arabic': 'ٱلْمَتِينُ', 'urdu_title': 'المتین', 'meaning': 'بہت مضبوط'},
    {'arabic': 'ٱلْوَلِيُّ', 'urdu_title': 'الولی', 'meaning': 'مددگار / دوست'},
    {'arabic': 'ٱلْحَمِيدُ', 'urdu_title': 'الحمید', 'meaning': 'قابلِ ستائش'},
    {'arabic': 'ٱلْمُحْصِي', 'urdu_title': 'المحصی', 'meaning': 'گھیرنے والا'},
    {
      'arabic': 'ٱلْمُبْدِئُ',
      'urdu_title': 'المبدئ',
      'meaning': 'پہلی بار پیدا کرنے والا',
    },
    {
      'arabic': 'ٱلْمُعِيدُ',
      'urdu_title': 'المعید',
      'meaning': 'دوبارہ پیدا کرنے والا',
    },
    {
      'arabic': 'ٱلْمُحْيِي',
      'urdu_title': 'المحیی',
      'meaning': 'زندگی دینے والا',
    },
    {
      'arabic': 'ٱلْمُمِيتُ',
      'urdu_title': 'الممیت',
      'meaning': 'موت دینے والا',
    },
    {
      'arabic': 'ٱلْحَيُّ',
      'urdu_title': 'الحی',
      'meaning': 'ہمیشہ زندہ رہنے والا',
    },
    {
      'arabic': 'ٱلْقَيُّومُ',
      'urdu_title': 'القیوم',
      'meaning': 'قائم رکھنے والا',
    },
    {'arabic': 'ٱلْوَاجِدُ', 'urdu_title': 'الواجد', 'meaning': 'پانے والا'},
    {'arabic': 'ٱلْمَاجِدُ', 'urdu_title': 'الماجد', 'meaning': 'بزرگی والا'},
    {'arabic': 'ٱلْوَاحِدُ', 'urdu_title': 'الواحد', 'meaning': 'اکیلا'},
    {'arabic': 'ٱلْأَحَد', 'urdu_title': 'الاحد', 'meaning': 'ایک'},
    {'arabic': 'ٱلصَّمَدُ', 'urdu_title': 'الصمد', 'meaning': 'بے نیاز'},
    {'arabic': 'ٱلْقَادِرُ', 'urdu_title': 'القادر', 'meaning': 'قدرت والا'},
    {'arabic': 'ٱلْمُقْتَدِرُ', 'urdu_title': 'المقتدر', 'meaning': 'مقتدر'},
    {
      'arabic': 'ٱلْمُقَدِّمُ',
      'urdu_title': 'المقدم',
      'meaning': 'آگے کرنے والا',
    },
    {
      'arabic': 'ٱلْمُؤَخِّرُ',
      'urdu_title': 'المؤخر',
      'meaning': 'پیچھے کرنے والا',
    },
    {'arabic': 'ٱلْأَوَّلُ', 'urdu_title': 'الاول', 'meaning': 'سب سے پہلے'},
    {'arabic': 'ٱلْآخِرُ', 'urdu_title': 'الآخر', 'meaning': 'سب سے آخر'},
    {'arabic': 'ٱلظَّاهِرُ', 'urdu_title': 'الظاہر', 'meaning': 'ظاہر'},
    {'arabic': 'ٱلْبَاطِنُ', 'urdu_title': 'الباطن', 'meaning': 'چھپا ہوا'},
    {'arabic': 'ٱلْوَالِي', 'urdu_title': 'الوالی', 'meaning': 'مالک'},
    {
      'arabic': 'ٱلْمُتَعَالِي',
      'urdu_title': 'المتعالی',
      'meaning': 'سب سے بلند',
    },
    {'arabic': 'ٱلْبَرُّ', 'urdu_title': 'البر', 'meaning': 'بہت نیک'},
    {
      'arabic': 'ٱلتَّوَّابُ',
      'urdu_title': 'التواب',
      'meaning': 'توبہ قبول کرنے والا',
    },
    {
      'arabic': 'ٱلْمُنْتَقِمُ',
      'urdu_title': 'المنتقم',
      'meaning': 'بدلہ لینے والا',
    },
    {
      'arabic': 'ٱلْعَفُوُّ',
      'urdu_title': 'العفو',
      'meaning': 'معاف کرنے والا',
    },
    {'arabic': 'ٱلرَّءُوفُ', 'urdu_title': 'الرؤوف', 'meaning': 'نرم خو'},
    {
      'arabic': 'مَالِكُ ٱلْمُلْكِ',
      'urdu_title': 'مالک الملک',
      'meaning': 'ملک کا بادشاہ',
    },
    {
      'arabic': 'ذُو ٱلْجَلَالِ وَٱلْإِكْرَامِ',
      'urdu_title': 'ذوالجلال والاکرام',
      'meaning': 'عظمت اور جلال والا',
    },
    {
      'arabic': 'ٱلْمُقْسِطُ',
      'urdu_title': 'المقسط',
      'meaning': 'انصاف کرنے والا',
    },
    {
      'arabic': 'ٱلْجَامِعُ',
      'urdu_title': 'الجامع',
      'meaning': 'اکٹھا کرنے والا',
    },
    {'arabic': 'ٱلْغَنِيُّ', 'urdu_title': 'الغنی', 'meaning': 'بے پرواہ'},
    {
      'arabic': 'ٱلْمُغْنِي',
      'urdu_title': 'المغنی',
      'meaning': 'غنی کرنے والا',
    },
    {'arabic': 'ٱلْمَانِعُ', 'urdu_title': 'المانع', 'meaning': 'روکنے والا'},
    {
      'arabic': 'ٱلضَّارُّ',
      'urdu_title': 'الضار',
      'meaning': 'نقصان پہنچانے والا',
    },
    {
      'arabic': 'ٱلنَّافِعُ',
      'urdu_title': 'النافع',
      'meaning': 'نفع پہنچانے والا',
    },
    {'arabic': 'ٱلنُّورُ', 'urdu_title': 'النور', 'meaning': 'روشن کرنے والا'},
    {
      'arabic': 'ٱلْهَادِي',
      'urdu_title': 'الہادی',
      'meaning': 'ہدایت دینے والا',
    },
    {
      'arabic': 'ٱلْبَدِيعُ',
      'urdu_title': 'البدیع',
      'meaning': 'نئی طرح پیدا کرنے والا',
    },
    {
      'arabic': 'ٱلْبَاقِي',
      'urdu_title': 'الباقی',
      'meaning': 'باقی رہنے والا',
    },
    {'arabic': 'ٱلْوَارِثُ', 'urdu_title': 'الوارث', 'meaning': 'سب کا وارث'},
    {
      'arabic': 'ٱلرَّشِيدُ',
      'urdu_title': 'الرشید',
      'meaning': 'ہدایت دینے والا',
    },
    {
      'arabic': 'ٱلصَّبُورُ',
      'urdu_title': 'الصبور',
      'meaning': 'صبر کرنے والا',
    },
  ];

  // --- 99 NAMES OF MUHAMMAD ﷺ (Complete with Urdu Meanings) ---
  final List<Map<String, String>> _muhammadNames = const [
    {
      'arabic': 'مُحَمَّدٌ',
      'urdu_title': 'محمد',
      'meaning': 'جس کی بہت تعریف کی جائے',
    },
    {
      'arabic': 'أَحْمَدٌ',
      'urdu_title': 'احمد',
      'meaning': 'بہت تعریف کرنے والا',
    },
    {
      'arabic': 'حَامِدٌ',
      'urdu_title': 'حامد',
      'meaning': 'اللہ کی حمد کرنے والا',
    },
    {'arabic': 'مَحْمُودٌ', 'urdu_title': 'محمود', 'meaning': 'تعریف کیا گیا'},
    {'arabic': 'قَاسِمٌ', 'urdu_title': 'قاسم', 'meaning': 'بانٹنے والا'},
    {
      'arabic': 'عَاقِبٌ',
      'urdu_title': 'عاقب',
      'meaning': 'سب سے پیچھے آنے والا',
    },
    {
      'arabic': 'فَاتِحٌ',
      'urdu_title': 'فاتح',
      'meaning': 'کھولنے والا / فتح کرنے والا',
    },
    {'arabic': 'خَاتَمٌ', 'urdu_title': 'خاتم', 'meaning': 'مہر / آخری نبی'},
    {'arabic': 'حَاشِرٌ', 'urdu_title': 'حاشر', 'meaning': 'جمع کرنے والا'},
    {
      'arabic': 'مَاحِي',
      'urdu_title': 'ماحی',
      'meaning': 'مٹانے والا (کفر کو)',
    },
    {'arabic': 'طٰهٰ', 'urdu_title': 'طہ', 'meaning': 'اے انسان (مخاطب)'},
    {'arabic': 'يٰسٓ', 'urdu_title': 'یس', 'meaning': 'اے سردار'},
    {'arabic': 'طَاهِرٌ', 'urdu_title': 'طاہر', 'meaning': 'پاک و صاف'},
    {'arabic': 'طَيِّبٌ', 'urdu_title': 'طیب', 'meaning': 'خوشبودار / پاکیزہ'},
    {'arabic': 'سَيِّدٌ', 'urdu_title': 'سید', 'meaning': 'سردار'},
    {
      'arabic': 'رَسُولٌ',
      'urdu_title': 'رسول',
      'meaning': 'اللہ کا پیغام پہنچانے والا',
    },
    {
      'arabic': 'نَبِيٌّ',
      'urdu_title': 'نبی',
      'meaning': 'غیب کی خبریں دینے والا',
    },
    {
      'arabic': 'مَنْصُورٌ',
      'urdu_title': 'منصور',
      'meaning': 'جس کی مدد کی گئی',
    },
    {'arabic': 'نَاصِرٌ', 'urdu_title': 'ناصر', 'meaning': 'مددگار'},
    {'arabic': 'شَاهِدٌ', 'urdu_title': 'شاہد', 'meaning': 'گواہی دینے والا'},
    {'arabic': 'بَشِيرٌ', 'urdu_title': 'بشیر', 'meaning': 'خوشخبری دینے والا'},
    {
      'arabic': 'نَذِيرٌ',
      'urdu_title': 'نذیر',
      'meaning': 'ڈرانے والا (غفلت سے)',
    },
    {'arabic': 'مُبَلِّغٌ', 'urdu_title': 'مبلغ', 'meaning': 'حق پہنچانے والا'},
    {'arabic': 'مُطِيعٌ', 'urdu_title': 'مطیع', 'meaning': 'فرمانبردار'},
    {'arabic': 'رَؤُوفٌ', 'urdu_title': 'رؤوف', 'meaning': 'نہایت شفقت والا'},
    {'arabic': 'رَحِيمٌ', 'urdu_title': 'رحیم', 'meaning': 'رحم کرنے والا'},
    {
      'arabic': 'مُذَكِّرٌ',
      'urdu_title': 'مذکر',
      'meaning': 'یاد دہانی کرانے والا',
    },
    {'arabic': 'سِرَاجٌ', 'urdu_title': 'سراج', 'meaning': 'چراغ'},
    {'arabic': 'مُنِيرٌ', 'urdu_title': 'منیر', 'meaning': 'روشن کرنے والا'},
    {
      'arabic': 'حَرِيصٌ',
      'urdu_title': 'حریص',
      'meaning': 'بھلائی کا چاہنے والا',
    },
    {'arabic': 'عَزِيزٌ', 'urdu_title': 'عزیز', 'meaning': 'غالب اور معزز'},
    {
      'arabic': 'مُزَّمِّلٌ',
      'urdu_title': 'مزمل',
      'meaning': 'چادر اوڑھنے والا',
    },
    {'arabic': 'مُدَّثِّرٌ', 'urdu_title': 'مدثر', 'meaning': 'کملی والا'},
    {'arabic': 'عَبْدٌ', 'urdu_title': 'عبد', 'meaning': 'اللہ کا سچا بندہ'},
    {
      'arabic': 'مُصْطَفٰی',
      'urdu_title': 'مصطفیٰ',
      'meaning': 'چنا ہوا / برگزیدہ',
    },
    {'arabic': 'مُجْتَبٰی', 'urdu_title': 'مجتبیٰ', 'meaning': 'منتخب کیا گیا'},
    {
      'arabic': 'حَبِيبٌ',
      'urdu_title': 'حبیب',
      'meaning': 'اللہ کا پیارا / دوست',
    },
    {'arabic': 'أَمِينٌ', 'urdu_title': 'امین', 'meaning': 'امانت دار'},
    {'arabic': 'صَادِقٌ', 'urdu_title': 'صادق', 'meaning': 'سچا'},
    {'arabic': 'نُورٌ', 'urdu_title': 'نور', 'meaning': 'سراپا روشنی'},
    {'arabic': 'كَرِيمٌ', 'urdu_title': 'کریم', 'meaning': 'باکرم اور سخی'},
    {'arabic': 'شَفِيعٌ', 'urdu_title': 'شفیع', 'meaning': 'شفاعت کرنے والا'},
    {'arabic': 'وَلِيٌّ', 'urdu_title': 'ولی', 'meaning': 'دوست اور مددگار'},
    {'arabic': 'حَقٌّ', 'urdu_title': 'حق', 'meaning': 'سچ اور برحق'},
    {'arabic': 'قَوِيٌّ', 'urdu_title': 'قوی', 'meaning': 'قوت والا'},
    {'arabic': 'مُبَارَكٌ', 'urdu_title': 'مبارک', 'meaning': 'برکت والا'},
    {'arabic': 'خَلِيلٌ', 'urdu_title': 'خلیل', 'meaning': 'گہرا دوست'},
    {'arabic': 'مُنِيبٌ', 'urdu_title': 'منیب', 'meaning': 'رجوع کرنے والا'},
    {'arabic': 'مُقْتَصِدٌ', 'urdu_title': 'مقتصد', 'meaning': 'اعتدال والا'},
    {'arabic': 'عَفُوٌّ', 'urdu_title': 'عفو', 'meaning': 'درگزر کرنے والا'},
    {'arabic': 'غَنِيٌّ', 'urdu_title': 'غنی', 'meaning': 'بے پرواہ'},
    {'arabic': 'مُعَلِّمٌ', 'urdu_title': 'معلم', 'meaning': 'تعلیم دینے والا'},
    {'arabic': 'جَوَادٌ', 'urdu_title': 'جواد', 'meaning': 'بہت سخی'},
    {'arabic': 'عَدْلٌ', 'urdu_title': 'عدل', 'meaning': 'انصاف والا'},
    {'arabic': 'صَبُورٌ', 'urdu_title': 'صبور', 'meaning': 'بڑا صابر'},
    {'arabic': 'حَفِيٌّ', 'urdu_title': 'حفی', 'meaning': 'بڑا مہربان'},
    {'arabic': 'مُكَرَّمٌ', 'urdu_title': 'مکرم', 'meaning': 'عزت والا'},
    {'arabic': 'مُعَظَّمٌ', 'urdu_title': 'معظم', 'meaning': 'بڑی عظمت والا'},
    {'arabic': 'شَکُورٌ', 'urdu_title': 'شکور', 'meaning': 'قدر شناس'},
    {'arabic': 'مُقَدَّسٌ', 'urdu_title': 'مقدس', 'meaning': 'پاکیزہ'},
    {'arabic': 'مُطَهَّرٌ', 'urdu_title': 'مطہر', 'meaning': 'پاک کیا گیا'},
    {'arabic': 'ذُوقُوَّةٍ', 'urdu_title': 'ذوقوة', 'meaning': 'بڑی قوت والا'},
    {
      'arabic': 'ذُومَكَانَةٍ',
      'urdu_title': 'ذومکانة',
      'meaning': 'بڑے مرتبے والا',
    },
    {'arabic': 'ذُوعِزٍّ', 'urdu_title': 'ذوعز', 'meaning': 'عزت والا'},
    {'arabic': 'ذُوفَضْلٍ', 'urdu_title': 'ذوفضل', 'meaning': 'بڑے فضل والا'},
    {
      'arabic': 'مَأْمُونٌ',
      'urdu_title': 'مامون',
      'meaning': 'جس پر بھروسہ کیا جائے',
    },
    {
      'arabic': 'مَرْحُومٌ',
      'urdu_title': 'مرحوم',
      'meaning': 'جس پر رحم کیا گیا',
    },
    {'arabic': 'غَوْثٌ', 'urdu_title': 'غوث', 'meaning': 'فریاد رس'},
    {'arabic': 'غَيَاثٌ', 'urdu_title': 'غیاث', 'meaning': 'مددگار'},
    {'arabic': 'مَلَاذٌ', 'urdu_title': 'ملاذ', 'meaning': 'پناہ گاہ'},
    {'arabic': 'عِصْمَةٌ', 'urdu_title': 'عصمت', 'meaning': 'بچاؤ کا ذریعہ'},
    {
      'arabic': 'نِعْمَةُ ٱللَّٰهِ',
      'urdu_title': 'نعمت اللہ',
      'meaning': 'اللہ کی نعمت',
    },
    {
      'arabic': 'هَدِيَّةُ ٱللَّٰهِ',
      'urdu_title': 'ہدیة اللہ',
      'meaning': 'اللہ کا تحفہ',
    },
    {
      'arabic': 'حُجَّةُ ٱللَّٰهِ',
      'urdu_title': 'حجة اللہ',
      'meaning': 'اللہ کی دلیل',
    },
    {
      'arabic': 'خَلِيلُ ٱلرَّحْمَٰنِ',
      'urdu_title': 'خلیل الرحمن',
      'meaning': 'رحمان کا دوست',
    },
    {
      'arabic': 'كَلِيمُ ٱللَّٰهِ',
      'urdu_title': 'کلیم اللہ',
      'meaning': 'اللہ سے کلام کرنے والا',
    },
    {
      'arabic': 'حَبِيبُ ٱللَّٰهِ',
      'urdu_title': 'حبیب اللہ',
      'meaning': 'اللہ کا پیارا',
    },
    {
      'arabic': 'صَفِيُّ ٱللَّٰهِ',
      'urdu_title': 'صفی اللہ',
      'meaning': 'اللہ کا پسندیدہ',
    },
    {
      'arabic': 'نَجِيُّ ٱللَّٰهِ',
      'urdu_title': 'نجی اللہ',
      'meaning': 'اللہ کا رازدار',
    },
    {'arabic': 'مُصْطَفٰی', 'urdu_title': 'مصطفیٰ', 'meaning': 'منتخب کیا ہوا'},
    {
      'arabic': 'مُرْتَضٰی',
      'urdu_title': 'مرتضیٰ',
      'meaning': 'جس سے اللہ راضی ہو',
    },
    {'arabic': 'مُجْتَبٰی', 'urdu_title': 'مجتبیٰ', 'meaning': 'چنا گیا'},
    {'arabic': 'مُخْتَارٌ', 'urdu_title': 'مختار', 'meaning': 'با اختیار'},
    {'arabic': 'نَاصِرٌ', 'urdu_title': 'ناصر', 'meaning': 'مدد کرنے والا'},
    {
      'arabic': 'مَنْصُورٌ',
      'urdu_title': 'منصور',
      'meaning': 'جس کی مدد کی گئی',
    },
    {'arabic': 'فَاتِحٌ', 'urdu_title': 'فاتح', 'meaning': 'فتح کرنے والا'},
    {'arabic': 'شَاهِدٌ', 'urdu_title': 'شاہد', 'meaning': 'گواہی دینے والا'},
    {'arabic': 'بَشِيرٌ', 'urdu_title': 'بشیر', 'meaning': 'خوشخبری دینے والا'},
    {'arabic': 'نَذِيرٌ', 'urdu_title': 'نذیر', 'meaning': 'ڈرانے والا'},
    {'arabic': 'مُبَلِّغٌ', 'urdu_title': 'مبلغ', 'meaning': 'پہنچانے والا'},
    {'arabic': 'شَافِعٌ', 'urdu_title': 'شافع', 'meaning': 'شفاعت کرنے والا'},
    {
      'arabic': 'مُشَفَّعٌ',
      'urdu_title': 'مشفع',
      'meaning': 'جس کی شفاعت مقبول ہو',
    },
    {'arabic': 'طَيِّبٌ', 'urdu_title': 'طیب', 'meaning': 'پاکیزہ'},
    {'arabic': 'طَاهِرٌ', 'urdu_title': 'طاہر', 'meaning': 'پاک و صاف'},
    {'arabic': 'مُطَهَّرٌ', 'urdu_title': 'مطہر', 'meaning': 'بہت پاک کیا گیا'},
    {'arabic': 'مُقَدَّسٌ', 'urdu_title': 'مقدس', 'meaning': 'پاک و برتر'},
    {'arabic': 'سِرَاجٌ', 'urdu_title': 'سراج', 'meaning': 'روشن چراغ'},
    {'arabic': 'مُنِيرٌ', 'urdu_title': 'منیر', 'meaning': 'روشن کرنے والا'},
  ];

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF006D5B);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: isDark
            ? const Color(0xFF121212)
            : const Color(0xFFF5F9F8),
        appBar: AppBar(
          title: const Text(
            "اسمائے مبارکہ",
            style: TextStyle(
              fontFamily: 'Jameel Noori Nastaleeq',
              fontSize: 24,
            ),
          ),
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          bottom: const TabBar(
            indicatorColor: Colors.amber,
            indicatorWeight: 4,
            labelStyle: TextStyle(
              fontFamily: 'Jameel Noori Nastaleeq',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            tabs: [
              Tab(text: "اللہ کے نام"),
              Tab(text: "محمد ﷺ کے نام"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildGrid(_allahNames, primaryColor, isDark),
            _buildGrid(_muhammadNames, primaryColor, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(
    List<Map<String, String>> names,
    Color primaryColor,
    bool isDark,
  ) {
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 1.05,
      ),
      itemCount: names.length,
      itemBuilder: (context, index) {
        final name = names[index];
        return Container(
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
          child: Stack(
            children: [
              // Background Arabic Watermark
              Positioned(
                bottom: -5,
                right: -5,
                child: Text(
                  name['arabic']!,
                  style: TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: 55,
                    color: primaryColor.withOpacity(0.04),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name['arabic']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Amiri',
                        fontSize: 26,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      name['urdu_title']!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                        fontFamily: 'Jameel Noori Nastaleeq',
                      ),
                    ),
                    const SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        name['meaning']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? Colors.white60 : Colors.black54,
                          fontFamily: 'Jameel Noori Nastaleeq',
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              // Number badge
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4AF37).withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
