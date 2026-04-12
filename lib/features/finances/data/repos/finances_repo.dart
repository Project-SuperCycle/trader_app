import 'package:dartz/dartz.dart';
import 'package:trader_app/core/errors/failures.dart';
import 'package:trader_app/features/finances/data/models/external/finance_external_model.dart';
import 'package:trader_app/features/finances/data/models/external/single_finance_external_model.dart';
import 'package:trader_app/features/finances/data/models/finance_summary_model.dart';
import 'package:trader_app/features/finances/data/models/meal/finance_meal_model.dart';
import 'package:trader_app/features/finances/data/models/meal/single_finance_meal_model.dart';
import 'package:trader_app/features/finances/data/models/methods/finance_method_model.dart';
import 'package:trader_app/features/finances/data/models/monthly/finance_monthly_model.dart';
import 'package:trader_app/features/finances/data/models/monthly/single_finance_monthly_model.dart';

abstract class FinancesRepo {
  // COMMON METHODS
  Future<Either<Failure, FinanceMethodModel>> getFinanceMethods();

  Future<Either<Failure, FinanceSummaryModel>> getFinancesSummary({
    required String type,
  });

  // EXTERNAL METHODS
  Future<Either<Failure, List<FinanceExternalModel>>> getExternalFinances({
    required String type,
    required String status,
    required int page,
  });

  Future<Either<Failure, SingleFinanceExternalModel>>
  getExternalFinanceDetails({required String shipmentId});

  // MONTHLY METHODS
  Future<Either<Failure, List<FinanceMonthlyModel>>> getMonthlyFinances({
    required String type,
    required String status,
    required int page,
  });

  Future<Either<Failure, SingleFinanceMonthlyModel>> getMonthlyFinanceDetails({
    required String paymentId,
  });

  // MEAL METHODS
  Future<Either<Failure, List<FinanceMealModel>>> getMealFinances({
    required String type,
    required String status,
    required int page,
  });

  Future<Either<Failure, SingleFinanceMealModel>> getMealFinanceDetails({
    required String paymentId,
  });
}
