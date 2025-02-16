import 'package:soluxe/models/notification.dart';
import 'package:soluxe/models/post_summary.dart';
import 'package:soluxe/models/user_summary.dart';

final notifications = [
  NotificationModel.comment(
    user: UserSummary(
      id: "456",
      name: "Alice",
      profileImgSrc: "",
    ),
    message: "commented on",
    dateString: '2025-02-16T10:18:16.153Z',
    post: PostSummary(
      id: "3",
      title: "How to Stay Productive",
    ),
  ),
  NotificationModel.comment(
    user: UserSummary(
      id: "789",
      name: "Emma",
      profileImgSrc: "https://randomuser.me/api/portraits/women/22.jpg",
    ),
    message: "commented on",
    dateString: '2025-02-16T10:18:16.153Z',
    post: PostSummary(
      id: "2",
      title: "Best Programming Languages",
    ),
  ),
  NotificationModel.comment(
    user: UserSummary(
      id: "456",
      name: "Alice",
      profileImgSrc: "https://randomuser.me/api/portraits/women/50.jpg",
    ),
    message: "commented on your post",
    dateString: '2025-02-16T10:18:16.153Z',
    post: PostSummary(id: "1", title: "The Future of AI"),
  ),
  NotificationModel.comment(
    user: UserSummary(
      id: "123",
      name: "David",
      profileImgSrc: "https://randomuser.me/api/portraits/men/45.jpg",
    ),
    message: "commented on",
    dateString: '2025-02-16T10:18:16.153Z',
    post: PostSummary(
      id: "3",
      title: "How to Stay Productive",
    ),
  ),
  NotificationModel.comment(
    user: UserSummary(
      id: "456",
      name: "Alice",
      profileImgSrc: "https://randomuser.me/api/portraits/women/50.jpg",
    ),
    message: "commented on",
    dateString: '2025-02-16T10:18:16.153Z',
    post: PostSummary(
      id: "2",
      title: "Best Programming Languages",
    ),
  ),
  NotificationModel.invitation(
    user: UserSummary(
      id: "456",
      name: "Alice",
      profileImgSrc: "https://randomuser.me/api/portraits/women/50.jpg",
    ),
    message: "invited you to",
    invitationLocation: 'Tech Conference in Berlin',
    dateString: '2025-02-16T10:18:16.153Z',
  ),
  NotificationModel.invitation(
    user: UserSummary(
      id: "123",
      name: "David",
      profileImgSrc: "https://randomuser.me/api/portraits/men/45.jpg",
    ),
    message: "invited you to Game Night in",
    dateString: '2025-02-16T10:18:16.153Z',
    invitationLocation: 'New York',
  ),
  NotificationModel.invitation(
    user: UserSummary(
      id: "123",
      name: "David",
      profileImgSrc: "https://randomuser.me/api/portraits/men/45.jpg",
    ),
    message: "invited you to Startup Meetup in",
    invitationLocation: 'Berlin',
    dateString: '2025-02-16T10:18:16.153Z',
  ),
];
