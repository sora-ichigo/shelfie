import 'dart:async';
import 'dart:io';

import 'package:ferry/ferry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';
import 'package:shelfie/core/network/ferry_client.dart';
import 'package:shelfie/features/follow/data/__generated__/approve_follow_request.data.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/approve_follow_request.req.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/cancel_follow_request.data.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/cancel_follow_request.req.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/follow_counts.data.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/follow_counts.req.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/followers.data.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/followers.req.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/following.data.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/following.req.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/pending_follow_request_count.data.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/pending_follow_request_count.req.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/pending_follow_requests.data.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/pending_follow_requests.req.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/reject_follow_request.data.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/reject_follow_request.req.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/send_follow_request.data.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/send_follow_request.req.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/unfollow.data.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/unfollow.req.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/user_profile.data.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/user_profile.req.gql.dart';
import 'package:shelfie/features/follow/domain/follow_counts.dart';
import 'package:shelfie/features/follow/domain/follow_request_model.dart';
import 'package:shelfie/features/follow/domain/follow_request_status.dart';
import 'package:shelfie/features/follow/domain/follow_status_type.dart';
import 'package:shelfie/features/follow/domain/user_profile_model.dart';
import 'package:shelfie/features/follow/domain/user_summary.dart';

part 'follow_repository.g.dart';

@riverpod
FollowRepository followRepository(Ref ref) {
  final client = ref.watch(ferryClientProvider);
  return FollowRepository(client: client);
}

class FollowRepository {
  const FollowRepository({required this.client});

  final Client client;

  Future<Either<Failure, FollowRequestModel>> sendFollowRequest({
    required int receiverId,
  }) async {
    final request = GSendFollowRequestReq(
      (b) => b
        ..vars.receiverId = receiverId
        ..fetchPolicy = FetchPolicy.NetworkOnly,
    );

    try {
      final response = await client.request(request).first;
      return _handleSendFollowRequestResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, FollowRequestModel>> approveFollowRequest({
    required int requestId,
  }) async {
    final request = GApproveFollowRequestReq(
      (b) => b
        ..vars.requestId = requestId
        ..fetchPolicy = FetchPolicy.NetworkOnly,
    );

    try {
      final response = await client.request(request).first;
      return _handleApproveFollowRequestResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, FollowRequestModel>> rejectFollowRequest({
    required int requestId,
  }) async {
    final request = GRejectFollowRequestReq(
      (b) => b
        ..vars.requestId = requestId
        ..fetchPolicy = FetchPolicy.NetworkOnly,
    );

    try {
      final response = await client.request(request).first;
      return _handleRejectFollowRequestResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> unfollow({
    required int targetUserId,
  }) async {
    final request = GUnfollowReq(
      (b) => b
        ..vars.targetUserId = targetUserId
        ..fetchPolicy = FetchPolicy.NetworkOnly,
    );

    try {
      final response = await client.request(request).first;
      return _handleUnfollowResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> cancelFollowRequest({
    required int targetUserId,
  }) async {
    final request = GCancelFollowRequestReq(
      (b) => b
        ..vars.targetUserId = targetUserId
        ..fetchPolicy = FetchPolicy.NetworkOnly,
    );

    try {
      final response = await client.request(request).first;
      return _handleCancelFollowRequestResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<FollowRequestModel>>> getPendingRequests({
    int? cursor,
    int limit = 20,
  }) async {
    final request = GPendingFollowRequestsReq(
      (b) => b
        ..vars.cursor = cursor
        ..vars.limit = limit,
    );

    try {
      final response = await client.request(request).first;
      return _handlePendingRequestsResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, int>> getPendingRequestCount() async {
    final request = GPendingFollowRequestCountReq();

    try {
      final response = await client.request(request).first;
      return _handlePendingRequestCountResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<UserSummary>>> getFollowing({
    required int userId,
    int? cursor,
    int limit = 20,
  }) async {
    final request = GFollowingReq(
      (b) => b
        ..vars.userId = userId
        ..vars.cursor = cursor
        ..vars.limit = limit
        ..fetchPolicy = FetchPolicy.NetworkOnly,
    );

    try {
      final response = await client.request(request).first;
      return _handleFollowingResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<UserSummary>>> getFollowers({
    required int userId,
    int? cursor,
    int limit = 20,
  }) async {
    final request = GFollowersReq(
      (b) => b
        ..vars.userId = userId
        ..vars.cursor = cursor
        ..vars.limit = limit
        ..fetchPolicy = FetchPolicy.NetworkOnly,
    );

    try {
      final response = await client.request(request).first;
      return _handleFollowersResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, FollowCounts>> getFollowCounts({
    required int userId,
  }) async {
    final request = GFollowCountsReq(
      (b) => b
        ..vars.userId = userId
        ..fetchPolicy = FetchPolicy.NetworkOnly,
    );

    try {
      final response = await client.request(request).first;
      return _handleFollowCountsResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, UserProfileModel>> getUserProfile({
    required String handle,
  }) async {
    final request = GUserProfileReq(
      (b) => b..vars.handle = handle,
    );

    try {
      final response = await client.request(request).first;
      return _handleUserProfileResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  // --- Private response handlers ---

  Either<Failure, FollowRequestModel> _handleSendFollowRequestResponse(
    OperationResponse<GSendFollowRequestData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final error = response.graphqlErrors?.firstOrNull;
      return left(ServerFailure(
        message: error?.message ?? 'Failed to send follow request',
        code: 'GRAPHQL_ERROR',
      ));
    }

    final data = response.data;
    if (data == null) {
      return left(const ServerFailure(
        message: 'No data received',
        code: 'NO_DATA',
      ));
    }

    final result = data.sendFollowRequest;

    if (result
        is GSendFollowRequestData_sendFollowRequest__asValidationError) {
      return left(ValidationFailure(
        message: result.message ?? 'バリデーションエラーが発生しました',
      ));
    }

    if (result
        is GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess) {
      return right(_mapFollowRequest(
        id: result.data.id ?? 0,
        senderId: result.data.senderId ?? 0,
        receiverId: result.data.receiverId ?? 0,
        status: result.data.status ?? GFollowRequestStatus.PENDING,
        createdAt: result.data.createdAt ?? DateTime.now(),
      ));
    }

    return left(const ServerFailure(
      message: 'Unexpected response type',
      code: 'UNEXPECTED_TYPE',
    ));
  }

  Either<Failure, FollowRequestModel> _handleApproveFollowRequestResponse(
    OperationResponse<GApproveFollowRequestData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final error = response.graphqlErrors?.firstOrNull;
      return left(ServerFailure(
        message: error?.message ?? 'Failed to approve follow request',
        code: 'GRAPHQL_ERROR',
      ));
    }

    final data = response.data;
    if (data == null) {
      return left(const ServerFailure(
        message: 'No data received',
        code: 'NO_DATA',
      ));
    }

    final result = data.approveFollowRequest;

    if (result
        is GApproveFollowRequestData_approveFollowRequest__asValidationError) {
      return left(ValidationFailure(
        message: result.message ?? 'バリデーションエラーが発生しました',
      ));
    }

    if (result
        is GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess) {
      return right(_mapFollowRequest(
        id: result.data.id ?? 0,
        senderId: result.data.senderId ?? 0,
        receiverId: result.data.receiverId ?? 0,
        status: result.data.status ?? GFollowRequestStatus.PENDING,
        createdAt: result.data.createdAt ?? DateTime.now(),
      ));
    }

    return left(const ServerFailure(
      message: 'Unexpected response type',
      code: 'UNEXPECTED_TYPE',
    ));
  }

  Either<Failure, FollowRequestModel> _handleRejectFollowRequestResponse(
    OperationResponse<GRejectFollowRequestData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final error = response.graphqlErrors?.firstOrNull;
      return left(ServerFailure(
        message: error?.message ?? 'Failed to reject follow request',
        code: 'GRAPHQL_ERROR',
      ));
    }

    final data = response.data;
    if (data == null) {
      return left(const ServerFailure(
        message: 'No data received',
        code: 'NO_DATA',
      ));
    }

    final result = data.rejectFollowRequest;

    if (result
        is GRejectFollowRequestData_rejectFollowRequest__asValidationError) {
      return left(ValidationFailure(
        message: result.message ?? 'バリデーションエラーが発生しました',
      ));
    }

    if (result
        is GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess) {
      return right(_mapFollowRequest(
        id: result.data.id ?? 0,
        senderId: result.data.senderId ?? 0,
        receiverId: result.data.receiverId ?? 0,
        status: result.data.status ?? GFollowRequestStatus.PENDING,
        createdAt: result.data.createdAt ?? DateTime.now(),
      ));
    }

    return left(const ServerFailure(
      message: 'Unexpected response type',
      code: 'UNEXPECTED_TYPE',
    ));
  }

  Either<Failure, void> _handleUnfollowResponse(
    OperationResponse<GUnfollowData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final error = response.graphqlErrors?.firstOrNull;
      return left(ServerFailure(
        message: error?.message ?? 'Failed to unfollow',
        code: 'GRAPHQL_ERROR',
      ));
    }

    final data = response.data;
    if (data == null) {
      return left(const ServerFailure(
        message: 'No data received',
        code: 'NO_DATA',
      ));
    }

    final result = data.unfollow;

    if (result is GUnfollowData_unfollow__asValidationError) {
      return left(ValidationFailure(
        message: result.message ?? 'バリデーションエラーが発生しました',
      ));
    }

    if (result is GUnfollowData_unfollow__asMutationUnfollowSuccess) {
      return right(null);
    }

    return left(const ServerFailure(
      message: 'Unexpected response type',
      code: 'UNEXPECTED_TYPE',
    ));
  }

  Either<Failure, void> _handleCancelFollowRequestResponse(
    OperationResponse<GCancelFollowRequestData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final error = response.graphqlErrors?.firstOrNull;
      return left(ServerFailure(
        message: error?.message ?? 'Failed to cancel follow request',
        code: 'GRAPHQL_ERROR',
      ));
    }

    final data = response.data;
    if (data == null) {
      return left(const ServerFailure(
        message: 'No data received',
        code: 'NO_DATA',
      ));
    }

    final result = data.cancelFollowRequest;

    if (result
        is GCancelFollowRequestData_cancelFollowRequest__asValidationError) {
      return left(ValidationFailure(
        message: result.message ?? 'バリデーションエラーが発生しました',
      ));
    }

    if (result
        is GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess) {
      return right(null);
    }

    return left(const ServerFailure(
      message: 'Unexpected response type',
      code: 'UNEXPECTED_TYPE',
    ));
  }

  Either<Failure, List<FollowRequestModel>> _handlePendingRequestsResponse(
    OperationResponse<GPendingFollowRequestsData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final error = response.graphqlErrors?.firstOrNull;
      return left(ServerFailure(
        message: error?.message ?? 'Failed to get pending requests',
        code: 'GRAPHQL_ERROR',
      ));
    }

    final data = response.data;
    if (data == null) {
      return left(const ServerFailure(
        message: 'No data received',
        code: 'NO_DATA',
      ));
    }

    final requests = data.pendingFollowRequests?.map((item) {
      return _mapFollowRequest(
        id: item.id ?? 0,
        senderId: item.senderId ?? 0,
        receiverId: item.receiverId ?? 0,
        status: item.status ?? GFollowRequestStatus.PENDING,
        createdAt: item.createdAt ?? DateTime.now(),
      );
    }).toList() ?? [];

    return right(requests);
  }

  Either<Failure, int> _handlePendingRequestCountResponse(
    OperationResponse<GPendingFollowRequestCountData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final error = response.graphqlErrors?.firstOrNull;
      return left(ServerFailure(
        message: error?.message ?? 'Failed to get pending request count',
        code: 'GRAPHQL_ERROR',
      ));
    }

    final data = response.data;
    if (data == null) {
      return left(const ServerFailure(
        message: 'No data received',
        code: 'NO_DATA',
      ));
    }

    return right(data.pendingFollowRequestCount ?? 0);
  }

  Either<Failure, List<UserSummary>> _handleFollowingResponse(
    OperationResponse<GFollowingData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final error = response.graphqlErrors?.firstOrNull;
      return left(ServerFailure(
        message: error?.message ?? 'Failed to get following',
        code: 'GRAPHQL_ERROR',
      ));
    }

    final data = response.data;
    if (data == null) {
      return left(const ServerFailure(
        message: 'No data received',
        code: 'NO_DATA',
      ));
    }

    final users = data.following?.map((item) {
      return UserSummary(
        id: item.id ?? 0,
        name: item.name,
        avatarUrl: item.avatarUrl,
        handle: item.handle,
      );
    }).toList() ?? [];

    return right(users);
  }

  Either<Failure, List<UserSummary>> _handleFollowersResponse(
    OperationResponse<GFollowersData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final error = response.graphqlErrors?.firstOrNull;
      return left(ServerFailure(
        message: error?.message ?? 'Failed to get followers',
        code: 'GRAPHQL_ERROR',
      ));
    }

    final data = response.data;
    if (data == null) {
      return left(const ServerFailure(
        message: 'No data received',
        code: 'NO_DATA',
      ));
    }

    final users = data.followers?.map((item) {
      return UserSummary(
        id: item.id ?? 0,
        name: item.name,
        avatarUrl: item.avatarUrl,
        handle: item.handle,
      );
    }).toList() ?? [];

    return right(users);
  }

  Either<Failure, FollowCounts> _handleFollowCountsResponse(
    OperationResponse<GFollowCountsData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final error = response.graphqlErrors?.firstOrNull;
      return left(ServerFailure(
        message: error?.message ?? 'Failed to get follow counts',
        code: 'GRAPHQL_ERROR',
      ));
    }

    final data = response.data;
    if (data == null) {
      return left(const ServerFailure(
        message: 'No data received',
        code: 'NO_DATA',
      ));
    }

    return right(FollowCounts(
      followingCount: data.followCounts?.followingCount ?? 0,
      followerCount: data.followCounts?.followerCount ?? 0,
    ));
  }

  Either<Failure, UserProfileModel> _handleUserProfileResponse(
    OperationResponse<GUserProfileData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final error = response.graphqlErrors?.firstOrNull;
      return left(ServerFailure(
        message: error?.message ?? 'Failed to get user profile',
        code: 'GRAPHQL_ERROR',
      ));
    }

    final data = response.data;
    if (data == null) {
      return left(const ServerFailure(
        message: 'No data received',
        code: 'NO_DATA',
      ));
    }

    final profile = data.userProfile;
    if (profile == null) {
      return left(const NotFoundFailure(
        message: 'User profile not found',
      ));
    }

    return right(UserProfileModel(
      user: UserSummary(
        id: profile.user?.id ?? 0,
        name: profile.user?.name,
        avatarUrl: profile.user?.avatarUrl,
        handle: profile.user?.handle,
      ),
      outgoingFollowStatus: _mapFollowStatus(profile.outgoingFollowStatus),
      incomingFollowStatus: _mapFollowStatus(profile.incomingFollowStatus),
      followCounts: FollowCounts(
        followingCount: profile.followCounts?.followingCount ?? 0,
        followerCount: profile.followCounts?.followerCount ?? 0,
      ),
      isOwnProfile: profile.isOwnProfile ?? false,
      bio: profile.user?.bio,
      instagramHandle: profile.user?.instagramHandle,
      shareUrl: profile.user?.shareUrl,
      bookCount: profile.user?.bookCount,
    ));
  }

  // --- Mapping helpers ---

  FollowRequestModel _mapFollowRequest({
    required int id,
    required int senderId,
    required int receiverId,
    required GFollowRequestStatus status,
    required DateTime createdAt,
  }) {
    return FollowRequestModel(
      id: id,
      sender: UserSummary(
        id: senderId,
        name: null,
        avatarUrl: null,
        handle: null,
      ),
      receiver: UserSummary(
        id: receiverId,
        name: null,
        avatarUrl: null,
        handle: null,
      ),
      status: _mapFollowRequestStatus(status),
      createdAt: createdAt,
    );
  }

  FollowRequestStatus _mapFollowRequestStatus(GFollowRequestStatus status) {
    return switch (status) {
      GFollowRequestStatus.PENDING => FollowRequestStatus.pending,
      GFollowRequestStatus.APPROVED => FollowRequestStatus.approved,
      GFollowRequestStatus.REJECTED => FollowRequestStatus.rejected,
      _ => FollowRequestStatus.pending,
    };
  }

  FollowStatusType _mapFollowStatus(GFollowStatus? status) {
    if (status == null) return FollowStatusType.none;
    return switch (status) {
      GFollowStatus.NONE => FollowStatusType.none,
      GFollowStatus.PENDING_SENT => FollowStatusType.pendingSent,
      GFollowStatus.PENDING_RECEIVED => FollowStatusType.pendingReceived,
      GFollowStatus.FOLLOWING => FollowStatusType.following,
      GFollowStatus.FOLLOWED_BY => FollowStatusType.followedBy,
      _ => FollowStatusType.none,
    };
  }
}
