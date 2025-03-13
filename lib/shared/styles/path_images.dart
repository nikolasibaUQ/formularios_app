/// The class "Paths" contains static variables for accessing image and icon paths.
class Paths {
  Paths._();

  static final images = PathsImages();
  static final icons = PathsIcons();
}

/// The class PathsImages provides the paths for different images used in the application.
class PathsImages {
  PathsImages();

  final form = 'lib/shared/assets/images/form_img.png';
  final error = 'lib/shared/assets/icons/error_icon.png';
  final success = 'lib/shared/assets/icons/succes.png';
}

/// The class PathsIcons provides the paths for different icons used in the application
class PathsIcons {
  PathsIcons();

  // final worldPideky = 'lib/shared/assets/icons/mundo_pideky.png';
}
