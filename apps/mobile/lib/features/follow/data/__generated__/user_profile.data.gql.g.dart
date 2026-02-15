// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUserProfileData> _$gUserProfileDataSerializer =
    _$GUserProfileDataSerializer();
Serializer<GUserProfileData_userProfile>
    _$gUserProfileDataUserProfileSerializer =
    _$GUserProfileData_userProfileSerializer();
Serializer<GUserProfileData_userProfile_user>
    _$gUserProfileDataUserProfileUserSerializer =
    _$GUserProfileData_userProfile_userSerializer();
Serializer<GUserProfileData_userProfile_followCounts>
    _$gUserProfileDataUserProfileFollowCountsSerializer =
    _$GUserProfileData_userProfile_followCountsSerializer();

class _$GUserProfileDataSerializer
    implements StructuredSerializer<GUserProfileData> {
  @override
  final Iterable<Type> types = const [GUserProfileData, _$GUserProfileData];
  @override
  final String wireName = 'GUserProfileData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GUserProfileData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.userProfile;
    if (value != null) {
      result
        ..add('userProfile')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GUserProfileData_userProfile)));
    }
    return result;
  }

  @override
  GUserProfileData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUserProfileDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'userProfile':
          result.userProfile.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GUserProfileData_userProfile))!
              as GUserProfileData_userProfile);
          break;
      }
    }

    return result.build();
  }
}

class _$GUserProfileData_userProfileSerializer
    implements StructuredSerializer<GUserProfileData_userProfile> {
  @override
  final Iterable<Type> types = const [
    GUserProfileData_userProfile,
    _$GUserProfileData_userProfile
  ];
  @override
  final String wireName = 'GUserProfileData_userProfile';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUserProfileData_userProfile object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.user;
    if (value != null) {
      result
        ..add('user')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GUserProfileData_userProfile_user)));
    }
    value = object.outgoingFollowStatus;
    if (value != null) {
      result
        ..add('outgoingFollowStatus')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GFollowStatus)));
    }
    value = object.incomingFollowStatus;
    if (value != null) {
      result
        ..add('incomingFollowStatus')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GFollowStatus)));
    }
    value = object.followCounts;
    if (value != null) {
      result
        ..add('followCounts')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(GUserProfileData_userProfile_followCounts)));
    }
    value = object.isOwnProfile;
    if (value != null) {
      result
        ..add('isOwnProfile')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  GUserProfileData_userProfile deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUserProfileData_userProfileBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'user':
          result.user.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GUserProfileData_userProfile_user))!
              as GUserProfileData_userProfile_user);
          break;
        case 'outgoingFollowStatus':
          result.outgoingFollowStatus = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GFollowStatus))
              as _i2.GFollowStatus?;
          break;
        case 'incomingFollowStatus':
          result.incomingFollowStatus = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GFollowStatus))
              as _i2.GFollowStatus?;
          break;
        case 'followCounts':
          result.followCounts.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GUserProfileData_userProfile_followCounts))!
              as GUserProfileData_userProfile_followCounts);
          break;
        case 'isOwnProfile':
          result.isOwnProfile = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$GUserProfileData_userProfile_userSerializer
    implements StructuredSerializer<GUserProfileData_userProfile_user> {
  @override
  final Iterable<Type> types = const [
    GUserProfileData_userProfile_user,
    _$GUserProfileData_userProfile_user
  ];
  @override
  final String wireName = 'GUserProfileData_userProfile_user';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUserProfileData_userProfile_user object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'bookCount',
      serializers.serialize(object.bookCount,
          specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.avatarUrl;
    if (value != null) {
      result
        ..add('avatarUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.handle;
    if (value != null) {
      result
        ..add('handle')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.bio;
    if (value != null) {
      result
        ..add('bio')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.instagramHandle;
    if (value != null) {
      result
        ..add('instagramHandle')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.shareUrl;
    if (value != null) {
      result
        ..add('shareUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GUserProfileData_userProfile_user deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUserProfileData_userProfile_userBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'avatarUrl':
          result.avatarUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'handle':
          result.handle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'bio':
          result.bio = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'bookCount':
          result.bookCount = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'instagramHandle':
          result.instagramHandle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'shareUrl':
          result.shareUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GUserProfileData_userProfile_followCountsSerializer
    implements StructuredSerializer<GUserProfileData_userProfile_followCounts> {
  @override
  final Iterable<Type> types = const [
    GUserProfileData_userProfile_followCounts,
    _$GUserProfileData_userProfile_followCounts
  ];
  @override
  final String wireName = 'GUserProfileData_userProfile_followCounts';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUserProfileData_userProfile_followCounts object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.followingCount;
    if (value != null) {
      result
        ..add('followingCount')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.followerCount;
    if (value != null) {
      result
        ..add('followerCount')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  GUserProfileData_userProfile_followCounts deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUserProfileData_userProfile_followCountsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'followingCount':
          result.followingCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'followerCount':
          result.followerCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$GUserProfileData extends GUserProfileData {
  @override
  final String G__typename;
  @override
  final GUserProfileData_userProfile? userProfile;

  factory _$GUserProfileData(
          [void Function(GUserProfileDataBuilder)? updates]) =>
      (GUserProfileDataBuilder()..update(updates))._build();

  _$GUserProfileData._({required this.G__typename, this.userProfile})
      : super._();
  @override
  GUserProfileData rebuild(void Function(GUserProfileDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUserProfileDataBuilder toBuilder() =>
      GUserProfileDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUserProfileData &&
        G__typename == other.G__typename &&
        userProfile == other.userProfile;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, userProfile.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUserProfileData')
          ..add('G__typename', G__typename)
          ..add('userProfile', userProfile))
        .toString();
  }
}

class GUserProfileDataBuilder
    implements Builder<GUserProfileData, GUserProfileDataBuilder> {
  _$GUserProfileData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GUserProfileData_userProfileBuilder? _userProfile;
  GUserProfileData_userProfileBuilder get userProfile =>
      _$this._userProfile ??= GUserProfileData_userProfileBuilder();
  set userProfile(GUserProfileData_userProfileBuilder? userProfile) =>
      _$this._userProfile = userProfile;

  GUserProfileDataBuilder() {
    GUserProfileData._initializeBuilder(this);
  }

  GUserProfileDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _userProfile = $v.userProfile?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUserProfileData other) {
    _$v = other as _$GUserProfileData;
  }

  @override
  void update(void Function(GUserProfileDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUserProfileData build() => _build();

  _$GUserProfileData _build() {
    _$GUserProfileData _$result;
    try {
      _$result = _$v ??
          _$GUserProfileData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GUserProfileData', 'G__typename'),
            userProfile: _userProfile?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'userProfile';
        _userProfile?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GUserProfileData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUserProfileData_userProfile extends GUserProfileData_userProfile {
  @override
  final String G__typename;
  @override
  final GUserProfileData_userProfile_user? user;
  @override
  final _i2.GFollowStatus? outgoingFollowStatus;
  @override
  final _i2.GFollowStatus? incomingFollowStatus;
  @override
  final GUserProfileData_userProfile_followCounts? followCounts;
  @override
  final bool? isOwnProfile;

  factory _$GUserProfileData_userProfile(
          [void Function(GUserProfileData_userProfileBuilder)? updates]) =>
      (GUserProfileData_userProfileBuilder()..update(updates))._build();

  _$GUserProfileData_userProfile._(
      {required this.G__typename,
      this.user,
      this.outgoingFollowStatus,
      this.incomingFollowStatus,
      this.followCounts,
      this.isOwnProfile})
      : super._();
  @override
  GUserProfileData_userProfile rebuild(
          void Function(GUserProfileData_userProfileBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUserProfileData_userProfileBuilder toBuilder() =>
      GUserProfileData_userProfileBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUserProfileData_userProfile &&
        G__typename == other.G__typename &&
        user == other.user &&
        outgoingFollowStatus == other.outgoingFollowStatus &&
        incomingFollowStatus == other.incomingFollowStatus &&
        followCounts == other.followCounts &&
        isOwnProfile == other.isOwnProfile;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, outgoingFollowStatus.hashCode);
    _$hash = $jc(_$hash, incomingFollowStatus.hashCode);
    _$hash = $jc(_$hash, followCounts.hashCode);
    _$hash = $jc(_$hash, isOwnProfile.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUserProfileData_userProfile')
          ..add('G__typename', G__typename)
          ..add('user', user)
          ..add('outgoingFollowStatus', outgoingFollowStatus)
          ..add('incomingFollowStatus', incomingFollowStatus)
          ..add('followCounts', followCounts)
          ..add('isOwnProfile', isOwnProfile))
        .toString();
  }
}

class GUserProfileData_userProfileBuilder
    implements
        Builder<GUserProfileData_userProfile,
            GUserProfileData_userProfileBuilder> {
  _$GUserProfileData_userProfile? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GUserProfileData_userProfile_userBuilder? _user;
  GUserProfileData_userProfile_userBuilder get user =>
      _$this._user ??= GUserProfileData_userProfile_userBuilder();
  set user(GUserProfileData_userProfile_userBuilder? user) =>
      _$this._user = user;

  _i2.GFollowStatus? _outgoingFollowStatus;
  _i2.GFollowStatus? get outgoingFollowStatus => _$this._outgoingFollowStatus;
  set outgoingFollowStatus(_i2.GFollowStatus? outgoingFollowStatus) =>
      _$this._outgoingFollowStatus = outgoingFollowStatus;

  _i2.GFollowStatus? _incomingFollowStatus;
  _i2.GFollowStatus? get incomingFollowStatus => _$this._incomingFollowStatus;
  set incomingFollowStatus(_i2.GFollowStatus? incomingFollowStatus) =>
      _$this._incomingFollowStatus = incomingFollowStatus;

  GUserProfileData_userProfile_followCountsBuilder? _followCounts;
  GUserProfileData_userProfile_followCountsBuilder get followCounts =>
      _$this._followCounts ??=
          GUserProfileData_userProfile_followCountsBuilder();
  set followCounts(
          GUserProfileData_userProfile_followCountsBuilder? followCounts) =>
      _$this._followCounts = followCounts;

  bool? _isOwnProfile;
  bool? get isOwnProfile => _$this._isOwnProfile;
  set isOwnProfile(bool? isOwnProfile) => _$this._isOwnProfile = isOwnProfile;

  GUserProfileData_userProfileBuilder() {
    GUserProfileData_userProfile._initializeBuilder(this);
  }

  GUserProfileData_userProfileBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _user = $v.user?.toBuilder();
      _outgoingFollowStatus = $v.outgoingFollowStatus;
      _incomingFollowStatus = $v.incomingFollowStatus;
      _followCounts = $v.followCounts?.toBuilder();
      _isOwnProfile = $v.isOwnProfile;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUserProfileData_userProfile other) {
    _$v = other as _$GUserProfileData_userProfile;
  }

  @override
  void update(void Function(GUserProfileData_userProfileBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUserProfileData_userProfile build() => _build();

  _$GUserProfileData_userProfile _build() {
    _$GUserProfileData_userProfile _$result;
    try {
      _$result = _$v ??
          _$GUserProfileData_userProfile._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GUserProfileData_userProfile', 'G__typename'),
            user: _user?.build(),
            outgoingFollowStatus: outgoingFollowStatus,
            incomingFollowStatus: incomingFollowStatus,
            followCounts: _followCounts?.build(),
            isOwnProfile: isOwnProfile,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        _user?.build();

        _$failedField = 'followCounts';
        _followCounts?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GUserProfileData_userProfile', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUserProfileData_userProfile_user
    extends GUserProfileData_userProfile_user {
  @override
  final String G__typename;
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? avatarUrl;
  @override
  final String? handle;
  @override
  final String? bio;
  @override
  final int bookCount;
  @override
  final String? instagramHandle;
  @override
  final String? shareUrl;

  factory _$GUserProfileData_userProfile_user(
          [void Function(GUserProfileData_userProfile_userBuilder)? updates]) =>
      (GUserProfileData_userProfile_userBuilder()..update(updates))._build();

  _$GUserProfileData_userProfile_user._(
      {required this.G__typename,
      this.id,
      this.name,
      this.avatarUrl,
      this.handle,
      this.bio,
      required this.bookCount,
      this.instagramHandle,
      this.shareUrl})
      : super._();
  @override
  GUserProfileData_userProfile_user rebuild(
          void Function(GUserProfileData_userProfile_userBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUserProfileData_userProfile_userBuilder toBuilder() =>
      GUserProfileData_userProfile_userBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUserProfileData_userProfile_user &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name &&
        avatarUrl == other.avatarUrl &&
        handle == other.handle &&
        bio == other.bio &&
        bookCount == other.bookCount &&
        instagramHandle == other.instagramHandle &&
        shareUrl == other.shareUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, avatarUrl.hashCode);
    _$hash = $jc(_$hash, handle.hashCode);
    _$hash = $jc(_$hash, bio.hashCode);
    _$hash = $jc(_$hash, bookCount.hashCode);
    _$hash = $jc(_$hash, instagramHandle.hashCode);
    _$hash = $jc(_$hash, shareUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUserProfileData_userProfile_user')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name)
          ..add('avatarUrl', avatarUrl)
          ..add('handle', handle)
          ..add('bio', bio)
          ..add('bookCount', bookCount)
          ..add('instagramHandle', instagramHandle)
          ..add('shareUrl', shareUrl))
        .toString();
  }
}

class GUserProfileData_userProfile_userBuilder
    implements
        Builder<GUserProfileData_userProfile_user,
            GUserProfileData_userProfile_userBuilder> {
  _$GUserProfileData_userProfile_user? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _avatarUrl;
  String? get avatarUrl => _$this._avatarUrl;
  set avatarUrl(String? avatarUrl) => _$this._avatarUrl = avatarUrl;

  String? _handle;
  String? get handle => _$this._handle;
  set handle(String? handle) => _$this._handle = handle;

  String? _bio;
  String? get bio => _$this._bio;
  set bio(String? bio) => _$this._bio = bio;

  int? _bookCount;
  int? get bookCount => _$this._bookCount;
  set bookCount(int? bookCount) => _$this._bookCount = bookCount;

  String? _instagramHandle;
  String? get instagramHandle => _$this._instagramHandle;
  set instagramHandle(String? instagramHandle) =>
      _$this._instagramHandle = instagramHandle;

  String? _shareUrl;
  String? get shareUrl => _$this._shareUrl;
  set shareUrl(String? shareUrl) => _$this._shareUrl = shareUrl;

  GUserProfileData_userProfile_userBuilder() {
    GUserProfileData_userProfile_user._initializeBuilder(this);
  }

  GUserProfileData_userProfile_userBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _avatarUrl = $v.avatarUrl;
      _handle = $v.handle;
      _bio = $v.bio;
      _bookCount = $v.bookCount;
      _instagramHandle = $v.instagramHandle;
      _shareUrl = $v.shareUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUserProfileData_userProfile_user other) {
    _$v = other as _$GUserProfileData_userProfile_user;
  }

  @override
  void update(
      void Function(GUserProfileData_userProfile_userBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUserProfileData_userProfile_user build() => _build();

  _$GUserProfileData_userProfile_user _build() {
    final _$result = _$v ??
        _$GUserProfileData_userProfile_user._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GUserProfileData_userProfile_user', 'G__typename'),
          id: id,
          name: name,
          avatarUrl: avatarUrl,
          handle: handle,
          bio: bio,
          bookCount: BuiltValueNullFieldError.checkNotNull(
              bookCount, r'GUserProfileData_userProfile_user', 'bookCount'),
          instagramHandle: instagramHandle,
          shareUrl: shareUrl,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GUserProfileData_userProfile_followCounts
    extends GUserProfileData_userProfile_followCounts {
  @override
  final String G__typename;
  @override
  final int? followingCount;
  @override
  final int? followerCount;

  factory _$GUserProfileData_userProfile_followCounts(
          [void Function(GUserProfileData_userProfile_followCountsBuilder)?
              updates]) =>
      (GUserProfileData_userProfile_followCountsBuilder()..update(updates))
          ._build();

  _$GUserProfileData_userProfile_followCounts._(
      {required this.G__typename, this.followingCount, this.followerCount})
      : super._();
  @override
  GUserProfileData_userProfile_followCounts rebuild(
          void Function(GUserProfileData_userProfile_followCountsBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUserProfileData_userProfile_followCountsBuilder toBuilder() =>
      GUserProfileData_userProfile_followCountsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUserProfileData_userProfile_followCounts &&
        G__typename == other.G__typename &&
        followingCount == other.followingCount &&
        followerCount == other.followerCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, followingCount.hashCode);
    _$hash = $jc(_$hash, followerCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GUserProfileData_userProfile_followCounts')
          ..add('G__typename', G__typename)
          ..add('followingCount', followingCount)
          ..add('followerCount', followerCount))
        .toString();
  }
}

class GUserProfileData_userProfile_followCountsBuilder
    implements
        Builder<GUserProfileData_userProfile_followCounts,
            GUserProfileData_userProfile_followCountsBuilder> {
  _$GUserProfileData_userProfile_followCounts? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _followingCount;
  int? get followingCount => _$this._followingCount;
  set followingCount(int? followingCount) =>
      _$this._followingCount = followingCount;

  int? _followerCount;
  int? get followerCount => _$this._followerCount;
  set followerCount(int? followerCount) =>
      _$this._followerCount = followerCount;

  GUserProfileData_userProfile_followCountsBuilder() {
    GUserProfileData_userProfile_followCounts._initializeBuilder(this);
  }

  GUserProfileData_userProfile_followCountsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _followingCount = $v.followingCount;
      _followerCount = $v.followerCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUserProfileData_userProfile_followCounts other) {
    _$v = other as _$GUserProfileData_userProfile_followCounts;
  }

  @override
  void update(
      void Function(GUserProfileData_userProfile_followCountsBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GUserProfileData_userProfile_followCounts build() => _build();

  _$GUserProfileData_userProfile_followCounts _build() {
    final _$result = _$v ??
        _$GUserProfileData_userProfile_followCounts._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GUserProfileData_userProfile_followCounts', 'G__typename'),
          followingCount: followingCount,
          followerCount: followerCount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
