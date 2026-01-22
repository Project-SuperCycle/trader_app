import 'package:flutter/material.dart';
import 'package:supercycle/core/constants.dart';
import 'package:supercycle/core/services/storage_services.dart';
import 'package:supercycle/core/utils/app_colors.dart';
import 'package:supercycle/core/utils/app_styles.dart';
import 'package:supercycle/core/widgets/shipment/shipment_logo.dart';
import 'package:supercycle/core/widgets/shipment/progress_widgets.dart';
import 'package:supercycle/core/widgets/custom_text_field.dart';
import 'package:supercycle/features/sales_process/data/models/dosh_item_model.dart';
import 'package:supercycle/features/sales_process/data/models/create_shipment_model.dart';
import 'package:supercycle/features/sales_process/presentation/widgets/entry_shipment_details_cotent.dart';
import 'package:supercycle/features/sales_process/presentation/widgets/sales_process_shipment_header.dart';
import 'package:supercycle/features/sales_process/presentation/widgets/shipment_review_dialog.dart';
import 'package:supercycle/generated/l10n.dart';
import 'dart:io';

class SalesProcessViewBody extends StatefulWidget {
  const SalesProcessViewBody({super.key});

  @override
  State<SalesProcessViewBody> createState() => _SalesProcessViewBodyState();
}

class _SalesProcessViewBodyState extends State<SalesProcessViewBody> {
  int currentStep = 0;
  List<DoshItemModel> products = [];
  List<File> selectedImages = [];
  DateTime? selectedDateTime;
  String userAddress = "";
  TextEditingController addressController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  String shipmentNumber = '';

  @override
  void initState() {
    super.initState();
    _getUserAddress();
    shipmentNumber = _generateShipmentNumber();
  }

  String _generateShipmentNumber() {
    return 'SH${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
  }

  void _getUserAddress() async {
    var user = await StorageServices.getUserData();
    if (user == null) return;
    setState(() {
      userAddress = user.bussinessAdress ?? "";
      addressController.text = userAddress;
    });
  }

  void _onImagesChanged(List<File> images) {
    setState(() {
      selectedImages = images;
    });
  }

  void _onDateTimeChanged(DateTime? dateTime) {
    setState(() {
      selectedDateTime = dateTime;
    });
  }

  void _onProductsChanged(List<DoshItemModel> products) {
    setState(() {
      this.products = products;
    });
  }

  bool _validateCurrentStep() {
    switch (currentStep) {
      case 0:
        if (products.isEmpty || products.every((p) => p.name.isEmpty)) {
          _showError('يجب إضافة منتج واحد على الأقل');
          return false;
        }
        return true;
      case 1:
        for (int i = 0; i < products.length; i++) {
          if (products[i].quantity <= 0) {
            _showError('يرجى إدخال الكمية للمنتج رقم ${i + 1}');
            return false;
          }
        }
        return true;
      case 2:
        if (selectedDateTime == null) {
          _showError('يرجى تحديد تاريخ ووقت الاستلام');
          return false;
        }
        return true;
      case 3:
        if (selectedImages.isEmpty) {
          _showError('يرجى إضافة صور للشحنة');
          return false;
        }
        if (addressController.text.isEmpty) {
          _showError('يرجى إدخال عنوان الاستلام');
          return false;
        }
        return true;
      default:
        return true;
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(gradient: kGradientBackground),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(50),
                        blurRadius: 20,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
                          child: ProgressBar(completedSteps: currentStep),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: _buildStepContent(),
                                ),
                                const SizedBox(height: 100),
                              ],
                            ),
                          ),
                        ),
                        _buildNavigationButtons(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: const ShipmentLogo(),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildProductSelectionStep();
      case 1:
        return _buildQuantityStep();
      case 2:
        return _buildDateTimeStep();
      case 3:
        return _buildImagesAndAddressStep();
      default:
        return Container();
    }
  }

  Widget _buildProductSelectionStep() {
    return Column(
      children: [
        _buildStepHeader(
          title: 'اختيار المنتجات',
          subtitle: 'اختر المنتجات التي تريد شحنها',
          icon: Icons.inventory_2_rounded,
          stepNumber: 1,
        ),
        const SizedBox(height: 24),
        EntryShipmentDetailsContent(
          products: products,
          onProductsChanged: _onProductsChanged,
        ),
      ],
    );
  }

  Widget _buildQuantityStep() {
    return Column(
      children: [
        _buildStepHeader(
          title: 'تحديد الكميات',
          subtitle: 'الكميات محددة مع كل منتج',
          icon: Icons.format_list_numbered_rounded,
          stepNumber: 2,
        ),
        const SizedBox(height: 24),
        if (products.isEmpty)
          _buildEmptyState(
            icon: Icons.inventory_outlined,
            message: 'لم يتم إضافة منتجات بعد',
          )
        else
          Column(
            children: products.asMap().entries.map((entry) {
              int idx = entry.key;
              DoshItemModel product = entry.value;
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(25),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.primaryColor.withAlpha(400),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          '${idx + 1}',
                          style: AppStyles.styleSemiBold16(
                            context,
                          ).copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: AppStyles.styleSemiBold14(context),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.scale,
                                size: 16,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${product.quantity} ${product.unit}',
                                style: AppStyles.styleMedium12(context)
                                    .copyWith(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.check_circle, color: Colors.green, size: 24),
                  ],
                ),
              );
            }).toList(),
          ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'يمكنك تعديل الكميات من الخطوة السابقة',
                  style: AppStyles.styleMedium12(
                    context,
                  ).copyWith(color: Colors.blue.shade700),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimeStep() {
    return Column(
      children: [
        _buildStepHeader(
          title: 'موعد الاستلام',
          subtitle: 'حدد التاريخ والوقت المناسب',
          icon: Icons.calendar_month_rounded,
          stepNumber: 3,
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(20),
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
          child: SalesProcessShipmentHeader(
            selectedImages: selectedImages,
            onImagesChanged: _onImagesChanged,
            onDateTimeChanged: _onDateTimeChanged,
            initialDateTime: selectedDateTime,
          ),
        ),
      ],
    );
  }

  Widget _buildImagesAndAddressStep() {
    return Column(
      children: [
        _buildStepHeader(
          title: 'الصور والعنوان',
          subtitle: 'أضف صور الشحنة وحدد عنوان الاستلام',
          icon: Icons.photo_camera_rounded,
          stepNumber: 4,
        ),
        const SizedBox(height: 24),
        _buildSectionCard(
          title: 'صور الشحنة',
          icon: Icons.add_photo_alternate_rounded,
          child: SalesProcessShipmentHeader(
            selectedImages: selectedImages,
            onImagesChanged: _onImagesChanged,
            onDateTimeChanged: _onDateTimeChanged,
            initialDateTime: selectedDateTime,
          ),
        ),
        const SizedBox(height: 16),
        _buildSectionCard(
          title: 'عنوان الاستلام',
          icon: Icons.location_on_rounded,
          child: Column(
            children: [
              CustomTextField(
                label: "العنوان",
                hint: "أدخل عنوان الاستلام",
                controller: addressController,
                keyboardType: TextInputType.text,
                icon: Icons.home_rounded,
                isArabic: true,
                enabled: true,
                borderColor: Colors.green.shade300,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: 18,
                      color: Colors.blue.shade700,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "سيتم استلام الشحنة من هذا العنوان",
                        style: AppStyles.styleMedium12(
                          context,
                        ).copyWith(color: Colors.blue.shade700),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildSectionCard(
          title: 'ملاحظات إضافية (اختياري)',
          icon: Icons.note_alt_rounded,
          child: TextField(
            controller: notesController,
            maxLines: 4,
            style: AppStyles.styleMedium14(context),
            decoration: InputDecoration(
              hintText: 'أضف أي ملاحظات تريد إيصالها...',
              hintStyle: AppStyles.styleMedium14(
                context,
              ).copyWith(color: Colors.grey.shade400),
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.green.shade300, width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepHeader({
    required String title,
    required String subtitle,
    required IconData icon,
    required int stepNumber,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade50, Colors.green.shade100],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withAlpha(50),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withAlpha(100),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(icon, color: Colors.green.shade700, size: 28),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.green.shade700,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$stepNumber',
                        style: AppStyles.styleSemiBold12(
                          context,
                        ).copyWith(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyles.styleSemiBold18(
                    context,
                  ).copyWith(color: Colors.green.shade900),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppStyles.styleMedium12(
                    context,
                  ).copyWith(color: Colors.green.shade700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, color: Colors.green.shade700, size: 22),
                const SizedBox(width: 10),
                Text(title, style: AppStyles.styleSemiBold16(context)),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade200),
          Padding(padding: const EdgeInsets.all(16), child: child),
        ],
      ),
    );
  }

  Widget _buildEmptyState({required IconData icon, required String message}) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Icon(icon, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            message,
            style: AppStyles.styleMedium14(
              context,
            ).copyWith(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: currentStep < 3 ? _buildNextButton() : _buildSubmitButton(),
          ),
          if (currentStep > 0) ...[
            const SizedBox(width: 12),
            Expanded(child: _buildBackButton()),
          ],
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return OutlinedButton(
      onPressed: () => setState(() => currentStep--),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        side: BorderSide(color: Colors.green.shade300, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: _buildButtonContent(
        icon: Icons.arrow_forward_rounded,
        label: 'السابق',
        color: Colors.green.shade700,
        isBack: true,
      ),
    );
  }

  Widget _buildNextButton() {
    return ElevatedButton(
      onPressed: () {
        if (_validateCurrentStep()) {
          setState(() => currentStep++);
        }
      },
      style: _elevatedButtonStyle(),
      child: _buildButtonContent(
        icon: Icons.arrow_back_rounded,
        label: 'التالي',
        color: Colors.white,
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _handleSubmit,
      style: _elevatedButtonStyle(),
      child: _buildButtonContent(
        icon: Icons.check_circle_rounded,
        label: S.of(context).shipment_review,
        color: Colors.white,
      ),
    );
  }

  Widget _buildButtonContent({
    required IconData icon,
    required String label,
    required Color color,
    bool isBack = false,
  }) {
    return isBack
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: AppStyles.styleBold16(context).copyWith(color: color),
              ),
              const SizedBox(width: 8),
              Icon(icon, color: color),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppStyles.styleBold16(context).copyWith(color: color),
              ),
            ],
          );
  }

  ButtonStyle _elevatedButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
    );
  }

  Future<void> _handleSubmit() async {
    if (!_validateCurrentStep()) return;

    try {
      CreateShipmentModel shipment = CreateShipmentModel(
        customPickupAddress: _handleAddress(),
        requestedPickupAt: selectedDateTime,
        images: selectedImages,
        items: products,
        userNotes: notesController.text,
      );

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => ShipmentReviewDialog(
          shipment: shipment,
          onConfirm: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('تم تأكيد الشحنة بنجاح'),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
          onUpdate: (updatedShipment) {
            setState(() {
              selectedDateTime = updatedShipment.requestedPickupAt;
              addressController.text = updatedShipment.customPickupAddress;
              products = updatedShipment.items;
              selectedImages = updatedShipment.images;
              notesController.text = updatedShipment.userNotes;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('تم حفظ التعديلات بنجاح'),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ: ${e.toString()}'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  String _handleAddress() {
    return (addressController.text.isNotEmpty)
        ? addressController.text
        : userAddress;
  }

  @override
  void dispose() {
    addressController.dispose();
    notesController.dispose();
    super.dispose();
  }
}
