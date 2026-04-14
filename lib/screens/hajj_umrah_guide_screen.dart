import 'package:flutter/material.dart';

class HajjUmrahGuideScreen extends StatelessWidget {
  const HajjUmrahGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF006D5B); // Islamic Green
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: isDark
            ? const Color(0xFF121212)
            : const Color(0xFFF5F9F8),
        appBar: AppBar(
          title: const Text(
            "حج و عمرہ: مکمل انسائیکلوپیڈیا",
            style: TextStyle(
              fontFamily: 'Jameel Noori Nastaleeq',
              fontSize: 24,
            ),
          ),
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          centerTitle: true,
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.amber,
            indicatorWeight: 4,
            labelStyle: TextStyle(
              fontFamily: 'Jameel Noori Nastaleeq',
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            tabs: [
              Tab(text: "عمرہ کی مکمل تفصیل"),
              Tab(text: "حج کا 40 روزہ سفر"),
              Tab(text: "مدینہ اور زیارات"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildUmrahTab(isDark, primaryColor),
            _buildHajjTab(isDark, primaryColor),
            _buildMadinahTab(isDark, primaryColor),
          ],
        ),
      ),
    );
  }

  // --- 1. DETAILED UMRAH TAB ---
  Widget _buildUmrahTab(bool isDark, Color primary) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildHeaderCard("عمرہ کے ارکان اور آداب", primary),
        _buildDetailedCard(
          "احرام اور میقات (پہلا مرحلہ)",
          "عمرہ کا آغاز میقات سے ہوتا ہے۔ میقات وہ مقام ہے جہاں سے بغیر احرام آگے بڑھنا جائز نہیں۔ غسل کریں، خوشبو لگائیں (صرف بدن پر) اور دو سفید چادریں پہنیں۔ نیت کر کے 'لبیک' پکاریں۔",
          arabic: "لَبَّيْكَ اللَّهُمَّ عُمْرَةً",
          tips: [
            "احرام میں مردوں کے لیے سلا ہوا کپڑا پہننا حرام ہے۔",
            "سر ڈھانپنا اور چہرہ چھپانا (مردوں کے لیے) منع ہے۔",
            "بال توڑنا، ناخن کاٹنا اور میاں بیوی کے خاص تعلقات حرام ہیں۔",
            "خوشبو دار صابن یا ٹشو استعمال کرنے سے پرہیز کریں۔",
          ],
          isDark: isDark,
        ),
        _buildDetailedCard(
          "طوافِ کعبہ (سات چکر)",
          "حجرِ اسود سے شروع کریں اور وہیں ختم کریں۔ ہر چکر میں حجرِ اسود کا استلام کریں۔ پہلے تین چکروں میں 'رمل' (اکڑ کر تیز چلنا) صرف مردوں کے لیے سنت ہے۔",
          tips: [
            "اضطباع: سیدھا کندھا کھلا رکھنا صرف طواف کے دوران سنت ہے۔",
            "طواف کے بعد مقامِ ابراہیم پر دو رکعت واجب الطواف پڑھیں۔",
            "ملتزم (کعبہ کی دیوار) سے چمٹ کر گڑگڑا کر دعا مانگنا قبولیت کا وقت ہے۔",
          ],
          isDark: isDark,
        ),
        _buildDetailedCard(
          "سعی اور حلق (مکمل خاتمہ)",
          "صفا سے مروہ تک 7 چکر پورے کریں۔ سبز ستونوں کے درمیان مرد تھوڑا تیز دوڑیں۔ آخر میں حلق (سر منڈوانا) یا قصر (بال کٹوانا) ضروری ہے۔",
          tips: [
            "صفا سے مروہ ایک چکر ہے، مروہ سے صفا دوسرا۔",
            "حلق (منڈوانا) قصر سے افضل ہے، عورتیں صرف ایک انچ بال کٹوائیں۔",
            "بال کٹوانے کے بعد ہی احرام کی پابندیاں ختم ہوتی ہیں۔",
          ],
          isDark: isDark,
        ),
      ],
    );
  }

  // --- 2. DETAILED HAJJ TAB (40 DAYS) ---
  Widget _buildHajjTab(bool isDark, Color primary) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildHeaderCard("حج کا 40 روزہ مکمل سفر", primary),
        _buildTimelineItem(
          "پہلا مرحلہ: مکہ میں آمد (1 سے 7 ذوالحجہ)",
          "مکہ پہنچ کر عمرہ یا طوافِ قدوم کریں اور اپنا زیادہ وقت خانہ کعبہ کی عبادت میں گزاریں۔ حرم کی ایک نماز ایک لاکھ کے برابر ہے۔",
          isDark: isDark,
        ),
        _buildTimelineItem(
          "8 ذوالحجہ: منیٰ روانگی (پہلا دن)",
          "احرام باندھ کر منیٰ پہنچیں۔ یہاں ظہر، عصر، مغرب، عشاء اور فجر (پانچ نمازیں) پڑھنا سنت ہے۔ یہ تیاری کا دن ہے۔",
          isDark: isDark,
        ),
        _buildTimelineItem(
          "9 ذوالحجہ: عرفات (حج کا رکنِ اعظم)",
          "زوال کے بعد سے مغرب تک میدانِ عرفات میں ٹھہرنا فرض ہے۔ یہاں کی دعائیں تقدیر بدل دیتی ہیں۔ مغرب کے بعد مزدلفہ روانہ ہوں۔",
          tips: [
            "مزدلفہ میں مغرب اور عشاء ملا کر پڑھیں۔",
            "رات کھلے آسمان تلے ذکر و اذکار میں گزاریں۔",
          ],
          isDark: isDark,
        ),
        _buildTimelineItem(
          "10 ذوالحجہ: عید، رمی اور قربانی",
          "آج کے دن بڑے شیطان کو کنکریاں ماریں، قربانی کریں، سر منڈوائیں اور طوافِ زیارت (فرض) کے لیے مکہ جائیں۔",
          isDark: isDark,
        ),
        _buildTimelineItem(
          "11 تا 13 ذوالحجہ: ایامِ تشریق",
          "منیٰ میں قیام کریں اور روزانہ تینوں شیطانوں کو کنکریاں ماریں۔ اس کے بعد مکہ واپسی اور طوافِ وداع (آخری واجب) کریں۔",
          isDark: isDark,
        ),
        _buildTimelineItem(
          "مدینہ منورہ کا سفر (8 سے 10 دن)",
          "حج سے پہلے یا بعد میں مدینہ منورہ کی حاضری ضروری ہے۔ یہاں مسجدِ نبوی میں 40 نمازیں پوری کرنا مستحب اور بڑی فضیلت کا باعث ہے۔",
          isDark: isDark,
        ),
      ],
    );
  }

  // --- 3. MADINAH & ZIYARAT TAB ---
  Widget _buildMadinahTab(bool isDark, Color primary) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildHeaderCard("مدینہ منورہ اور اہم زیارات", primary),
        _buildDetailedCard(
          "مسجدِ نبوی (ﷺ) اور روضہ اقدس",
          "روضہ رسول (ﷺ) پر نہایت ادب سے سلام پیش کریں۔ 'ریاض الجنہ' میں نفل پڑھنے کی کوشش کریں جو جنت کا ٹکڑا ہے۔",
          tips: [
            "روضہ مبارک پر آواز بلند کرنا سخت گناہ ہے۔",
            "دھکم پیل سے گریز کریں اور عاجزی اختیار کریں۔",
            "مسجدِ نبوی میں درود پاک کی کثرت کریں۔",
          ],
          isDark: isDark,
        ),
        _buildDetailedCard(
          "مکہ اور مدینہ کی تاریخی زیارات",
          "مکہ: غارِ حرا، غارِ ثور، جنت المعلیٰ، جبلِ رحمت۔\nمدینہ: مسجدِ قباء، مسجدِ قبلتین، میدانِ احد، جنت البقیع۔",
          tips: [
            "مسجدِ قباء میں دو رکعت کا ثواب ایک عمرہ کے برابر ہے۔",
            "احد کے پہاڑ پر شہدائے احد (حضرت حمزہ رض) کے لیے دعا کریں۔",
          ],
          isDark: isDark,
        ),
      ],
    );
  }

  // --- UI HELPER METHODS ---

  Widget _buildHeaderCard(String title, Color primary) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Jameel Noori Nastaleeq',
        ),
      ),
    );
  }

  Widget _buildDetailedCard(
    String title,
    String content, {
    String? arabic,
    List<String>? tips,
    required bool isDark,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text(
          title,
          textAlign: TextAlign.right,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF006D5B),
            fontFamily: 'Jameel Noori Nastaleeq',
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (arabic != null) ...[
                  Text(
                    arabic,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      fontSize: 22,
                      fontFamily: 'Amiri',
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                Text(
                  content,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.7,
                    color: isDark ? Colors.white70 : Colors.black87,
                    fontFamily: 'Jameel Noori Nastaleeq',
                  ),
                ),
                if (tips != null) ...[
                  const Divider(height: 30),
                  ...tips
                      .map(
                        (tip) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  tip,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.teal,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.star,
                                size: 12,
                                color: Colors.amber,
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(
    String title,
    String content, {
    List<String>? tips,
    required bool isDark,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.teal.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF006D5B),
              fontFamily: 'Jameel Noori Nastaleeq',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: isDark ? Colors.white60 : Colors.black54,
              fontFamily: 'Jameel Noori Nastaleeq',
            ),
          ),
          if (tips != null) ...[
            const SizedBox(height: 10),
            ...tips.map(
              (tip) => Text(
                "• $tip",
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 12, color: Colors.amber),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
