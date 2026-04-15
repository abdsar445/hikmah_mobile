import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';
import '../services/chat_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  final ChatService _chatService = ChatService();

  List<Map<String, dynamic>> _messages = [];
  bool _isLoading = false;

  static const String _botName = "Hikmah AI";

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // --- API SE AI RESPONSE MANGWANE KA FUNCTION ---
  Future<void> _handleSendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.insert(0, {"message_text": text, "sender": "user"});
      _isLoading = true;
    });
    _controller.clear();

    try {
      // Backend ko request bhejna (Sirf text bhej rahe hain)
      final aiResponse = await _chatService.sendMessageToBackend(text);

      setState(() {
        _messages.insert(0, {
          "message_text": aiResponse.answer,
          "sender": "bot",
          "sources": aiResponse.sources,
        });
      });
    } catch (e) {
      setState(() {
        _messages.insert(0, {
          "message_text": "Connection Error: Is the backend server running? ⚠️",
          "sender": "bot",
          "sources": [],
        });
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // --- EMOJI ADD KARNE KA FUNCTION ---
  void _addEmoji(String emoji) {
    _controller.text = _controller.text + emoji;
  }

  // --- ATTACHMENT FUNCTIONS ---
  Future<void> _pickImage(ImageSource src) async {
    Navigator.pop(context);
    final picker = ImagePicker();
    final file = await picker.pickImage(source: src, imageQuality: 70);
    if (file != null) {
      setState(() {
        _messages.insert(0, {
          "message_text": "🖼️ Photo selected: ${file.name}",
          "sender": "user",
        });
      });
    }
  }

  Future<void> _pickAudio() async {
    Navigator.pop(context);
    FilePickerResult? res = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );
    if (res != null) {
      setState(() {
        _messages.insert(0, {
          "message_text": "🎵 Audio: ${res.files.first.name}",
          "sender": "user",
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const primaryColor = Color(0xFF006D5B);

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF121212)
          : const Color(0xFFF7FBF9),
      // --- AppBar Fixed Here ---
      appBar: AppBar(
        title: const Text(
          _botName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) =>
                  _buildMessageBubble(_messages[index], isDark, primaryColor),
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Hikmah AI is thinking... 🤔",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          _buildModernInputArea(isDark, primaryColor),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(
    Map<String, dynamic> data,
    bool isDark,
    Color primary,
  ) {
    bool isUser = data['sender'] == 'user';
    final sources = data['sources'] as List<dynamic>?;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUser ? primary : (isDark ? Colors.grey[800] : Colors.white),
          borderRadius: BorderRadius.circular(20).copyWith(
            bottomRight: isUser ? Radius.zero : const Radius.circular(20),
            bottomLeft: isUser ? const Radius.circular(20) : Radius.zero,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data['message_text'] ?? "",
              style: TextStyle(
                color: isUser || isDark ? Colors.white : Colors.black87,
                fontSize: 16,
              ),
            ),
            if (!isUser && sources != null && sources.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                "Sources:",
                style: TextStyle(
                  color: isUser || isDark ? Colors.white70 : Colors.black54,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              ...sources.take(3).map((source) {
                if (source is Map<String, dynamic>) {
                  final hadithNumber = source['hadith_number']?.toString();
                  final narrator = source['narrator']?.toString();
                  final arabicText = source['arabic_text']?.toString();
                  final translationEn = source['translation_en']?.toString();
                  final text = source['text']?.toString() ?? source['matn']?.toString() ?? '';
                  final collection = source['collection']?.toString();
                  final book = source['book']?.toString();
                  final grade = source['grade']?.toString();

                  final header = hadithNumber != null && hadithNumber.isNotEmpty
                      ? 'According to Hadith No. $hadithNumber'
                      : 'Hadith source';
                  final narration = narrator != null && narrator.isNotEmpty
                      ? 'Narrated by $narrator'
                      : null;
                  final sourceLine = book != null && book.isNotEmpty
                      ? (collection != null && collection.isNotEmpty
                          ? '$book • $collection'
                          : book)
                      : (collection ?? 'Unknown source');

                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          header,
                          style: TextStyle(
                            color: isUser || isDark ? Colors.white70 : Colors.black87,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        if (narration != null)
                          Text(
                            narration,
                            style: TextStyle(
                              color: isUser || isDark ? Colors.white60 : Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                        if (sourceLine.isNotEmpty)
                          Text(
                            sourceLine,
                            style: TextStyle(
                              color: isUser || isDark ? Colors.white54 : Colors.black45,
                              fontSize: 12,
                            ),
                          ),
                        if ((arabicText ?? '').isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Arabic hadith:',
                            style: TextStyle(
                              color: isUser || isDark ? Colors.white70 : Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            arabicText!,
                            style: TextStyle(
                              color: isUser || isDark ? Colors.white70 : Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                        ],
                        if ((translationEn ?? '').isNotEmpty || text.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            'In English:',
                            style: TextStyle(
                              color: isUser || isDark ? Colors.white70 : Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            translationEn != null && translationEn.isNotEmpty ? translationEn : text,
                            style: TextStyle(
                              color: isUser || isDark ? Colors.white70 : Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              }).toList(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildModernInputArea(bool isDark, Color primary) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: isDark ? Colors.black : Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // Quick Emojis Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ["😊", "😇", "🕋", "✨", "🙏", "📖", "🌙"].map((e) {
                  return TextButton(
                    onPressed: () => _addEmoji(e),
                    child: Text(e, style: const TextStyle(fontSize: 20)),
                  );
                }).toList(),
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: primary,
                    size: 28,
                  ),
                  onPressed: () => _showAttachmentMenu(isDark),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[900] : Colors.grey[100],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      decoration: const InputDecoration(
                        hintText: "Ask about Islam...",
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _handleSendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: primary,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _handleSendMessage,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAttachmentMenu(bool isDark) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        height: 180,
        color: isDark ? Colors.grey[900] : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _actionBtn(
              Icons.camera_alt,
              "Camera",
              () => _pickImage(ImageSource.camera),
            ),
            _actionBtn(
              Icons.image,
              "Gallery",
              () => _pickImage(ImageSource.gallery),
            ),
            _actionBtn(Icons.audiotrack, "Audio", _pickAudio),
          ],
        ),
      ),
    );
  }

  Widget _actionBtn(IconData icon, String label, VoidCallback tap) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      CircleAvatar(
        radius: 25,
        backgroundColor: const Color(0xFF006D5B).withOpacity(0.1),
        child: IconButton(
          icon: Icon(icon, color: const Color(0xFF006D5B)),
          onPressed: tap,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    ],
  );
}
