import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trader_app/core/utils/app_assets.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/settings/presentation/widgets/cancel_button.dart';
import 'package:trader_app/features/settings/presentation/widgets/save_button.dart';

class ChangeImageWidget extends StatefulWidget {
  final String? currentImageUrl;
  final void Function(File imageFile)? onSave;
  final VoidCallback? onCancel;

  const ChangeImageWidget({
    super.key,
    this.currentImageUrl,
    this.onSave,
    this.onCancel,
  });

  @override
  State<ChangeImageWidget> createState() => _ChangeImageWidgetState();
}

class _ChangeImageWidgetState extends State<ChangeImageWidget> {
  File? _selectedImage;
  bool _isSaving = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked == null) return;
    setState(() => _selectedImage = File(picked.path));
  }

  Future<void> _save() async {
    if (_selectedImage == null) return;
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(milliseconds: 800)); // simulate upload
    widget.onSave?.call(_selectedImage!);
    if (mounted) setState(() => _isSaving = false);
  }

  void _cancel() {
    setState(() => _selectedImage = null);
    widget.onCancel?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.center,
              child: _AvatarPicker(
                selectedImage: _selectedImage,
                networkUrl: widget.currentImageUrl,
                onTap: _pickImage,
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.center,
              child: Text(
                'تغيير الصورة الشخصية',
                style: AppStyles.styleMedium16(
                  context,
                ).copyWith(color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 28),
            SaveButton(onSave: _save),
            const SizedBox(height: 10),
            CancelButton(onCancel: _cancel),
          ],
        ),
      ),
    );
  }
}

// ── Sub-widgets ──────────────────────────────────────────────────────────────

class _AvatarPicker extends StatelessWidget {
  final File? selectedImage;
  final String? networkUrl;
  final VoidCallback onTap;

  const _AvatarPicker({
    required this.selectedImage,
    required this.networkUrl,
    required this.onTap,
  });

  ImageProvider get _imageProvider {
    // if (selectedImage != null) return FileImage(selectedImage!);
    // if (networkUrl != null) return NetworkImage(networkUrl!);
    return const AssetImage(AppAssets.defaultAvatar);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 80,
            backgroundColor: Colors.grey[200],
            backgroundImage: _imageProvider,
          ),
          Positioned(
            bottom: 2,
            right: 2,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF1D6B5E),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
