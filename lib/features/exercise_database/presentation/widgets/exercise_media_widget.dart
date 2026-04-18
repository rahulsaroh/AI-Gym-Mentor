import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ai_gym_mentor/shared/widgets/full_screen_media_viewer.dart';

class ExerciseMediaWidget extends StatefulWidget {
  final String? animatedUrl; // e.g., GIF URL
  final String? staticUrl; // e.g., Thumbnail/Poster
  final String? videoUrl; // e.g., YouTube Link
  final double? height;
  final BoxFit fit;
  final bool showDecoration;
  final double borderRadius;
  final bool isTappable;
  final String? exerciseName;

  const ExerciseMediaWidget({
    super.key,
    this.animatedUrl,
    this.staticUrl,
    this.videoUrl,
    this.height = 250,
    this.fit = BoxFit.cover,
    this.showDecoration = true,
    this.borderRadius = 16,
    this.isTappable = false,
    this.exerciseName,
  });

  @override
  State<ExerciseMediaWidget> createState() => _ExerciseMediaWidgetState();
}

class _ExerciseMediaWidgetState extends State<ExerciseMediaWidget> {
  @override
  Widget build(BuildContext context) {
    if (!widget.showDecoration) {
      return _buildTappableWrapper(_buildStack());
    }

    return _buildTappableWrapper(
      Container(
        height: widget.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        clipBehavior: Clip.antiAlias,
        child: _buildStack(),
      ),
    );
  }

  Widget _buildTappableWrapper(Widget child) {
    if (!widget.isTappable) return child;

    return GestureDetector(
      onTap: () => FullScreenMediaViewer.show(
        context,
        animatedUrl: widget.animatedUrl,
        staticUrl: widget.staticUrl,
        title: widget.exerciseName,
      ),
      child: child,
    );
  }

  Widget _buildStack() {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildMedia(),
        if (widget.videoUrl != null)
          Positioned(
            right: 8,
            bottom: 8,
            child: FloatingActionButton.small(
              onPressed: () => _launchVideo(widget.videoUrl!),
              backgroundColor: Colors.red.withValues(alpha: 0.8),
              child: const Icon(Icons.play_arrow, color: Colors.white),
            ),
          ),
      ],
    );
  }

  Widget _buildMedia() {
    // Priority: animatedUrl -> staticUrl -> Placeholder
    if (widget.animatedUrl != null && widget.animatedUrl!.isNotEmpty) {
      return _buildGifWithErrorHandling();
    } else if (widget.staticUrl != null && widget.staticUrl!.isNotEmpty) {
      return _buildStaticImage();
    } else {
      return _buildErrorPlaceholder();
    }
  }

  Widget _buildGifWithErrorHandling() {
    return Image.network(
      widget.animatedUrl!,
      fit: widget.fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _buildPlaceholder();
      },
      errorBuilder: (context, error, stackTrace) {
        return _buildErrorPlaceholder();
      },
    );
  }

  Widget _buildStaticImage() {
    return CachedNetworkImage(
      imageUrl: widget.staticUrl!,
      fit: widget.fit,
      placeholder: (context, url) => _buildPlaceholder(),
      errorWidget: (context, url, error) => _buildErrorPlaceholder(),
    );
  }

  Widget _buildPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[700]!,
      child: Container(
        color: Colors.grey[800],
        height: widget.height,
        width: double.infinity,
      ),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      color: Colors.grey[800],
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_not_supported, color: Colors.grey, size: 48),
          SizedBox(height: 8),
          Text(
            'Media unavailable',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Future<void> _launchVideo(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  static final _customCacheManager = CacheManager(
    Config(
      'exercise_media_cache',
      stalePeriod: const Duration(days: 30),
      maxNrOfCacheObjects: 200,
    ),
  );
}
