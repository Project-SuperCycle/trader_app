import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trader_app/core/constants.dart';
import 'package:trader_app/core/helpers/custom_snack_bar.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/finances/data/cubits/get_external_finance_details/get_external_finance_details_cubit.dart';
import 'package:trader_app/features/finances/presentation/loading/finance_external_details_loading.dart';
import 'package:trader_app/features/finances/presentation/widgets/external/collection_details_card.dart';
import 'package:trader_app/features/finances/presentation/widgets/external/export_receipt_button.dart';
import 'package:trader_app/features/finances/presentation/widgets/external/products_list_section.dart';
import 'package:trader_app/features/finances/presentation/widgets/external/shipment_hero_card.dart';

class FinanceExternalDetailsViewBody extends StatelessWidget {
  const FinanceExternalDetailsViewBody({super.key});

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
                      GetExternalFinanceDetailsCubit,
                      GetExternalFinanceDetailsState
                    >(
                      listener: (context, state) {
                        // TODO: implement listener
                        if (state is GetExternalFinanceDetailsFailure) {
                          CustomSnackBar.showError(context, state.errMessage);
                        }
                      },
                      builder: (context, state) {
                        if (state is GetExternalFinanceDetailsLoading) {
                          return const FinanceExternalDetailsLoading();
                        }

                        if (state is GetExternalFinanceDetailsSuccess) {
                          final transaction = state.finance;
                          return Column(
                            children: [
                              ShipmentHeroCard(transaction: transaction),
                              const SizedBox(height: 16),
                              ProductsListSection(products: transaction.items),
                              const SizedBox(height: 16),
                              CollectionDetailsCard(transaction: transaction),
                              const SizedBox(height: 20),
                              ExportReceiptButton(
                                paymentId: transaction.paymentId,
                              ),
                            ],
                          );
                        }
                        return const SizedBox();
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
