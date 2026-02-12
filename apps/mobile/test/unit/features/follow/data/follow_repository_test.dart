import 'dart:async';
import 'dart:io';

import 'package:ferry/ferry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/approve_follow_request.data.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/approve_follow_request.req.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/approve_follow_request.var.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/follow_counts.data.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/follow_counts.req.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/follow_counts.var.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/followers.data.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/followers.req.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/followers.var.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/following.data.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/following.req.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/following.var.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/pending_follow_request_count.data.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/pending_follow_request_count.req.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/pending_follow_request_count.var.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/pending_follow_requests.data.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/pending_follow_requests.req.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/pending_follow_requests.var.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/reject_follow_request.data.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/reject_follow_request.req.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/reject_follow_request.var.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/send_follow_request.data.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/send_follow_request.req.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/send_follow_request.var.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/unfollow.data.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/unfollow.req.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/unfollow.var.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/user_profile.data.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/user_profile.req.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/user_profile.var.gql.dart';
import 'package:shelfie/features/follow/data/follow_repository.dart';
import 'package:shelfie/features/follow/domain/follow_request_status.dart';
import 'package:shelfie/features/follow/domain/follow_status_type.dart';

class MockClient extends Mock implements Client {}

void main() {
  late MockClient mockClient;
  late FollowRepository repository;

  setUpAll(() {
    registerFallbackValue(GSendFollowRequestReq(
      (b) => b..vars.receiverId = 0,
    ));
    registerFallbackValue(GApproveFollowRequestReq(
      (b) => b..vars.requestId = 0,
    ));
    registerFallbackValue(GRejectFollowRequestReq(
      (b) => b..vars.requestId = 0,
    ));
    registerFallbackValue(GUnfollowReq(
      (b) => b..vars.targetUserId = 0,
    ));
    registerFallbackValue(GPendingFollowRequestsReq());
    registerFallbackValue(GPendingFollowRequestCountReq());
    registerFallbackValue(GFollowingReq(
      (b) => b..vars.userId = 0,
    ));
    registerFallbackValue(GFollowersReq(
      (b) => b..vars.userId = 0,
    ));
    registerFallbackValue(GFollowCountsReq(
      (b) => b..vars.userId = 0,
    ));
    registerFallbackValue(GUserProfileReq(
      (b) => b..vars.handle = '',
    ));
  });

  setUp(() {
    mockClient = MockClient();
    repository = FollowRepository(client: mockClient);
  });

  group('sendFollowRequest', () {
    test('成功時に FollowRequestModel を返す', () async {
      final now = DateTime(2024, 1, 1);
      final successData =
          GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess(
        (b) => b
          ..data.id = 1
          ..data.senderId = 10
          ..data.receiverId = 20
          ..data.status = GFollowRequestStatus.PENDING
          ..data.createdAt = now,
      );
      final responseData = GSendFollowRequestData(
        (b) => b..sendFollowRequest = successData,
      );
      final response = OperationResponse<GSendFollowRequestData,
          GSendFollowRequestVars>(
        operationRequest: GSendFollowRequestReq(
          (b) => b
            ..vars.receiverId = 20
            ..fetchPolicy = FetchPolicy.NetworkOnly,
        ),
        data: responseData,
      );

      when(() => mockClient.request(any<GSendFollowRequestReq>()))
          .thenAnswer((_) => Stream.value(response));

      final result = await repository.sendFollowRequest(receiverId: 20);

      expect(result.isRight(), true);
      final model = result.getOrElse((_) => throw Exception('Expected Right'));
      expect(model.id, 1);
      expect(model.sender.id, 10);
      expect(model.receiver.id, 20);
      expect(model.status, FollowRequestStatus.pending);
      expect(model.createdAt, now);
    });

    test('ValidationError 時に ValidationFailure を返す', () async {
      final validationError =
          GSendFollowRequestData_sendFollowRequest__asValidationError(
        (b) => b
          ..message = 'Already following'
          ..code = 'ALREADY_FOLLOWING',
      );
      final responseData = GSendFollowRequestData(
        (b) => b..sendFollowRequest = validationError,
      );
      final response = OperationResponse<GSendFollowRequestData,
          GSendFollowRequestVars>(
        operationRequest: GSendFollowRequestReq(
          (b) => b
            ..vars.receiverId = 20
            ..fetchPolicy = FetchPolicy.NetworkOnly,
        ),
        data: responseData,
      );

      when(() => mockClient.request(any<GSendFollowRequestReq>()))
          .thenAnswer((_) => Stream.value(response));

      final result = await repository.sendFollowRequest(receiverId: 20);

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ValidationFailure>()),
        (_) => fail('Expected Left'),
      );
    });

    test('SocketException 時に NetworkFailure を返す', () async {
      when(() => mockClient.request(any<GSendFollowRequestReq>()))
          .thenThrow(const SocketException('No internet'));

      final result = await repository.sendFollowRequest(receiverId: 20);

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<NetworkFailure>()),
        (_) => fail('Expected Left'),
      );
    });

    test('null レスポンス時に ServerFailure を返す', () async {
      final response = OperationResponse<GSendFollowRequestData,
          GSendFollowRequestVars>(
        operationRequest: GSendFollowRequestReq(
          (b) => b
            ..vars.receiverId = 20
            ..fetchPolicy = FetchPolicy.NetworkOnly,
        ),
        data: null,
      );

      when(() => mockClient.request(any<GSendFollowRequestReq>()))
          .thenAnswer((_) => Stream.value(response));

      final result = await repository.sendFollowRequest(receiverId: 20);

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  group('approveFollowRequest', () {
    test('成功時に FollowRequestModel を返す', () async {
      final now = DateTime(2024, 1, 1);
      final successData =
          GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess(
        (b) => b
          ..data.id = 1
          ..data.senderId = 10
          ..data.receiverId = 20
          ..data.status = GFollowRequestStatus.APPROVED
          ..data.createdAt = now,
      );
      final responseData = GApproveFollowRequestData(
        (b) => b..approveFollowRequest = successData,
      );
      final response = OperationResponse<GApproveFollowRequestData,
          GApproveFollowRequestVars>(
        operationRequest: GApproveFollowRequestReq(
          (b) => b
            ..vars.requestId = 1
            ..fetchPolicy = FetchPolicy.NetworkOnly,
        ),
        data: responseData,
      );

      when(() => mockClient.request(any<GApproveFollowRequestReq>()))
          .thenAnswer((_) => Stream.value(response));

      final result = await repository.approveFollowRequest(requestId: 1);

      expect(result.isRight(), true);
      final model = result.getOrElse((_) => throw Exception('Expected Right'));
      expect(model.id, 1);
      expect(model.status, FollowRequestStatus.approved);
    });

    test('ValidationError 時に ValidationFailure を返す', () async {
      final validationError =
          GApproveFollowRequestData_approveFollowRequest__asValidationError(
        (b) => b
          ..message = 'Request not found'
          ..code = 'NOT_FOUND',
      );
      final responseData = GApproveFollowRequestData(
        (b) => b..approveFollowRequest = validationError,
      );
      final response = OperationResponse<GApproveFollowRequestData,
          GApproveFollowRequestVars>(
        operationRequest: GApproveFollowRequestReq(
          (b) => b
            ..vars.requestId = 1
            ..fetchPolicy = FetchPolicy.NetworkOnly,
        ),
        data: responseData,
      );

      when(() => mockClient.request(any<GApproveFollowRequestReq>()))
          .thenAnswer((_) => Stream.value(response));

      final result = await repository.approveFollowRequest(requestId: 1);

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ValidationFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  group('rejectFollowRequest', () {
    test('成功時に FollowRequestModel を返す', () async {
      final now = DateTime(2024, 1, 1);
      final successData =
          GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess(
        (b) => b
          ..data.id = 1
          ..data.senderId = 10
          ..data.receiverId = 20
          ..data.status = GFollowRequestStatus.REJECTED
          ..data.createdAt = now,
      );
      final responseData = GRejectFollowRequestData(
        (b) => b..rejectFollowRequest = successData,
      );
      final response = OperationResponse<GRejectFollowRequestData,
          GRejectFollowRequestVars>(
        operationRequest: GRejectFollowRequestReq(
          (b) => b
            ..vars.requestId = 1
            ..fetchPolicy = FetchPolicy.NetworkOnly,
        ),
        data: responseData,
      );

      when(() => mockClient.request(any<GRejectFollowRequestReq>()))
          .thenAnswer((_) => Stream.value(response));

      final result = await repository.rejectFollowRequest(requestId: 1);

      expect(result.isRight(), true);
      final model = result.getOrElse((_) => throw Exception('Expected Right'));
      expect(model.id, 1);
      expect(model.status, FollowRequestStatus.rejected);
    });

    test('ValidationError 時に ValidationFailure を返す', () async {
      final validationError =
          GRejectFollowRequestData_rejectFollowRequest__asValidationError(
        (b) => b
          ..message = 'Request not found'
          ..code = 'NOT_FOUND',
      );
      final responseData = GRejectFollowRequestData(
        (b) => b..rejectFollowRequest = validationError,
      );
      final response = OperationResponse<GRejectFollowRequestData,
          GRejectFollowRequestVars>(
        operationRequest: GRejectFollowRequestReq(
          (b) => b
            ..vars.requestId = 1
            ..fetchPolicy = FetchPolicy.NetworkOnly,
        ),
        data: responseData,
      );

      when(() => mockClient.request(any<GRejectFollowRequestReq>()))
          .thenAnswer((_) => Stream.value(response));

      final result = await repository.rejectFollowRequest(requestId: 1);

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ValidationFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  group('unfollow', () {
    test('成功時に Right(null) を返す', () async {
      final successData =
          GUnfollowData_unfollow__asMutationUnfollowSuccess(
        (b) => b..data = true,
      );
      final responseData = GUnfollowData(
        (b) => b..unfollow = successData,
      );
      final response =
          OperationResponse<GUnfollowData, GUnfollowVars>(
        operationRequest: GUnfollowReq(
          (b) => b
            ..vars.targetUserId = 20
            ..fetchPolicy = FetchPolicy.NetworkOnly,
        ),
        data: responseData,
      );

      when(() => mockClient.request(any<GUnfollowReq>()))
          .thenAnswer((_) => Stream.value(response));

      final result = await repository.unfollow(targetUserId: 20);

      expect(result.isRight(), true);
    });

    test('ValidationError 時に ValidationFailure を返す', () async {
      final validationError =
          GUnfollowData_unfollow__asValidationError(
        (b) => b
          ..message = 'Not following'
          ..code = 'NOT_FOLLOWING',
      );
      final responseData = GUnfollowData(
        (b) => b..unfollow = validationError,
      );
      final response =
          OperationResponse<GUnfollowData, GUnfollowVars>(
        operationRequest: GUnfollowReq(
          (b) => b
            ..vars.targetUserId = 20
            ..fetchPolicy = FetchPolicy.NetworkOnly,
        ),
        data: responseData,
      );

      when(() => mockClient.request(any<GUnfollowReq>()))
          .thenAnswer((_) => Stream.value(response));

      final result = await repository.unfollow(targetUserId: 20);

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ValidationFailure>()),
        (_) => fail('Expected Left'),
      );
    });

    test('SocketException 時に NetworkFailure を返す', () async {
      when(() => mockClient.request(any<GUnfollowReq>()))
          .thenThrow(const SocketException('No internet'));

      final result = await repository.unfollow(targetUserId: 20);

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<NetworkFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  group('getPendingRequests', () {
    test('成功時に FollowRequestModel のリストを返す', () async {
      final now = DateTime(2024, 1, 1);
      final item = GPendingFollowRequestsData_pendingFollowRequests(
        (b) => b
          ..id = 1
          ..senderId = 10
          ..receiverId = 20
          ..status = GFollowRequestStatus.PENDING
          ..createdAt = now,
      );
      final responseData = GPendingFollowRequestsData(
        (b) => b..pendingFollowRequests.add(item),
      );
      final response = OperationResponse<GPendingFollowRequestsData,
          GPendingFollowRequestsVars>(
        operationRequest: GPendingFollowRequestsReq(
          (b) => b..vars.limit = 20,
        ),
        data: responseData,
      );

      when(() => mockClient.request(any<GPendingFollowRequestsReq>()))
          .thenAnswer((_) => Stream.value(response));

      final result = await repository.getPendingRequests();

      expect(result.isRight(), true);
      final list = result.getOrElse((_) => throw Exception('Expected Right'));
      expect(list.length, 1);
      expect(list.first.id, 1);
      expect(list.first.sender.id, 10);
      expect(list.first.receiver.id, 20);
      expect(list.first.status, FollowRequestStatus.pending);
    });

    test('null レスポンス時に ServerFailure を返す', () async {
      final response = OperationResponse<GPendingFollowRequestsData,
          GPendingFollowRequestsVars>(
        operationRequest: GPendingFollowRequestsReq(
          (b) => b..vars.limit = 20,
        ),
        data: null,
      );

      when(() => mockClient.request(any<GPendingFollowRequestsReq>()))
          .thenAnswer((_) => Stream.value(response));

      final result = await repository.getPendingRequests();

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  group('getPendingRequestCount', () {
    test('成功時にカウントを返す', () async {
      final responseData = GPendingFollowRequestCountData(
        (b) => b..pendingFollowRequestCount = 5,
      );
      final response = OperationResponse<GPendingFollowRequestCountData,
          GPendingFollowRequestCountVars>(
        operationRequest: GPendingFollowRequestCountReq(),
        data: responseData,
      );

      when(() => mockClient.request(any<GPendingFollowRequestCountReq>()))
          .thenAnswer((_) => Stream.value(response));

      final result = await repository.getPendingRequestCount();

      expect(result.isRight(), true);
      final count = result.getOrElse((_) => throw Exception('Expected Right'));
      expect(count, 5);
    });

    test('null レスポンス時に ServerFailure を返す', () async {
      final response = OperationResponse<GPendingFollowRequestCountData,
          GPendingFollowRequestCountVars>(
        operationRequest: GPendingFollowRequestCountReq(),
        data: null,
      );

      when(() => mockClient.request(any<GPendingFollowRequestCountReq>()))
          .thenAnswer((_) => Stream.value(response));

      final result = await repository.getPendingRequestCount();

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  group('getFollowing', () {
    test('成功時に UserSummary のリストを返す', () async {
      final item = GFollowingData_following(
        (b) => b
          ..id = 1
          ..name = 'User1'
          ..avatarUrl = 'https://example.com/avatar.png'
          ..handle = 'user1',
      );
      final responseData = GFollowingData(
        (b) => b..following.add(item),
      );
      final response =
          OperationResponse<GFollowingData, GFollowingVars>(
        operationRequest: GFollowingReq(
          (b) => b
            ..vars.userId = 10
            ..vars.limit = 20,
        ),
        data: responseData,
      );

      when(() => mockClient.request(any<GFollowingReq>()))
          .thenAnswer((_) => Stream.value(response));

      final result = await repository.getFollowing(userId: 10);

      expect(result.isRight(), true);
      final list = result.getOrElse((_) => throw Exception('Expected Right'));
      expect(list.length, 1);
      expect(list.first.id, 1);
      expect(list.first.name, 'User1');
      expect(list.first.handle, 'user1');
    });

    test('null レスポンス時に ServerFailure を返す', () async {
      final response =
          OperationResponse<GFollowingData, GFollowingVars>(
        operationRequest: GFollowingReq(
          (b) => b
            ..vars.userId = 10
            ..vars.limit = 20,
        ),
        data: null,
      );

      when(() => mockClient.request(any<GFollowingReq>()))
          .thenAnswer((_) => Stream.value(response));

      final result = await repository.getFollowing(userId: 10);

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  group('getFollowers', () {
    test('成功時に UserSummary のリストを返す', () async {
      final item = GFollowersData_followers(
        (b) => b
          ..id = 2
          ..name = 'User2'
          ..avatarUrl = 'https://example.com/avatar2.png'
          ..handle = 'user2',
      );
      final responseData = GFollowersData(
        (b) => b..followers.add(item),
      );
      final response =
          OperationResponse<GFollowersData, GFollowersVars>(
        operationRequest: GFollowersReq(
          (b) => b
            ..vars.userId = 10
            ..vars.limit = 20,
        ),
        data: responseData,
      );

      when(() => mockClient.request(any<GFollowersReq>()))
          .thenAnswer((_) => Stream.value(response));

      final result = await repository.getFollowers(userId: 10);

      expect(result.isRight(), true);
      final list = result.getOrElse((_) => throw Exception('Expected Right'));
      expect(list.length, 1);
      expect(list.first.id, 2);
      expect(list.first.name, 'User2');
      expect(list.first.handle, 'user2');
    });
  });

  group('getFollowCounts', () {
    test('成功時に FollowCounts を返す', () async {
      final countsData = GFollowCountsData_followCounts(
        (b) => b
          ..followingCount = 10
          ..followerCount = 20,
      );
      final responseData = GFollowCountsData(
        (b) => b..followCounts.replace(countsData),
      );
      final response =
          OperationResponse<GFollowCountsData, GFollowCountsVars>(
        operationRequest: GFollowCountsReq(
          (b) => b..vars.userId = 10,
        ),
        data: responseData,
      );

      when(() => mockClient.request(any<GFollowCountsReq>()))
          .thenAnswer((_) => Stream.value(response));

      final result = await repository.getFollowCounts(userId: 10);

      expect(result.isRight(), true);
      final counts =
          result.getOrElse((_) => throw Exception('Expected Right'));
      expect(counts.followingCount, 10);
      expect(counts.followerCount, 20);
    });

    test('null レスポンス時に ServerFailure を返す', () async {
      final response =
          OperationResponse<GFollowCountsData, GFollowCountsVars>(
        operationRequest: GFollowCountsReq(
          (b) => b..vars.userId = 10,
        ),
        data: null,
      );

      when(() => mockClient.request(any<GFollowCountsReq>()))
          .thenAnswer((_) => Stream.value(response));

      final result = await repository.getFollowCounts(userId: 10);

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  group('getUserProfile', () {
    test('成功時に UserProfileModel を返す', () async {
      final userProfileData = GUserProfileData_userProfile(
        (b) => b
          ..user.id = 1
          ..user.name = 'Test User'
          ..user.avatarUrl = 'https://example.com/avatar.png'
          ..user.handle = 'testuser'
          ..user.bio = 'Hello'
          ..user.bookCount = 5
          ..user.instagramHandle = 'test_insta'
          ..followStatus = GFollowStatus.FOLLOWING
          ..followCounts.followingCount = 10
          ..followCounts.followerCount = 20
          ..isOwnProfile = false,
      );
      final responseData = GUserProfileData(
        (b) => b..userProfile.replace(userProfileData),
      );
      final response =
          OperationResponse<GUserProfileData, GUserProfileVars>(
        operationRequest: GUserProfileReq(
          (b) => b..vars.handle = 'testuser',
        ),
        data: responseData,
      );

      when(() => mockClient.request(any<GUserProfileReq>()))
          .thenAnswer((_) => Stream.value(response));

      final result = await repository.getUserProfile(handle: 'testuser');

      expect(result.isRight(), true);
      final profile =
          result.getOrElse((_) => throw Exception('Expected Right'));
      expect(profile.user.id, 1);
      expect(profile.user.name, 'Test User');
      expect(profile.user.handle, 'testuser');
      expect(profile.followStatus, FollowStatusType.following);
      expect(profile.followCounts.followingCount, 10);
      expect(profile.followCounts.followerCount, 20);
      expect(profile.isOwnProfile, false);
      expect(profile.bio, 'Hello');
      expect(profile.instagramHandle, 'test_insta');
      expect(profile.bookCount, 5);
    });

    test('userProfile が null の場合 NotFoundFailure を返す', () async {
      final responseData = GUserProfileData(
        (b) => b..userProfile = null,
      );
      final response =
          OperationResponse<GUserProfileData, GUserProfileVars>(
        operationRequest: GUserProfileReq(
          (b) => b..vars.handle = 'unknown',
        ),
        data: responseData,
      );

      when(() => mockClient.request(any<GUserProfileReq>()))
          .thenAnswer((_) => Stream.value(response));

      final result = await repository.getUserProfile(handle: 'unknown');

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<NotFoundFailure>()),
        (_) => fail('Expected Left'),
      );
    });

    test('GFollowStatus のマッピングが正しい', () async {
      for (final entry in {
        GFollowStatus.NONE: FollowStatusType.none,
        GFollowStatus.PENDING_SENT: FollowStatusType.pendingSent,
        GFollowStatus.PENDING_RECEIVED: FollowStatusType.pendingReceived,
        GFollowStatus.FOLLOWING: FollowStatusType.following,
      }.entries) {
        final userProfileData = GUserProfileData_userProfile(
          (b) => b
            ..user.id = 1
            ..user.name = 'Test'
            ..user.avatarUrl = null
            ..user.handle = 'test'
            ..user.bio = null
            ..user.bookCount = 0
            ..user.instagramHandle = null
            ..followStatus = entry.key
            ..followCounts.followingCount = 0
            ..followCounts.followerCount = 0
            ..isOwnProfile = false,
        );
        final responseData = GUserProfileData(
          (b) => b..userProfile.replace(userProfileData),
        );
        final response =
            OperationResponse<GUserProfileData, GUserProfileVars>(
          operationRequest: GUserProfileReq(
            (b) => b..vars.handle = 'test',
          ),
          data: responseData,
        );

        when(() => mockClient.request(any<GUserProfileReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.getUserProfile(handle: 'test');

        expect(result.isRight(), true);
        final profile =
            result.getOrElse((_) => throw Exception('Expected Right'));
        expect(
          profile.followStatus,
          entry.value,
          reason: '${entry.key} should map to ${entry.value}',
        );
      }
    });

    test('SocketException 時に NetworkFailure を返す', () async {
      when(() => mockClient.request(any<GUserProfileReq>()))
          .thenThrow(const SocketException('No internet'));

      final result = await repository.getUserProfile(handle: 'test');

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<NetworkFailure>()),
        (_) => fail('Expected Left'),
      );
    });

    test('TimeoutException 時に NetworkFailure を返す', () async {
      when(() => mockClient.request(any<GUserProfileReq>()))
          .thenThrow(TimeoutException('Timeout'));

      final result = await repository.getUserProfile(handle: 'test');

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<NetworkFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });
}
