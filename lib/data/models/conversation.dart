class Conversation {
  String? sender;
  String? message;
  DateTime? lastMessageDate;
  int unReadCount;
  bool isConnected;

  Conversation({
    this.sender,
    this.message,
    this.lastMessageDate,
    this.unReadCount = 0,
    this.isConnected = false
  });
}