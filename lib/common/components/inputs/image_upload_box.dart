import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';

class ImageUploadBox extends StatefulWidget {
  final String? imageUrl;
  final Function(String?) onImageSelected;
  final String placeholderText;
  final double height;
  final double aspectRatioX;
  final double aspectRatioY;
  final bool lockAspectRatio;
  final bool isCircle;

  const ImageUploadBox({
    super.key,
    this.imageUrl,
    required this.onImageSelected,
    this.placeholderText = '갤러리에서 사진 선택',
    this.height = 200,
    this.aspectRatioX = 1.0,
    this.aspectRatioY = 1.0,
    this.lockAspectRatio = true,
    this.isCircle = false,
  });

  @override
  State<ImageUploadBox> createState() => _ImageUploadBoxState();
}

class _ImageUploadBoxState extends State<ImageUploadBox> {
  final ImagePicker _picker = ImagePicker();
  String? _localImagePath;

  @override
  void initState() {
    super.initState();
    _localImagePath = widget.imageUrl;
  }

  @override
  void didUpdateWidget(ImageUploadBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imageUrl != oldWidget.imageUrl) {
      setState(() {
        _localImagePath = widget.imageUrl;
      });
    }
  }

  Future<void> _pickAndCropImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );

      if (image != null) {
        final imageBytes = await image.readAsBytes();

        if (mounted) {
          final croppedBytes = await Navigator.push<Uint8List>(
            context,
            MaterialPageRoute(
              builder: (context) => _ImageCropScreen(
                imageBytes: imageBytes,
                aspectRatioX: widget.aspectRatioX,
                aspectRatioY: widget.aspectRatioY,
                lockAspectRatio: widget.lockAspectRatio,
                isCircle: widget.isCircle,
              ),
            ),
          );

          if (mounted && croppedBytes != null) {
            final tempDir = Directory.systemTemp;
            final tempFile = File(
              '${tempDir.path}/cropped_image_${DateTime.now().millisecondsSinceEpoch}.jpg',
            );
            await tempFile.writeAsBytes(croppedBytes);

            setState(() {
              _localImagePath = tempFile.path;
            });
            widget.onImageSelected(tempFile.path);
          }
        }
      }
    } catch (e) {
      debugPrint('이미지 선택/크롭 오류: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickAndCropImage,
      child: Container(
        height: widget.height,
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: _localImagePath == null || _localImagePath!.isEmpty
              ? Border.all(color: AppColors.border)
              : null,
          borderRadius: AppRadius.lgAll,
        ),
        child: _localImagePath == null || _localImagePath!.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.image_outlined,
                      size: 48,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(height: AppSpacing.sm),
                    Text(
                      widget.placeholderText,
                      style: AppTextStyles.txtSm.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              )
            : widget.isCircle
            ? ClipOval(child: _buildImage(_localImagePath!))
            : ClipRRect(
                borderRadius: AppRadius.lgAll,
                child: _buildImage(_localImagePath!),
              ),
      ),
    );
  }

  Widget _buildImage(String path) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => const Center(
          child: Icon(
            Icons.broken_image_outlined,
            size: 48,
            color: AppColors.textSecondary,
          ),
        ),
      );
    } else {
      return Image.file(
        File(path),
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => const Center(
          child: Icon(
            Icons.broken_image_outlined,
            size: 48,
            color: AppColors.textSecondary,
          ),
        ),
      );
    }
  }
}

class _ImageCropScreen extends StatefulWidget {
  final Uint8List imageBytes;
  final double aspectRatioX;
  final double aspectRatioY;
  final bool lockAspectRatio;
  final bool isCircle;

  const _ImageCropScreen({
    required this.imageBytes,
    required this.aspectRatioX,
    required this.aspectRatioY,
    required this.lockAspectRatio,
    this.isCircle = false,
  });

  @override
  State<_ImageCropScreen> createState() => _ImageCropScreenState();
}

class _ImageCropScreenState extends State<_ImageCropScreen> {
  final _cropController = CropController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: AppSpacing.lg,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '이미지 편집',
          style: AppTextStyles.titMdBold.copyWith(color: AppColors.textPrimary),
        ),
        actions: [
          TextButton(
            onPressed: _cropController.crop,
            child: Text(
              '완료',
              style: AppTextStyles.txtSm.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Crop(
          image: widget.imageBytes,
          controller: _cropController,
          onCropped: (croppedData) {
            if (mounted) {
              final Uint8List imageBytes =
                  (croppedData as dynamic).croppedImage as Uint8List;
              Navigator.pop(context, imageBytes);
            }
          },
          aspectRatio: widget.lockAspectRatio
              ? widget.aspectRatioX / widget.aspectRatioY
              : null,
          baseColor: Colors.black,
          maskColor: Colors.black.withValues(alpha: 0.8),
          radius: 0,
          withCircleUi: widget.isCircle,
          cornerDotBuilder: (size, edgeAlignment) =>
              DotControl(color: AppColors.primary, padding: 8),
        ),
      ),
    );
  }
}
