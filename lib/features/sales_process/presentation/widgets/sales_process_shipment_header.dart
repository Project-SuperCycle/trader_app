import 'package:flutter/material.dart';
import 'package:supercycle/core/helpers/date_time_picker_util.dart';
import 'package:supercycle/core/utils/app_colors.dart';
import 'package:supercycle/core/utils/app_styles.dart';
import 'dart:io';
import 'image_picker_widget.dart';
import 'package:intl/intl.dart';

class SalesProcessShipmentHeader extends StatefulWidget {
  final List<File> selectedImages;
  final Function(List<File>) onImagesChanged;
  final Function(DateTime?) onDateTimeChanged;
  final DateTime? initialDateTime;

  const SalesProcessShipmentHeader({
    super.key,
    required this.selectedImages,
    required this.onImagesChanged,
    required this.onDateTimeChanged,
    this.initialDateTime,
  });

  @override
  State<SalesProcessShipmentHeader> createState() =>
      _SalesProcessShipmentHeaderState();
}

class _SalesProcessShipmentHeaderState
    extends State<SalesProcessShipmentHeader> {
  DateTime? selectedDateTime;

  @override
  void initState() {
    super.initState();
    selectedDateTime = widget.initialDateTime;
  }

  @override
  void didUpdateWidget(SalesProcessShipmentHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDateTime != oldWidget.initialDateTime) {
      setState(() {
        selectedDateTime = widget.initialDateTime;
      });
    }
  }

  void _onImageChanged(File? image) {
    if (image == null) return;
    final images = List<File>.from(widget.selectedImages)..add(image);
    widget.onImagesChanged(images);
  }

  void _removeImage(int index) {
    final images = List<File>.from(widget.selectedImages)..removeAt(index);
    widget.onImagesChanged(images);
  }

  void _clearImages() {
    widget.onImagesChanged([]);
  }

  Future<void> _selectDate() async {
    final DateTime? result = await DateTimePickerHelper.selectDateTime(
      context,
      currentSelectedDateTime: selectedDateTime,
    );

    if (result != null) {
      setState(() => selectedDateTime = result);
      widget.onDateTimeChanged(result);
    }
  }

  String _formatDate(DateTime? dateTime) {
    if (dateTime == null) return 'لم يتم تحديد الموعد';
    return DateFormat('dd/MM/yyyy  HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ================= موعد الاستلام =================
        _sectionCard(
          title: 'موعد الاستلام',
          icon: Icons.calendar_month_rounded,
          child: InkWell(
            onTap: _selectDate,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.access_time, color: AppColors.primaryColor),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _formatDate(selectedDateTime),
                      style: AppStyles.styleMedium14(context),
                    ),
                  ),
                  Icon(Icons.edit, color: AppColors.primaryColor, size: 18),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // ================= صور الشحنة =================
        _sectionCard(
          title: 'صور الشحنة',
          icon: Icons.photo_library_rounded,
          trailing: widget.selectedImages.isNotEmpty
              ? TextButton(
                  onPressed: _clearImages,
                  child: const Text(
                    'حذف الكل',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.selectedImages.length < 5
                    ? widget.selectedImages.length + 1
                    : widget.selectedImages.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  // زر إضافة صورة
                  if (index == widget.selectedImages.length &&
                      widget.selectedImages.length < 5) {
                    return ImagePickerWidget(
                      onImageChanged: _onImageChanged,
                      addImageText: 'إضافة',
                    );
                  }

                  // صورة
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(
                          widget.selectedImages[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Positioned(
                        top: 6,
                        right: 6,
                        child: GestureDetector(
                          onTap: () => _removeImage(index),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.red.withAlpha(400),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 10),
              Text(
                'عدد الصور: ${widget.selectedImages.length} / 3',
                style: AppStyles.styleMedium12(
                  context,
                ).copyWith(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ================= Card عام =================
  Widget _sectionCard({
    required String title,
    required IconData icon,
    required Widget child,
    Widget? trailing,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
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
          Row(
            children: [
              Icon(icon, color: AppColors.primaryColor),
              const SizedBox(width: 8),
              Text(title, style: AppStyles.styleSemiBold16(context)),
              const Spacer(),
              if (trailing != null) trailing,
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
