import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trader_app/core/utils/app_colors.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/sales_process/presentation/widgets/image_picker_widget.dart';
import 'package:trader_app/features/sales_process/presentation/widgets/steps/step_header.dart';

const int _maxImages = 3;

class ImagesStep extends StatelessWidget {
  final List<File> selectedImages;
  final Function(List<File>) onImagesChanged;

  const ImagesStep({
    super.key,
    required this.selectedImages,
    required this.onImagesChanged,
  });

  void _addImage(File? image) {
    if (image == null) return;
    onImagesChanged([...selectedImages, image]);
  }

  void _removeImage(int index) {
    final updated = List<File>.from(selectedImages)..removeAt(index);
    onImagesChanged(updated);
  }

  void _clearImages() => onImagesChanged([]);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StepHeader(
          title: 'صور الشحنة',
          subtitle: 'أضف صور للشحنة للتوثيق',
          icon: Icons.photo_camera_rounded,
          stepNumber: 4,
        ),
        const SizedBox(height: 24),
        _buildImagesCard(context),
      ],
    );
  }

  Widget _buildImagesCard(BuildContext context) {
    final bool canAdd = selectedImages.length < _maxImages;
    final int gridCount = canAdd
        ? selectedImages.length + 1
        : selectedImages.length;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.photo_library_rounded, color: AppColors.primary),
                const SizedBox(width: 10),
                Text('صور الشحنة', style: AppStyles.styleSemiBold16(context)),
                const Spacer(),
                if (selectedImages.isNotEmpty)
                  TextButton(
                    onPressed: _clearImages,
                    child: const Text(
                      'حذف الكل',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade200),
          // Grid
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: gridCount,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    if (index == selectedImages.length && canAdd) {
                      return ImagePickerWidget(
                        onImageChanged: _addImage,
                        addImageText: 'إضافة',
                      );
                    }
                    return _ImageTile(
                      file: selectedImages[index],
                      onRemove: () => _removeImage(index),
                    );
                  },
                ),
                const SizedBox(height: 12),
                Text(
                  'عدد الصور: ${selectedImages.length} / $_maxImages',
                  style: AppStyles.styleMedium12(
                    context,
                  ).copyWith(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageTile extends StatelessWidget {
  final File file;
  final VoidCallback onRemove;

  const _ImageTile({required this.file, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.file(
            file,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Positioned(
          top: 6,
          right: 6,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.red.withAlpha(200),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 14, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
