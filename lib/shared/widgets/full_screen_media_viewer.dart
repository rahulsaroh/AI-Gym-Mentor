import 'package:flutter/material.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/widgets/exercise_media_widget.dart';

class FullScreenMediaViewer extends StatelessWidget {
  final String? animatedUrl;
  final String? staticUrl;
  final String title;

  const FullScreenMediaViewer({
    super.key,
    this.animatedUrl,
    this.staticUrl,
    this.title = 'Exercise Media',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Colors.white, // Most exercise GIFs have white backgrounds, blend them
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: InteractiveViewer(
            clipBehavior: Clip.none,
            minScale: 0.5,
            maxScale: 4.0,
            child: ExerciseMediaWidget(
              animatedUrl: animatedUrl,
              staticUrl: staticUrl,
              fit: BoxFit.contain,
              showDecoration: false,
              height: double.infinity,
            ),
          ),
        ),
      ),
    );
  }

  /// Helper method to show the viewer
  static void show(
    BuildContext context, {
    String? animatedUrl,
    String? staticUrl,
    String? title,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => FullScreenMediaViewer(
          animatedUrl: animatedUrl,
          staticUrl: staticUrl,
          title: title ?? 'Exercise Media',
        ),
      ),
    );
  }
}
