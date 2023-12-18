// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatNotification {
  final String title;
  final String body;

  ChatNotification({
    required this.title,
    required this.body,
  });

  @override
  bool operator ==(covariant ChatNotification other) {
    if (identical(this, other)) return true;

    return other.title == title && other.body == body;
  }

  @override
  int get hashCode => title.hashCode ^ body.hashCode;
}
