import 'package:flutter/material.dart';

import 'package:lemmy_api_client/v3.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thunder/community/widgets/post_actions_card.dart';

import 'package:thunder/community/widgets/post_card_view_comfortable.dart';
import 'package:thunder/community/widgets/post_card_view_compact.dart';
import 'package:thunder/community/widgets/post_card_view_grid.dart';
import 'package:thunder/core/auth/bloc/auth_bloc.dart';
import 'package:thunder/core/models/post_view_media.dart';
// renamed to prevent clash with VotePostEvent, etc from community_bloc
import 'package:thunder/thunder/bloc/thunder_bloc.dart';
import 'package:thunder/thunder/enums/feed_card_type_enum.dart';
import 'package:thunder/utils/navigate_post.dart';

class PostCard extends StatelessWidget {
  final PostViewMedia postViewMedia;
  final bool communityMode;
  final bool indicateRead;

  final Function(int) onVoteAction;
  final Function(bool) onSaveAction;
  final Function(bool) onReadAction;

  final ListingType? listingType;

  const PostCard({
    super.key,
    required this.postViewMedia,
    required this.communityMode,
    required this.onVoteAction,
    required this.onSaveAction,
    required this.onReadAction,
    required this.listingType,
    required this.indicateRead,
  });

  @override
  Widget build(BuildContext context) {
    final ThunderState state = context.read<ThunderBloc>().state;
    final FeedCardType feedCardType = state.feedCardType!;

    final bool isUserLoggedIn = context.read<AuthBloc>().state.isLoggedIn;

    switch (feedCardType) {
      case FeedCardType.card:
        return PostActionsCard(
          postViewMedia: postViewMedia,
          communityMode: communityMode,
          onReadAction: onReadAction,
          indicateRead: indicateRead,
          listingType: listingType,
          onVoteAction: onVoteAction,
          onSaveAction: onSaveAction,
          child: PostCardViewCompact(
            postViewMedia: postViewMedia,
            showThumbnailPreviewOnRight: state.showThumbnailPreviewOnRight,
            showTextPostIndicator: state.showTextPostIndicator,
            showPostAuthor: state.showPostAuthor,
            hideNsfwPreviews: state.hideNsfwPreviews,
            markPostReadOnMediaView: state.markPostReadOnMediaView,
            communityMode: communityMode,
            isUserLoggedIn: isUserLoggedIn,
            listingType: listingType,
            navigateToPost: ({PostViewMedia? postViewMedia}) async => await navigateToPost(context, postViewMedia: postViewMedia),
            indicateRead: indicateRead,
          ),
        );

      case FeedCardType.compact:
        return PostActionsCard(
          postViewMedia: postViewMedia,
          communityMode: communityMode,
          onVoteAction: onVoteAction,
          onSaveAction: onSaveAction,
          onReadAction: onReadAction,
          listingType: listingType,
          indicateRead: indicateRead,
          child: PostCardViewComfortable(
            postViewMedia: postViewMedia,
            showThumbnailPreviewOnRight: state.showThumbnailPreviewOnRight,
            hideNsfwPreviews: state.hideNsfwPreviews,
            markPostReadOnMediaView: state.markPostReadOnMediaView,
            communityMode: communityMode,
            showPostAuthor: state.showPostAuthor,
            showFullHeightImages: state.showFullHeightImages,
            edgeToEdgeImages: state.showEdgeToEdgeImages,
            showTitleFirst: state.showTitleFirst,
            showVoteActions: state.showVoteActions,
            showSaveAction: state.showSaveAction,
            showCommunityIcons: state.showCommunityIcons,
            showTextContent: state.showTextContent,
            isUserLoggedIn: isUserLoggedIn,
            onVoteAction: onVoteAction,
            onSaveAction: onSaveAction,
            listingType: listingType,
            navigateToPost: ({PostViewMedia? postViewMedia}) async => await navigateToPost(context, postViewMedia: postViewMedia),
            indicateRead: indicateRead,
          ),
        );
      case FeedCardType.grid:
        return PostCardViewGrid(
          postViewMedia: postViewMedia,
          indicateRead: indicateRead,
          isUserLoggedIn: isUserLoggedIn,
          showFullHeightImages: state.showFullHeightImages,
          edgeToEdgeImages: state.showEdgeToEdgeImages,
          hideNsfwPreviews: state.hideNsfwPreviews,
          markPostReadOnMediaView: state.markPostReadOnMediaView,
          navigateToPost: ({PostViewMedia? postViewMedia}) async => await navigateToPost(context, postViewMedia: postViewMedia),
        );
    }
  }
}
