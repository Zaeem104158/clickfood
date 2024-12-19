enum ImageType {
  jsonImageType,
  pngImageType,
  svgImageType,
}

extension ImageTypeExtension on ImageType {
  String get typePath {
    switch (this) {
      case ImageType.jsonImageType:
        return 'assets/images/json_images/';
      case ImageType.pngImageType:
        return 'assets/images/';
      case ImageType.svgImageType:
        return 'assets/images/svg_images/';
    }
  }
}

class ImagePath {
  static String jsonImage = ImageType.jsonImageType.typePath;
  static String pngImage = ImageType.pngImageType.typePath;
  static String svgImage = ImageType.svgImageType.typePath;
  static String loginPageWelcomeImage = "${pngImage}loginWelcome.png";
  static String arrowBack = "${pngImage}arrow-left.png";
  static String googleIcon = "${pngImage}devicon_google.png";
  static String appleIcon = "${pngImage}mdi_apple.png";
  static String otpImage = "${pngImage}otp.png";
}
