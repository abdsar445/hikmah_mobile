import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({super.key});

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen>
    with SingleTickerProviderStateMixin {
  PrayerTimes? _prayerTimes;
  String _currentCity = "Locating...";
  bool _isLoading = true;
  String _errorMessage = ""; // Used in UI to remove yellow lint warning

  Timer? _timer;
  Prayer? _nextPrayer;

  List<Map<String, String>> _ramadanData = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _getUserLocationAndPrayers();

    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (_prayerTimes != null && mounted) {
        setState(() {
          _updateNextPrayer();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _tabController.dispose();
    super.dispose();
  }

  void _updateNextPrayer() {
    if (_prayerTimes == null) return;
    Prayer next = _prayerTimes!.nextPrayer();
    _nextPrayer = (next == Prayer.none) ? Prayer.fajr : next;
  }

  Future<void> _getUserLocationAndPrayers() async {
    try {
      Position position = await _determinePosition();

      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        if (placemarks.isNotEmpty && mounted) {
          Placemark place = placemarks[0];
          setState(() {
            _currentCity = "${place.locality}, ${place.country}";
          });
        }
      } catch (e) {
        if (mounted) setState(() => _currentCity = "Location Found");
      }

      final myCoordinates = Coordinates(position.latitude, position.longitude);
      final params = CalculationMethod.karachi.getParameters();
      params.madhab = Madhab.hanafi;

      // Ramadan 2026 Data Generation
      DateTime ramadanStart = DateTime(2026, 2, 18);
      List<Map<String, String>> tempRamadan = [];

      for (int i = 0; i < 30; i++) {
        DateTime day = ramadanStart.add(Duration(days: i));
        PrayerTimes dayPrayer = PrayerTimes(
          myCoordinates,
          DateComponents.from(day),
          params,
        );

        tempRamadan.add({
          "day": "Ramadan ${i + 1}",
          "date": DateFormat('d MMM').format(day),
          "sehri": DateFormat.jm().format(dayPrayer.fajr),
          "iftar": DateFormat.jm().format(dayPrayer.maghrib),
        });
      }

      if (mounted) {
        setState(() {
          _prayerTimes = PrayerTimes(
            myCoordinates,
            DateComponents.from(DateTime.now()),
            params,
          );
          _ramadanData = tempRamadan;
          _updateNextPrayer();
          _isLoading = false;
          _errorMessage = "";
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = "GPS Error: Please enable location services.";
          _currentCity = "Location Error";
        });
      }
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return Future.error('Location services disabled');

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied)
        return Future.error('Permission denied');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const primaryColor = Color(0xFF006D5B);
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF121212)
          : const Color(0xFFF5F9F8),
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white70,
                          size: 18,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            _currentCity,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          DateFormat('d MMM').format(DateTime.now()),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.amber,
                    indicatorWeight: 3,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white60,
                    tabs: const [
                      Tab(text: "Prayers"),
                      Tab(text: "Ramadan 2026"),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Body
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  )
                : _errorMessage.isNotEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        _errorMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  )
                : TabBarView(
                    controller: _tabController,
                    children: [
                      _buildTodayTab(cardColor, textColor, primaryColor),
                      _buildRamadanTab(cardColor, textColor, primaryColor),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayTab(Color cardColor, Color textColor, Color primaryColor) {
    if (_prayerTimes == null)
      return const Center(child: Text("Location needed"));
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildPrayerTile(
          "Fajr",
          _prayerTimes!.fajr,
          Icons.wb_twilight,
          Prayer.fajr,
          cardColor,
          textColor,
          primaryColor,
        ),
        _buildPrayerTile(
          "Sunrise",
          _prayerTimes!.sunrise,
          Icons.wb_sunny,
          Prayer.sunrise,
          cardColor,
          textColor,
          Colors.orange,
        ),
        _buildPrayerTile(
          "Dhuhr",
          _prayerTimes!.dhuhr,
          Icons.wb_sunny_outlined,
          Prayer.dhuhr,
          cardColor,
          textColor,
          primaryColor,
        ),
        _buildPrayerTile(
          "Asr",
          _prayerTimes!.asr,
          Icons.cloud_queue,
          Prayer.asr,
          cardColor,
          textColor,
          primaryColor,
        ),
        _buildPrayerTile(
          "Maghrib",
          _prayerTimes!.maghrib,
          Icons.nights_stay_outlined,
          Prayer.maghrib,
          cardColor,
          textColor,
          primaryColor,
        ),
        _buildPrayerTile(
          "Isha",
          _prayerTimes!.isha,
          Icons.nights_stay,
          Prayer.isha,
          cardColor,
          textColor,
          primaryColor,
        ),
      ],
    );
  }

  Widget _buildRamadanTab(
    Color cardColor,
    Color textColor,
    Color primaryColor,
  ) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Sehri Dua Card (Normal Size)
        _buildSimpleDuaBox(
          "سحری کی دعا",
          "وَبِصَوْمِ غَدٍ نَّوَيْتُ مِنْ شَهْرِ رَمَضَانَ",
          Colors.orange.shade800,
          cardColor,
        ),
        const SizedBox(height: 12),
        // Iftari Dua Card (Normal Size)
        _buildSimpleDuaBox(
          "افطاری کی دعا",
          "اَللّٰهُمَّ اِنِّی لَکَ صُمْتُ وَبِکَ اٰمَنْتُ وَعَلَی رِزْقِکَ اَفْطَرْتُ",
          primaryColor,
          cardColor,
        ),

        const SizedBox(height: 20),
        const Divider(),

        ..._ramadanData.map(
          (day) => Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.withOpacity(0.1)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        day['day']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        day['date']!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    day['sehri']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: textColor),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    day['iftar']!,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- SAFE DUA BOX (No TextDirection used to avoid compiler errors) ---
  Widget _buildSimpleDuaBox(
    String title,
    String arabic,
    Color color,
    Color cardBg,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.brightness_auto, color: color, size: 18),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            arabic,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerTile(
    String name,
    DateTime time,
    IconData icon,
    Prayer prayerType,
    Color bgColor,
    Color textColor,
    Color accentColor,
  ) {
    final bool isNext = _nextPrayer == prayerType;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15),
        border: isNext ? Border.all(color: Colors.orange, width: 2) : null,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isNext ? Colors.orange : accentColor,
          size: 24,
        ),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isNext ? Colors.orange : textColor,
          ),
        ),
        trailing: Text(
          DateFormat.jm().format(time),
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: isNext ? Colors.orange : textColor,
          ),
        ),
      ),
    );
  }
}
