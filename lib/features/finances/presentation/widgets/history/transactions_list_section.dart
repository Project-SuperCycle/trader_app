import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trader_app/core/helpers/custom_snack_bar.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/finances/data/cubits/get_finance_transactions/get_finance_transactions_cubit.dart';
import 'package:trader_app/features/finances/presentation/loading/finance_transaction_loading_card.dart';
import 'package:trader_app/features/finances/presentation/loading/finances_transactions_empty.dart';
import 'package:trader_app/features/finances/presentation/widgets/history/finance_transaction_card.dart'
    show FinanceTransactionCard;

// ======== Transactions List Section ========
class TransactionsListSection extends StatelessWidget {
  const TransactionsListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section Header ──
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'أحدث المعاملات',
            textDirection: TextDirection.rtl,
            style: AppStyles.styleBold20(context).copyWith(color: Colors.white),
          ),
        ),

        const SizedBox(height: 14),

        // ── Cards List ──
        BlocConsumer<GetFinanceTransactionsCubit, GetFinanceTransactionsState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is GetFinanceTransactionsFailure) {
              CustomSnackBar.showError(context, state.errMessage);
            }
          },
          builder: (context, state) {
            if (state is GetFinanceTransactionsLoading) {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) =>
                    FinanceTransactionLoadingCard(),
              );
            }
            if (state is GetFinanceTransactionsSuccess &&
                state.finances.isEmpty) {
              return Center(child: FinancesTransactionsEmpty());
            }

            if (state is GetFinanceTransactionsSuccess &&
                state.finances.isNotEmpty) {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.finances.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) =>
                    FinanceTransactionCard(transaction: state.finances[index]),
              );
            }

            return Center(child: FinancesTransactionsEmpty());
          },
        ),
      ],
    );
  }
}
