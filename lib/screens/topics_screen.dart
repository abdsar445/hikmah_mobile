import 'package:flutter/material.dart';

class TopicsScreen extends StatefulWidget {
  const TopicsScreen({super.key});

  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  final TextEditingController _searchController = TextEditingController();

  // --- TOPICS DATA ---
  final List<Map<String, dynamic>> _allTopics = const [
    {'title': 'Iman', 'icon': Icons.favorite_rounded},
    {'title': 'Salah', 'icon': Icons.access_time_filled_rounded},
    {'title': 'Zakat', 'icon': Icons.monetization_on_rounded},
    {'title': 'Sawm', 'icon': Icons.nights_stay_rounded},
    {'title': 'Hajj', 'icon': Icons.mosque_rounded},
    {'title': 'Family', 'icon': Icons.family_restroom_rounded},
    {'title': 'Honesty', 'icon': Icons.verified_rounded},
    {'title': 'Knowledge', 'icon': Icons.menu_book_rounded},
    {'title': 'Sabr', 'icon': Icons.hourglass_bottom_rounded},
    {'title': 'Parents', 'icon': Icons.elderly_rounded},
    {'title': 'Akhlaq', 'icon': Icons.emoji_people_rounded},
    {'title': 'Dua', 'icon': Icons.volunteer_activism_rounded},
    {'title': 'Forgiveness', 'icon': Icons.clean_hands_rounded},
    {'title': 'Afterlife', 'icon': Icons.cloud_rounded},
  ];

  List<Map<String, dynamic>> _filteredTopics = [];

  @override
  void initState() {
    super.initState();
    _filteredTopics = _allTopics;
  }

  void _filterTopics(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredTopics = _allTopics;
      } else {
        _filteredTopics = _allTopics
            .where(
              (topic) => topic['title'].toString().toLowerCase().contains(
                query.toLowerCase(),
              ),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // --- DARK MODE LOGIC START ---
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Colors define karein
    const primaryColor = Color(
      0xFF006D5B,
    ); // Hamesha Green rahega (Brand Color)

    // Light Mode vs Dark Mode Colors
    final scaffoldBg = isDark
        ? const Color(0xFF121212)
        : const Color(0xFFF5F9F8);
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final iconBgColor = isDark
        ? const Color(0xFF004D40)
        : const Color(0xFFE0F2F1); // Icon ke peeche ka circle
    final iconColor = isDark
        ? const Color(0xFF80CBC4)
        : primaryColor; // Icon ka rang
    final searchBarColor = isDark ? const Color(0xFF2C2C2C) : Colors.white;
    // --- DARK MODE LOGIC END ---

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: Column(
        children: [
          // --- HEADER & SEARCH BAR STACK ---
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // 1. Green Header Background (Fixed Green)
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Stack(
                  children: [
                    // Background Mosque Art
                    Positioned(
                      right: -20,
                      bottom: 0,
                      child: Icon(
                        Icons.mosque,
                        size: 140,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    // Title Text
                    const Positioned(
                      top: 60,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Explore Topics",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Serif',
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Learn about Islam via Categories",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Search Bar (Floating)
              Positioned(
                bottom: -25,
                left: 20,
                right: 20,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: searchBarColor, // Dark/Light adapt karega
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterTopics,
                    style: TextStyle(color: textColor), // Input text color
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: "Search topics (e.g. Hajj, Salah)...",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: isDark ? Colors.grey : primaryColor,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // --- GAP FOR SEARCH BAR ---
          const SizedBox(height: 40),

          // --- GRID VIEW ---
          Expanded(
            child: _filteredTopics.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 50,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "No topics found",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // 3 Columns
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.85,
                        ),
                    itemCount: _filteredTopics.length,
                    itemBuilder: (context, index) {
                      final topic = _filteredTopics[index];

                      return Container(
                        decoration: BoxDecoration(
                          color: cardColor, // Card color adapts
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Selected: ${topic['title']}"),
                                  backgroundColor: primaryColor,
                                  duration: const Duration(milliseconds: 500),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icon Circle
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color:
                                        iconBgColor, // Dark Teal in Dark Mode
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    topic['icon'],
                                    color: iconColor, // Light Teal in Dark Mode
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                // Title Text
                                Text(
                                  topic['title'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: textColor, // White in Dark Mode
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
