import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart'; // <--- YEH ZAROORI HAI

// --- IMPORTS ---
import 'screens/splash_screen.dart';
import 'screens/tools_screen.dart';
import 'screens/booksmarks_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/chat_screen.dart';

// --- GLOBAL THEME VARIABLE ---
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // --- 1. LOAD SAVED THEME (YEH NAYA CODE HAI) ---
  // App start hone se pehle check karega ke Dark Mode on tha ya nahi
  final prefs = await SharedPreferences.getInstance();
  final bool isDark =
      prefs.getBool('isDarkMode') ?? false; // Agar kuch nahi mila to Light Mode

  // Agar Saved setting Dark thi, to Dark set karo
  if (isDark) {
    themeNotifier.value = ThemeMode.dark;
  }

  runApp(const HikmahApp());
}

class HikmahApp extends StatelessWidget {
  const HikmahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, mode, __) {
        return MaterialApp(
          title: 'Hikmah AI',
          debugShowCheckedModeBanner: false,
          themeMode: mode,

          // --- LIGHT THEME ---
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            primaryColor: const Color(0xFF006D5B),
            scaffoldBackgroundColor: const Color(0xFFF5F9F8),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF006D5B),
              primary: const Color(0xFF006D5B),
              secondary: const Color(0xFFD4AF37),
              surface: Colors.white,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF006D5B),
              foregroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
            ),
            navigationBarTheme: NavigationBarThemeData(
              backgroundColor: Colors.white,
              indicatorColor: const Color(0xFFE0F2F1),
              iconTheme: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return const IconThemeData(color: Color(0xFF006D5B));
                }
                return const IconThemeData(color: Colors.grey);
              }),
            ),
          ),

          // --- DARK THEME ---
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF121212),
            primaryColor: const Color(0xFF004D40),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF006D5B),
              brightness: Brightness.dark,
            ),
            navigationBarTheme: const NavigationBarThemeData(
              backgroundColor: Color(0xFF1E1E1E),
              indicatorColor: Color(0xFF004D40),
            ),
          ),

          home: const SplashScreen(),
        );
      },
    );
  }
}

// --- MAIN DASHBOARD ---
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;

  static final List<Widget> _screens = <Widget>[
    const ToolsScreen(),
    const ChatScreen(),
    const BooksmarksScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool showMainAppBar = _selectedIndex == 1;

    return Scaffold(
      appBar: showMainAppBar
          ? AppBar(
              toolbarHeight: 100,
              backgroundColor: const Color(0xFF006D5B),
              elevation: 0,
              flexibleSpace: Stack(
                children: [
                  Positioned(
                    right: -20,
                    bottom: -10,
                    child: Icon(
                      Icons.mosque,
                      color: Colors.white.withOpacity(0.12),
                      size: 130,
                    ),
                  ),
                  const Positioned(
                    left: 20,
                    bottom: 25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hikmah AI',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            fontFamily: 'Serif',
                          ),
                        ),
                        Text(
                          'Your Islamic Companion',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : null,

      body: _screens.elementAt(_selectedIndex),

      bottomNavigationBar: NavigationBar(
        height: 70,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Tools',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border),
            selectedIcon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
