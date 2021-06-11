import 'dart:convert';

class Data {
  final String userName;
  final String postUserPhoto;
  final int userId;
  final int id;
  final String content;
  final int isLiked;
  final String firstAttachmentType;
  final String firstAttachmentUrl;
  final int likes;
  final int comments;
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
