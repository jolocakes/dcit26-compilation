import 'package:material_ui/material_ui.dart';

/// A circular network image with a loading indicator and an error fallback.
///
/// If [url] is null/empty or the image fails to load, a person icon is shown.
class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    this.url,
    this.size = 120,
  });

  final String? url;
  final double size;

  @override
  Widget build(BuildContext context) {
    final radius = size / 2;
    if (url == null || url!.isEmpty) {
      return _fallback(radius);
    }
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: Image.network(
          url!,
          fit: BoxFit.cover,
          width: size,
          height: size,
          // randomuser.me portraits don't send CORS headers, so the default
          // XHR-based loader fails on Flutter web. Fall back to an HTML <img>
          // element there; native platforms are unaffected.
          webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return SizedBox(
              width: size,
              height: size,
              child: Center(
                child: CircularProgressIndicator(
                  value: progress.expectedTotalBytes != null
                      ? progress.cumulativeBytesLoaded /
                          progress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => _fallback(radius),
        ),
      ),
    );
  }

  Widget _fallback(double radius) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey.shade300,
      child: Icon(
        Icons.person,
        size: radius,
        color: Colors.grey.shade600,
      ),
    );
  }
}
