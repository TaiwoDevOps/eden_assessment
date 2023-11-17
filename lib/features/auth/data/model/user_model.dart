import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String displayName;
  final String email;
  final bool isEmailVerified;
  final bool isAnonymous;
  final String phoneNumber;
  final String photoURL;
  final String refreshToken;
  final String tenantId;
  final String uid;

  const UserModel({
    required this.displayName,
    required this.email,
    required this.isEmailVerified,
    required this.isAnonymous,
    required this.phoneNumber,
    required this.photoURL,
    required this.refreshToken,
    required this.tenantId,
    required this.uid,
  });

  factory UserModel.empty() {
    return const UserModel(
      displayName: '',
      email: '',
      isEmailVerified: false,
      isAnonymous: false,
      phoneNumber: '',
      photoURL: '',
      refreshToken: '',
      tenantId: '',
      uid: '',
    );
  }

  UserModel copyWith({
    String? displayName,
    String? email,
    bool? isEmailVerified,
    bool? isAnonymous,
    String? phoneNumber,
    String? photoURL,
    String? refreshToken,
    String? tenantId,
    String? uid,
  }) {
    return UserModel(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoURL: photoURL ?? this.photoURL,
      refreshToken: refreshToken ?? this.refreshToken,
      tenantId: tenantId ?? this.tenantId,
      uid: uid ?? this.uid,
    );
  }

  bool get isEmpty => this == UserModel.empty();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      displayName: json['displayName'] ?? '',
      email: json['email'] ?? '',
      isEmailVerified: json['isEmailVerified'] ?? false,
      isAnonymous: json['isAnonymous'] ?? false,
      phoneNumber: json['phoneNumber'] ?? '',
      photoURL: json['photoURL'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      tenantId: json['tenantId'] ?? '',
      uid: json['uid'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this.displayName;
    data['email'] = this.email;
    data['isEmailVerified'] = this.isEmailVerified;
    data['isAnonymous'] = this.isAnonymous;
    data['phoneNumber'] = this.phoneNumber;
    data['photoURL'] = this.photoURL;
    data['refreshToken'] = this.refreshToken;
    data['tenantId'] = this.tenantId;
    data['uid'] = this.uid;
    return data;
  }

  @override
  List<Object?> get props => [
        displayName,
        email,
        isEmailVerified,
        isAnonymous,
        phoneNumber,
        photoURL,
        refreshToken,
        tenantId,
        uid,
      ];
}
