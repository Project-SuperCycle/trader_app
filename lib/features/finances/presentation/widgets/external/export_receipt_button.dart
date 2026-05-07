import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';
import 'package:trader_app/core/constants.dart';
import 'package:trader_app/core/helpers/custom_loading_indicator.dart';
import 'package:trader_app/core/helpers/custom_snack_bar.dart';
import 'package:trader_app/core/utils/app_colors.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/finances/data/cubits/get_finance_pdf/get_finance_pdf_cubit.dart';

class ExportReceiptButton extends StatelessWidget {
  const ExportReceiptButton({super.key, required this.paymentId});

  final String paymentId;

  Future<void> _exportPdf(BuildContext context) async {
    BlocProvider.of<GetFinancePdfCubit>(
      context,
    ).getFinancePdf(paymentId: paymentId);
  }

  Future<void> openInvoicePdf({required String filePath}) async {
    try {
      // فتح الـ PDF تلقائياً بعد التحميل
      final result = await OpenFilex.open(filePath);

      if (result.type != ResultType.done) {
        throw Exception('Could not open PDF: ${result.message}');
      }
    } catch (e) {
      debugPrint('Invoice download error: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: BlocConsumer<GetFinancePdfCubit, GetFinancePdfState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is GetFinancePdfSuccess) {
            openInvoicePdf(filePath: state.pdfUrl);
          }

          if (state is GetFinancePdfFailure) {
            CustomSnackBar.showError(context, state.errMessage);
          }
        },
        builder: (context, state) {
          if (state is GetFinancePdfLoading) {
            return CustomLoadingIndicator(color: AppColors.primary);
          }
          return DecoratedBox(
            decoration: BoxDecoration(
              gradient: kGradientButton,
              borderRadius: BorderRadius.circular(kButtonBorderRadius),
            ),
            child: ElevatedButton(
              onPressed: () => _exportPdf(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kButtonBorderRadius),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.picture_as_pdf_outlined,
                    size: 20,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'تصدير كـ PDF',
                    style: AppStyles.styleBold18(
                      context,
                    ).copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
