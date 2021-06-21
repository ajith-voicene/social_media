import 'dart:convert';

class Data {
  final String userName;
  final String postUserPhoto;
  final int userId;
  final int id;
  final String content;
  int isLiked;
  final String firstAttachmentType;
  final String firstAttachmentUrl;
  int likes;
  int comments;
  final String createdAt;
  final String privacy;
  final List<Attachment> attachment;
  Data(
      {this.userName,
      this.postUserPhoto,
      this.userId,
      this.id,
      this.content,
      this.isLiked,
      this.firstAttachmentType,
      this.firstAttachmentUrl,
      this.likes,
      this.comments,
      this.createdAt,
      this.privacy,
      this.attachment});

  Map<String, dynamic> toMap() {
    return {
      'user_name': userName,
      'post_user_photo': postUserPhoto,
      'user_id': userId,
      'id': id,
      'content': content,
      'is_liked': isLiked,
      'first_attachment_type': firstAttachmentType,
      'first_attachment_url': firstAttachmentUrl,
      'likes': likes,
      'comments': comments,
      'created_at': createdAt,
      'privacy': privacy,
      'post_attachment': attachment?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      userName: map['user_name'],
      postUserPhoto: map['post_user_photo'],
      userId: map['user_id'],
      id: map['id'],
      content: map['content'],
      isLiked: map['is_liked'],
      firstAttachmentType: map['first_attachment_type'],
      firstAttachmentUrl: map['first_attachment_url'],
      likes: map['likes'],
      comments: map['comments'],
      createdAt: map['created_at'],
      privacy: map['privacy'],
      attachment: List<Attachment>.from(
          map['post_attachment']?.map((x) => Attachment.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));

  Data copyWith({
    String userName,
    String postUserPhoto,
    int userId,
    int id,
    String content,
    int isLiked,
    String firstAttachmentType,
    String firstAttachmentUrl,
    int likes,
    int comments,
    String createdAt,
    String privacy,
    List<Attachment> attachment,
  }) {
    return Data(
      userName: userName ?? this.userName,
      postUserPhoto: postUserPhoto ?? this.postUserPhoto,
      userId: userId ?? this.userId,
      id: id ?? this.id,
      content: content ?? this.content,
      isLiked: isLiked ?? this.isLiked,
      firstAttachmentType: firstAttachmentType ?? this.firstAttachmentType,
      firstAttachmentUrl: firstAttachmentUrl ?? this.firstAttachmentUrl,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      createdAt: createdAt ?? this.createdAt,
      privacy: privacy ?? this.privacy,
      attachment: attachment ?? this.attachment,
    );
  }
}

class Attachment {
  String fileType;
  String postAttachmentUrl;
  int id;
  int postId;
  Attachment({
    this.fileType,
    this.postAttachmentUrl,
    this.id,
    this.postId,
  });

  Map<String, dynamic> toMap() {
    return {
      'file_type': fileType,
      'post_attachment_url': postAttachmentUrl,
      'id': id,
      'post_id': postId,
    };
  }

  factory Attachment.fromMap(Map<String, dynamic> map) {
    return Attachment(
      fileType: map['file_type'],
      postAttachmentUrl: map['post_attachment_url'],
      id: map['id'],
      postId: map['post_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Attachment.fromJson(String source) =>
      Attachment.fromMap(json.decode(source));
}

class Comment {
  final String userName;
  final String commentUserPhoto;
  final int userId;
  final int id;
  final String content;
  final int postId;
  final String createdAt;
  Comment({
    this.userName,
    this.commentUserPhoto,
    this.userId,
    this.id,
    this.content,
    this.postId,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_name': userName,
      'comment_user_photo': commentUserPhoto,
      'user_id': userId,
      'id': id,
      'content': content,
      'post_id': postId,
      'created_at': createdAt,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      userName: map['user_name'],
      commentUserPhoto: map['comment_user_photo'],
      userId: map['user_id'],
      id: map['id'],
      content: map['content'],
      postId: map['post_id'],
      createdAt: map['created_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source));
}

class User {
  final String profilePhotoUrl;
  final String name;
  final int id;
  final String email;
  final String createdAt;
  final String isFriend;
  final int friendRequests;
  final int requestedUserId;
  final int friendsCount;
  final int followersCount;
  final int followingCount;
  final int isFollowing;
  User({
    this.profilePhotoUrl,
    this.name,
    this.id,
    this.email,
    this.createdAt,
    this.isFriend,
    this.friendRequests = 0,
    this.requestedUserId,
    this.friendsCount,
    this.followersCount,
    this.followingCount,
    this.isFollowing = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'profile_photo_url': profilePhotoUrl,
      'name': name,
      'id': id,
      'email': email,
      'created_at': createdAt,
      'is_friend': isFriend,
      'friend_requests': friendRequests,
      'requested_user_id': requestedUserId,
      'friends_count': friendsCount,
      'followings_count': followingCount,
      'followers_count': followersCount,
      'is_following': isFollowing
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        profilePhotoUrl: map['profile_photo_url'],
        name: map['name'],
        id: map['id'],
        email: map['email'],
        createdAt: map['created_at'],
        isFriend: map['is_friend'],
        friendRequests: map['friend_requests'],
        requestedUserId: map['requested_user_id'],
        friendsCount: map['friends_count'],
        followingCount: map['followings_count'],
        followersCount: map['followers_count'],
        isFollowing: map['is_following']);
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
