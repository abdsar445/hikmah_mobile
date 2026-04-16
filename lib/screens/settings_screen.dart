import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'login_screen.dart';
import '../main.dart'; // ThemeNotifier

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Theme State
  bool _isDarkMode = themeNotifier.value == ThemeMode.dark;

  String userName = "Hikmah User";
  String userEmail = "user@example.com";
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  // --- INIT DATA ---
  Future<void> _initData() async {
    await _getUserData();
    await _loadProfileImage();
  }

  // --- 1. LOAD USER DATA ---
  Future<void> _getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (mounted) {
        setState(() {
          if (user.displayName != null && user.displayName!.isNotEmpty) {
            userName = user.displayName!;
          } else if (user.email != null) {
            String rawName = user.email!.split('@')[0];
            if (rawName.isNotEmpty) {
              userName = rawName[0].toUpperCase() + rawName.substring(1);
            } else {
              userName = rawName;
            }
          } else {
            userName = "Guest User";
          }
          userEmail = user.email ?? "No Email";
        });
      }
    }
  }

  // --- 2. LOAD PROFILE IMAGE ---
  Future<void> _loadProfileImage() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final prefs = await SharedPreferences.getInstance();
      final String key = 'profile_image_${user.uid}';
      final String? imagePath = prefs.getString(key);

      if (imagePath != null) {
        final File imageFile = File(imagePath);
        if (await imageFile.exists()) {
          if (mounted) {
            setState(() {
              _profileImage = imageFile;
            });
          }
        }
      } else {
        if (mounted) {
          setState(() {
            _profileImage = null;
          });
        }
      }
    } catch (e) {
      debugPrint("Error loading image: $e");
    }
  }

  // --- 3. SHOW OPTIONS (View or Change) ---
  void _showProfileOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle Bar
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              // Option 1: View Picture
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF006D5B).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.visibility, color: Color(0xFF006D5B)),
                ),
                title: const Text(
                  "View Profile Picture",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _viewImageDialog();
                },
              ),

              const SizedBox(height: 10),

              // Option 2: Change Picture
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.camera_alt, color: Colors.orange),
                ),
                title: const Text(
                  "Change Picture",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(); // Gallery open karega
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // --- 4. VIEW IMAGE DIALOG ---
  void _viewImageDialog() {
    if (_profileImage == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No profile picture set")));
      return;
    }
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.file(_profileImage!, fit: BoxFit.cover),
            ),
            const SizedBox(height: 15),
            CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- 5. PICK & SAVE IMAGE ---
  Future<void> _pickImage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please Login first")));
      return;
    }

    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        if (mounted) {
          setState(() {
            _profileImage = File(pickedFile.path);
          });
        }

        final prefs = await SharedPreferences.getInstance();
        final String key = 'profile_image_${user.uid}';
        await prefs.setString(key, pickedFile.path);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Profile Picture Saved!"),
              backgroundColor: Color(0xFF006D5B),
            ),
          );
        }
      }
    } catch (e) {
      // Handle error
    }
  }

  // --- THEME TOGGLE ---
  Future<void> _toggleTheme(bool isDark) async {
    setState(() {
      _isDarkMode = isDark;
    });
    themeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
  }

  // --- LOGOUT ---
  void _logout() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    const primaryColor = Color(0xFF006D5B);

    final textColor = isDarkTheme ? Colors.white : Colors.black87;
    final subTextColor = isDarkTheme ? Colors.white70 : Colors.black54;

    return SingleChildScrollView(
      child: Column(
        children: [
          // --- HEADER ---
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -10,
                      bottom: -10,
                      child: Icon(
                        Icons.mosque,
                        color: Colors.white.withOpacity(0.15),
                        size: 110,
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                top: 60,
                child: Column(
                  children: [
                    // Profile Pic Stack (Clickable)
                    GestureDetector(
                      onTap:
                          _showProfileOptions, // Click karne par Options ayenge
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: theme.cardColor,
                              shape: BoxShape.circle,
                              boxShadow: const [
                                BoxShadow(color: Colors.black12, blurRadius: 8),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey.shade200,
                              backgroundImage: _profileImage != null
                                  ? FileImage(_profileImage!)
                                  : null,
                              child: _profileImage == null
                                  ? Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Colors.grey.shade400,
                                    )
                                  : null,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0xFFD4AF37),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: textColor, // Fixed Text Color
                      ),
                    ),
                    Text(
                      userEmail,
                      style: TextStyle(color: subTextColor, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 80), // Gap Fix
          // --- SETTINGS LIST ---
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (userName == "Not Logged In")
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                      ),
                      child: const Text(
                        "Login Now",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                _buildSectionHeader(context, 'Account'),
                _buildSettingsTile(
                  context,
                  Icons.person_outline,
                  'Personal Information',
                  Colors.blue,
                  () {},
                ),
                _buildSettingsTile(
                  context,
                  Icons.lock_outline,
                  'Change Password',
                  Colors.orange,
                  () {},
                ),
                const SizedBox(height: 20),

                _buildSectionHeader(context, 'Preferences'),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor.withOpacity(0.1),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.indigo.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.dark_mode_outlined,
                        color: Colors.indigo,
                        size: 22,
                      ),
                    ),
                    title: const Text(
                      "Dark Mode",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    trailing: Switch(
                      value: _isDarkMode,
                      activeColor: primaryColor,
                      onChanged: _toggleTheme,
                    ),
                  ),
                ),

                _buildSettingsTile(
                  context,
                  Icons.format_size,
                  'Font Size',
                  Colors.teal,
                  () {},
                ),
                _buildSettingsTile(
                  context,
                  Icons.language,
                  'Language (English)',
                  Colors.purple,
                  () {},
                ),

                const SizedBox(height: 20),

                _buildSectionHeader(context, 'Support'),
                _buildSettingsTile(
                  context,
                  Icons.share,
                  'Share App',
                  Colors.lightBlue,
                  () {},
                ),
                _buildSettingsTile(
                  context,
                  Icons.privacy_tip_outlined,
                  'Privacy Policy',
                  Colors.grey,
                  () {},
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _logout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade50,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Log Out',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 5),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context,
    IconData icon,
    String title,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 5,
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context,
    IconData icon,
    String title,
    Color color,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 5,
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF006D5B),
        ),
      ),
    );
  }
}
