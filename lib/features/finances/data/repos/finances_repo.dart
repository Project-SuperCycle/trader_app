import 'package:dartz/dartz.dart';
import 'package:trader_app/core/errors/failures.dart';
import 'package:trader_app/core/models/finances_methods_model.dart';
import 'package:trader_app/features/finances/data/models/external/single_finance_external_model.dart';
import 'package:trader_app/features/finances/data/models/finance_transaction_model.dart';
import 'package:trader_app/features/finances/data/models/internal/single_finance_internal_model.dart';
import 'package:trader_app/features/finances/data/models/summary/finance_summary_model.dart';

abstract class FinancesRepo {
  // COMMON METHODS
  Future<Either<Failure, FinancesMethodsModel>> getFinanceMethods();

  Future<Either<Failure, FinanceSummaryModel>> getFinancesSummary({
    required String type,
  });

  Future<Either<Failure, void>> getFinancePdf({required String paymentId});

  Future<Either<Failure, List<FinanceTransactionModel>>>
  getFinanceTransactions({
    required String status,
    required int page,
    required String type,
  });

  // EXTERNAL METHODS
  Future<Either<Failure, SingleFinanceExternalModel>>
  getExternalFinanceDetails({required String shipmentId});

  // MONTHLY METHODS
  Future<Either<Failure, SingleFinanceInternalModel>> getMonthlyFinanceDetails({
    required String paymentId,
  });

  // MEAL METHODS
  Future<Either<Failure, SingleFinanceInternalModel>> getMealFinanceDetails({
    required String paymentId,
  });
}
