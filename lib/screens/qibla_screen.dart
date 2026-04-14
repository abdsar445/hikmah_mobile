import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math' as math;

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({super.key});

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  final Future<bool?> _deviceSupport =
      FlutterQiblah.androidDeviceSensorSupport();

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF006D5B);

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text("Qibla Direction"),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<bool?>(
        future: _deviceSupport,
        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          // --- MAIN LOGIC ---
          // Agar Sensor hai (True) -> Asli Compass chalao
          // Agar Sensor nahi hai (False/Null) -> Simulation chalao (Taake Error na aye)
          final bool hasSensor = snapshot.data == true;

          return QiblaCompassWidget(useSensor: hasSensor);
        },
      ),
    );
  }
}

// --- MAIN COMPASS WIDGET ---
class QiblaCompassWidget extends StatefulWidget {
  final bool useSensor;
  const QiblaCompassWidget({super.key, required this.useSensor});

  @override
  State<QiblaCompassWidget> createState() => _QiblaCompassWidgetState();
}

class _QiblaCompassWidgetState extends State<QiblaCompassWidget>
    with SingleTickerProviderStateMixin {
  bool _hasPermission = false;
  late AnimationController _demoController;

  @override
  void initState() {
    super.initState();
    _getPermission();

    // Animation for Phones without Sensor (Simulation)
    _demoController = AnimationController(
      duration: const Duration(seconds: 15), // Slow rotation
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _demoController.dispose();
    super.dispose();
  }

  Future<void> _getPermission() async {
    if (await Permission.location.request().isGranted) {
      if (mounted) setState(() => _hasPermission = true);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permission required")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasPermission) {
      return Center(
        child: ElevatedButton(
          onPressed: _getPermission,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
          child: const Text(
            "Enable Location",
            style: TextStyle(color: Color(0xFF006D5B)),
          ),
        ),
      );
    }

    // --- CASE 1: PHONE MEIN SENSOR NAHI HAI (Simulation Mode) ---
    if (!widget.useSensor) {
      return AnimatedBuilder(
        animation: _demoController,
        builder: (context, child) {
          // Compass ko halka sa move karein taake zinda lage
          final double fakeAngle = (_demoController.value * 0.5);
          return _buildCompassUI(
            angle: fakeAngle,
            statusText: "Simulation Mode (No Sensor)",
          );
        },
      );
    }

    // --- CASE 2: ASLI SENSOR WALA PHONE ---
    return StreamBuilder<QiblahDirection>(
      stream: FlutterQiblah.qiblahStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        if (snapshot.hasData) {
          final qiblahDirection = snapshot.data!;
          final double direction =
              qiblahDirection.qiblah * (math.pi / 180) * -1;
          return _buildCompassUI(
            angle: direction,
            statusText: "Align Arrow to Kaaba",
          );
        } else {
          return const Center(
            child: Text(
              "Calibrating...",
              style: TextStyle(color: Colors.white),
            ),
          );
        }
      },
    );
  }

  // --- SHARED UI DESIGN ---
  Widget _buildCompassUI({required double angle, required String statusText}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Status Text
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            statusText,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
        const SizedBox(height: 40),

        // --- COMPASS STACK ---
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 1. Static Dial (Background)
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white30, width: 4),
                  gradient: LinearGradient(
                    colors: [Colors.white.withOpacity(0.1), Colors.transparent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),

              // 2. Rotating Compass Image
              Transform.rotate(
                angle: angle,
                child: Container(
                  width: 260,
                  height: 260,
                  padding: const EdgeInsets.all(10),
                  child: Image.network(
                    "https://raw.githubusercontent.com/medyo/flutter_qiblah/master/example/assets/compass.png",
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.explore,
                      size: 150,
                      color: Colors.white54,
                    ),
                  ),
                ),
              ),

              // 3. Fixed Qibla Icon
              const Icon(
                Icons.mosque,
                size: 50,
                color: Color(0xFFD4AF37),
              ), // Gold Color
              // 4. Arrow Indicator
              const Positioned(
                top: 10,
                child: Icon(
                  Icons.arrow_drop_up,
                  size: 40,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 50),

        // Degree Display
        Text(
          "${(angle * (180 / math.pi)).abs().toStringAsFixed(0)}°",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text("Angle", style: TextStyle(color: Colors.white70)),
      ],
    );
  }
}
