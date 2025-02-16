import 'package:intl/intl.dart';
import 'package:soluxe/models/post_summary.dart';
import 'package:soluxe/models/user_summary.dart';

enum NotificationType { comment, invitation }

class NotificationModel {
  final UserSummary user; // The user who triggered the notification
  final PostSummary? post; // Only exists for comment notifications
  final String message; // Main notification text
  final String dateString; // Timestamp
  final String invitationLocation;
  final NotificationType type;

  // Constructor for comment notifications
  NotificationModel.comment({
    required this.user,
    required this.message,
    required this.dateString,
    required this.post,
  })  : type = NotificationType.comment,
        invitationLocation = '';

  // Constructor for invitation notifications
  NotificationModel.invitation({
    required this.user,
    required this.message,
    required this.dateString,
    required this.invitationLocation,
  })  : type = NotificationType.invitation,
        post = null;

  DateTime get date => DateTime.parse(dateString);
  String get formattedDate => DateFormat("MMMM d, y 'in' HH:mm").format(date);
  bool get isComment => type == NotificationType.comment;
}
