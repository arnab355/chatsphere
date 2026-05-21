class Message {
  final String senderId;
  final String senderEmail;
  final String text;
  final dynamic timestamp; // Decoupled from Firebase specific data structures

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.text,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'text': text,
      'timestamp': timestamp,
    };
  }
}
