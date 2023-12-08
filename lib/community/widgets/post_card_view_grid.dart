import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:thunder/core/models/post_view_media.dart';
import 'package:thunder/core/theme/theme.dart';
import 'package:thunder/shared/media_view.dart';
import 'package:thunder/shared/text/scalable_text.dart';
import 'package:thunder/thunder/thunder.dart';
import 'package:thunder/core/enums/font_scale.dart';

class PostCardViewGrid extends StatelessWidget {
  const PostCardViewGrid({
    super.key,
    required this.postViewMedia,
    this.navigateToPost,
    required this.indicateRead,
    required this.showFullHeightImages,
    required this.hideNsfwPreviews,
    required this.edgeToEdgeImages,
    required this.isUserLoggedIn,
    required this.markPostReadOnMediaView,
  });
  final PostViewMedia postViewMedia;
  final void Function({PostViewMedia? postViewMedia})? navigateToPost;
  final bool indicateRead;
  final bool showFullHeightImages;
  final bool hideNsfwPreviews;
  final bool edgeToEdgeImages;
  final bool isUserLoggedIn;
  final bool markPostReadOnMediaView;
  @override
  Widget build(BuildContext context) {
    final ThunderState state = context.read<ThunderBloc>().state;
    final theme = Theme.of(context);

    final bool darkTheme = context.read<ThemeBloc>().state.useDarkTheme;

    return Container(
      child: (postViewMedia.media.isEmpty)
          ? Container(
              color: indicateRead && postViewMedia.postView.read ? theme.colorScheme.onBackground.withOpacity(darkTheme ? 0.05 : 0.075) : null,
              padding: const EdgeInsets.only(
                bottom: 8.0,
                top: 6,
              ),
              child: ScalableText(
                HtmlUnescape().convert(postViewMedia.postView.post.name),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: MediaQuery.textScalerOf(context).scale(theme.textTheme.bodyMedium!.fontSize! * state.titleFontSizeScale.textScaleFactor),
                  color: postViewMedia.postView.post.featuredCommunity
                      ? (indicateRead && postViewMedia.postView.read ? Colors.green.withOpacity(0.55) : Colors.green)
                      : (indicateRead && postViewMedia.postView.read ? theme.textTheme.bodyMedium?.color?.withOpacity(0.55) : null),
                ),
              ))
          : MediaView(
              scrapeMissingPreviews: state.scrapeMissingPreviews,
              postView: postViewMedia,
              showFullHeightImages: showFullHeightImages,
              hideNsfwPreviews: hideNsfwPreviews,
              edgeToEdgeImages: edgeToEdgeImages,
              markPostReadOnMediaView: markPostReadOnMediaView,
              isUserLoggedIn: isUserLoggedIn,
              navigateToPost: navigateToPost,
              read: indicateRead && postViewMedia.postView.read,
            ),
    );
  }
}
