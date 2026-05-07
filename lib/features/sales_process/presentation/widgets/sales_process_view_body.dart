import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trader_app/core/constants.dart';
import 'package:trader_app/core/helpers/custom_snack_bar.dart';
import 'package:trader_app/core/models/trader_branch_model.dart';
import 'package:trader_app/core/services/storage_services.dart';
import 'package:trader_app/core/utils/app_colors.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/core/widgets/shipment/progress_widgets.dart';
import 'package:trader_app/core/widgets/shipment/shipment_logo.dart';
import 'package:trader_app/features/sales_process/data/models/create_shipment_model.dart';
import 'package:trader_app/features/sales_process/data/models/dosh_item_model.dart';
import 'package:trader_app/features/sales_process/presentation/widgets/shipment_review_dialog.dart';
import 'package:trader_app/features/sales_process/presentation/widgets/steps/address_step.dart';
import 'package:trader_app/features/sales_process/presentation/widgets/steps/date_time_step.dart';
import 'package:trader_app/features/sales_process/presentation/widgets/steps/images_step.dart';
import 'package:trader_app/features/sales_process/presentation/widgets/steps/product_selection_step.dart';
import 'package:trader_app/features/sales_process/presentation/widgets/steps/quantity_step.dart';
import 'package:trader_app/generated/l10n.dart';

/// Total number of steps in the shipment flow.
const int _totalSteps = 5;

class SalesProcessViewBody extends StatefulWidget {
  const SalesProcessViewBody({super.key});

  @override
  State<SalesProcessViewBody> createState() => _SalesProcessViewBodyState();
}

class _SalesProcessViewBodyState extends State<SalesProcessViewBody> {
  // ─── State ────────────────────────────────────────────────
  int _currentStep = 0;
  List<DoshItemModel> _products = [];
  List<File> _selectedImages = [];
  DateTime? _selectedDateTime;
  String _userAddress = '';
  String _userRole = '';

  // Branch
  List<TraderBranchModel> _branches = [];
  String? _selectedBranchId;
  String? _selectedBranchName;

  String? _selectedFinanceMethod;

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  // ─── Lifecycle ────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    _loadUserAddress();
    _loadUserBranches();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  // ─── Data Loading ─────────────────────────────────────────
  Future<void> _loadUserAddress() async {
    final user = await StorageServices.getUserData();
    if (user == null || !mounted) return;
    setState(() {
      _userAddress = user.bussinessAdress ?? '';
      _userRole = user.role ?? '';
      _addressController.text = _userAddress;
    });
  }

  Future<void> _loadUserBranches() async {
    final stored = await StorageServices.getUserBranches();
    if (!mounted) return;
    setState(() => _branches = stored);
  }

  // ─── Callbacks passed down to steps ───────────────────────
  void _onProductsChanged(List<DoshItemModel> products) {
    setState(() => _products = products);
  }

  void _onDateTimeChanged(DateTime? dateTime) {
    setState(() => _selectedDateTime = dateTime);
  }

  void _onImagesChanged(List<File> images) {
    setState(() => _selectedImages = images);
  }

  void _onBranchChanged(String? branchName) {
    if (branchName == null) return;
    final branch = _branches.firstWhere(
      (b) => b.branchName == branchName,
      orElse: () => _branches.first,
    );
    setState(() {
      _selectedBranchName = branch.branchName;
      _selectedBranchId = branch.branchId;
    });
  }

  // ─── Validation ───────────────────────────────────────────
  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0: // Products
        if (_products.isEmpty || _products.every((p) => p.name.isEmpty)) {
          _showError('يجب إضافة منتج واحد على الأقل');
          return false;
        }
        return true;

      case 1: // Quantities
        for (int i = 0; i < _products.length; i++) {
          if (_products[i].quantity <= 0) {
            _showError('يرجى إدخال الكمية للمنتج رقم ${i + 1}');
            return false;
          }
        }
        return true;

      case 2: // DateTime
        if (_selectedDateTime == null) {
          _showError('يرجى تحديد تاريخ ووقت الاستلام');
          return false;
        }
        return true;

      case 3: // Images
        if (_selectedImages.isEmpty) {
          _showError('يرجى إضافة صور للشحنة');
          return false;
        }
        return true;

      case 4: // Address / Branch
        if (_userRole == 'trader_contracted') {
          if (_selectedBranchId == null) {
            _showError('يرجى اختيار الفرع');
            return false;
          }
        } else {
          if (_addressController.text.trim().isEmpty) {
            _showError('يرجى إدخال عنوان الاستلام');
            return false;
          }
        }
        return true;

      default:
        return true;
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    CustomSnackBar.showError(context, message);
  }

  // ─── Navigation ───────────────────────────────────────────
  void _goNext() {
    if (_validateCurrentStep()) {
      setState(() => _currentStep++);
    }
  }

  void _goBack() {
    setState(() => _currentStep--);
  }

  // ─── Submit ───────────────────────────────────────────────
  Future<void> _handleSubmit() async {
    if (!_validateCurrentStep()) return;

    final shipment = CreateShipmentModel(
      customPickupAddress: _addressController.text.isNotEmpty
          ? _addressController.text
          : _userAddress,
      requestedPickupAt: _selectedDateTime,
      images: _selectedImages,
      items: _products,
      userNotes: _notesController.text,
      selectedBranchId: _selectedBranchId,
      selectedBranchName: _selectedBranchName,
      finance: _selectedFinanceMethod ?? 'cash',
    );
    CustomSnackBar.showInfo(context, shipment.finance);

    try {
      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => ShipmentReviewDialog(
          shipment: shipment,
          onConfirm: () => _showSuccess('تم تأكيد الشحنة بنجاح'),
          onUpdate: (updated) => _applyUpdatedShipment(updated),
        ),
      );
    } catch (e) {
      _showError('حدث خطأ: ${e.toString()}');
    }
  }

  void _applyUpdatedShipment(CreateShipmentModel updated) {
    setState(() {
      _selectedDateTime = updated.requestedPickupAt;
      _addressController.text = updated.customPickupAddress;
      _products = updated.items;
      _selectedImages = updated.images;
      _notesController.text = updated.userNotes;
      _selectedBranchId = updated.selectedBranchId;
      _selectedBranchName = updated.selectedBranchName;
      _selectedFinanceMethod = updated.finance;
    });
    _showSuccess('تم حفظ التعديلات بنجاح');
  }

  void _showSuccess(String message) {
    if (!mounted) return;
    CustomSnackBar.showSuccess(context, message);
  }

  // ─── Build ────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: kGradientBackground),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(child: _buildWhitePanel()),
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

  Widget _buildWhitePanel() {
    return Container(
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
              child: ProgressBar(completedSteps: _currentStep),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _buildCurrentStep(),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  // ─── Step Routing ─────────────────────────────────────────
  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return ProductSelectionStep(
          products: _products,
          onProductsChanged: _onProductsChanged,
        );
      case 1:
        return QuantityStep(products: _products);
      case 2:
        return DateTimeStep(
          initialDateTime: _selectedDateTime,
          onDateTimeChanged: _onDateTimeChanged,
          selectedFinanceMethod: _selectedFinanceMethod,
          onFinanceChanged: (method) =>
              setState(() => _selectedFinanceMethod = method),
        );
      case 3:
        return ImagesStep(
          selectedImages: _selectedImages,
          onImagesChanged: _onImagesChanged,
        );
      case 4:
        return AddressStep(
          addressController: _addressController,
          notesController: _notesController,
          userRole: _userRole,
          branches: _branches,
          selectedBranchName: _selectedBranchName,
          onBranchChanged: _onBranchChanged,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  // ─── Navigation Buttons ───────────────────────────────────
  Widget _buildNavigationButtons() {
    final bool isLastStep = _currentStep == _totalSteps - 1;

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
            child: isLastStep ? _buildSubmitButton() : _buildNextButton(),
          ),
          if (_currentStep > 0) ...[
            const SizedBox(width: 12),
            Expanded(child: _buildBackButton()),
          ],
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return ElevatedButton(
      onPressed: _goNext,
      style: _primaryButtonStyle(),
      child: _buttonRow(
        icon: Icons.arrow_back_rounded,
        label: 'التالي',
        color: Colors.white,
        iconFirst: true,
      ),
    );
  }

  Widget _buildBackButton() {
    return OutlinedButton(
      onPressed: _goBack,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        side: BorderSide(color: Colors.green.shade300, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: _buttonRow(
        icon: Icons.arrow_forward_rounded,
        label: 'السابق',
        color: Colors.green.shade700,
        iconFirst: false,
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _handleSubmit,
      style: _primaryButtonStyle(),
      child: _buttonRow(
        icon: Icons.check_circle_rounded,
        label: S.of(context).shipment_review,
        color: Colors.white,
        iconFirst: true,
      ),
    );
  }

  ButtonStyle _primaryButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
    );
  }

  Widget _buttonRow({
    required IconData icon,
    required String label,
    required Color color,
    required bool iconFirst,
  }) {
    final iconWidget = Icon(icon, color: color);
    final textWidget = Text(
      label,
      style: AppStyles.styleBold16(context).copyWith(color: color),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: iconFirst
          ? [iconWidget, const SizedBox(width: 8), textWidget]
          : [textWidget, const SizedBox(width: 8), iconWidget],
    );
  }
}
