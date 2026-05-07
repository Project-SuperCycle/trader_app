import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trader_app/core/constants.dart';
import 'package:trader_app/core/helpers/custom_snack_bar.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/finances/data/cubits/get_internal_finance_details/get_internal_finance_details_cubit.dart';
import 'package:trader_app/features/finances/presentation/loading/finance_internal_details_loading.dart';
import 'package:trader_app/features/finances/presentation/widgets/external/export_receipt_button.dart';
import 'package:trader_app/features/finances/presentation/widgets/internal/financial_collection_card.dart';
import 'package:trader_app/features/finances/presentation/widgets/internal/shipments_list_section.dart';

class FinanceInternalDetailsViewBody extends StatelessWidget {
  const FinanceInternalDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: kGradientBackground),
      child: SafeArea(
        child: Column(
          children: [
            // ── Header ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title
                  Text(
                    'تفاصيل المعاملة',
                    textDirection: TextDirection.rtl,
                    style: AppStyles.styleBold20(
                      context,
                    ).copyWith(color: Colors.white),
                  ),

                  // Back Button
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Content ──
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child:
                    BlocConsumer<
                      GetInternalFinanceDetailsCubit,
                      GetInternalFinanceDetailsState
                    >(
                      listener: (context, state) {
                        // TODO: implement listener
                        if (state is GetInternalFinanceDetailsFailure) {
                          CustomSnackBar.showError(context, state.errMessage);
                        }
                      },
                      builder: (context, state) {
                        if (state is GetInternalFinanceDetailsLoading) {
                          return const FinanceInternalDetailsLoading();
                        }
                        if (state is GetInternalFinanceDetailsSuccess) {
                          return Column(
                            children: [
                              FinancialCollectionCard(
                                transaction: state.finance,
                              ),
                              const SizedBox(height: 16),
                              ShipmentsListSection(
                                shipments: state.finance.shipments,
                              ),
                              const SizedBox(height: 16),
                              ExportReceiptButton(
                                paymentId: state.finance.paymentId!,
                              ),
                              const SizedBox(height: 16),
                            ],
                          );
                        }
                        return Container();
                      },
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
