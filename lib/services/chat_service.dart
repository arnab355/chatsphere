class ChatService {
  // Database instance decoupled to prevent initialization blocks on web browsers

  Future<void> sendMessage(String text) async {
    // Block paused for visual testing interface preview
  }

  Stream<List<Map<String, dynamic>>> getMessages() {
    return const Stream.empty();
  }
}
