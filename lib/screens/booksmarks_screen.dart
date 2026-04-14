import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'topics_screen.dart'; // Topics screen par jane ke liye import

class BooksmarksScreen extends StatefulWidget {
  const BooksmarksScreen({super.key});

  @override
  State<BooksmarksScreen> createState() => _BooksmarksScreenState();
}

class _BooksmarksScreenState extends State<BooksmarksScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _appId = "hikmah-ai-app"; // DuasScreen se match hona zaroori hai

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const primaryColor = Color(0xFF006D5B);

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0D0D0D)
          : const Color(0xFFF5F8F5),
      appBar: AppBar(
        // Header name updated to "My Saved"
        title: const Text(
          "My Saved",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),

      // --- PLUS BUTTON (Floating Action Button) ---
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Topics screen par navigate karne ke liye
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TopicsScreen()),
          );
        },
        backgroundColor: primaryColor,
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),

      body: StreamBuilder<User?>(
        stream: _auth.authStateChanges(),
        builder: (context, authSnapshot) {
          if (authSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }

          if (!authSnapshot.hasData || authSnapshot.data == null) {
            return const Center(child: Text("Please login to see bookmarks"));
          }

          final userId = authSnapshot.data!.uid;

          // Fetching data from the correct structured path
          return StreamBuilder<QuerySnapshot>(
            stream: _db
                .collection('artifacts')
                .doc(_appId)
                .collection('users')
                .doc(userId)
                .collection('bookmarks')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: primaryColor),
                );
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return _buildEmptyState(isDark);
              }

              final docs = snapshot.data!.docs;

              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  80,
                ), // Bottom padding for FAB
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final data = docs[index].data() as Map<String, dynamic>;
                  final docId = docs[index].id;

                  return Card(
                    color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        data['title'] ?? 'Untitled',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            data['arabic'] ?? '',
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                              fontSize: 18,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Amiri',
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            data['urdu'] ?? '',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.white70 : Colors.black54,
                              fontFamily: 'Jameel Noori Nastaleeq',
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete_sweep_outlined,
                          color: Colors.redAccent,
                        ),
                        onPressed: () => _deleteBookmark(userId, docId),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  // Database se bookmark delete karne ka function
  Future<void> _deleteBookmark(String userId, String docId) async {
    try {
      await _db
          .collection('artifacts')
          .doc(_appId)
          .collection('users')
          .doc(userId)
          .collection('bookmarks')
          .doc(docId)
          .delete();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Dua removed from your list"),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.blueGrey,
          ),
        );
      }
    } catch (e) {
      print("Delete error: $e");
    }
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_add_outlined,
            size: 80,
            color: isDark ? Colors.white10 : Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            "Your list is empty",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white38 : Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Click the + button to explore topics",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
