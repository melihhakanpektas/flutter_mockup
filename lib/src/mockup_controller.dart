import 'dart:math';

import 'package:flutter/material.dart';

class MockupController with ChangeNotifier {
  String _tshirtImage;
  String _logoImage;
  Offset _logoPosition = Offset.zero;
  double _logoScale = 1.0;
  double _logoRotation = 0.0;
  double _tshirtScale = 1.0;
  Offset _tshirtImageSize = Offset.zero;
  Offset _logoImageSize = Offset.zero;
  Offset _tshirtGlobalPosition = Offset.zero;
  int _mouseMode = 0;

  MockupController({
    required String tshirtImage,
    required String logoImage,
  })  : _tshirtImage = tshirtImage,
        _logoImage = logoImage;

  String get tshirtImage => _tshirtImage;
  String get logoImage => _logoImage;
  Offset get logoPosition => _logoPosition;
  double get logoScale => _logoScale;
  double get logoRotation => _logoRotation;
  double get tshirtScale => _tshirtScale;
  Offset get tshirtImageSize => _tshirtImageSize;
  Offset get logoImageSize => _logoImageSize;
  Offset get tshirtGlobalPosition => _tshirtGlobalPosition;
  int get mouseMode => _mouseMode;

  Offset get logoGlobalPosition => Offset(
        tshirtGlobalPosition.dx + logoPosition.dx,
        tshirtGlobalPosition.dy + logoPosition.dy,
      );

  Offset get logoWidgetSize => Offset(
        logoImageSize.dx * tshirtScale * logoScale,
        logoImageSize.dy * tshirtScale * logoScale,
      );

  set tshirtImage(String value) {
    _tshirtImage = value;
    notifyListeners();
  }

  set logoImage(String value) {
    _logoImage = value;
    notifyListeners();
  }

  set logoPosition(Offset value) {
    _logoPosition = value;
    notifyListeners();
  }

  set logoScale(double value) {
    _logoScale = value;
    notifyListeners();
  }

  set logoRotation(double value) {
    _logoRotation = value;
    notifyListeners();
  }

  set tshirtScale(double value) {
    _tshirtScale = value;
    notifyListeners();
  }

  set tshirtImageSize(Offset value) {
    _tshirtImageSize = value;
    notifyListeners();
  }

  set logoImageSize(Offset value) {
    _logoImageSize = value;
    notifyListeners();
  }

  set tshirtGlobalPosition(Offset value) {
    _tshirtGlobalPosition = value;
    notifyListeners();
  }

  set mouseMode(int value) {
    _mouseMode = value;
  }

  Size _calculateNewImageSize(Size imageSize, Size screenSize) {
    final imageAspectRatio = imageSize.width / imageSize.height;
    final screenAspectRatio = screenSize.width / screenSize.height;

    if (imageAspectRatio > screenAspectRatio) {
      final newWidth = screenSize.width;
      final newHeight = newWidth / imageAspectRatio;
      return Size(newWidth, newHeight);
    } else {
      final newHeight = screenSize.height;
      final newWidth = newHeight * imageAspectRatio;
      return Size(newWidth, newHeight);
    }
  }

  void constraintsUpdate(Size constraints) {
    // Get the size of the tshirt image
    final tshirtWidgetSize =
        _calculateNewImageSize(Size(tshirtImageSize.dx, tshirtImageSize.dy), constraints);
    final tshirtGlobalPosition = Offset(
      (constraints.width - tshirtWidgetSize.width) / 2,
      (constraints.height - tshirtWidgetSize.height) / 2,
    );
    // Calculate the scale of the tshirt image
    final tshirtCurrentScale = min(
        tshirtWidgetSize.width / tshirtImageSize.dx, tshirtWidgetSize.height / tshirtImageSize.dy);
    _logoPosition = Offset(
      logoPosition.dx * tshirtCurrentScale / tshirtScale,
      logoPosition.dy * tshirtCurrentScale / tshirtScale,
    );
    _tshirtScale = tshirtCurrentScale;
    _tshirtGlobalPosition = tshirtGlobalPosition;
    _logoImageSize = logoImageSize;
    notifyListeners();
  }

  void resizeLogo(double newScale, Offset newOffset) {
    _logoScale = newScale;
    _logoPosition = newOffset;
    notifyListeners();
  }

  void resizeAndRotateLogo(double newScale, Offset newOffset, double newRotation) {
    _logoScale = newScale;
    _logoPosition = newOffset;
    _logoRotation = newRotation;
    notifyListeners();
  }

  void reset() {
    _logoPosition = Offset.zero;
    _logoScale = 1.0;
    _logoRotation = 0.0;
    _tshirtScale = 1.0;
    _tshirtImageSize = Offset.zero;
    _logoImageSize = Offset.zero;
    _tshirtGlobalPosition = Offset.zero;
    notifyListeners();
  }
}
