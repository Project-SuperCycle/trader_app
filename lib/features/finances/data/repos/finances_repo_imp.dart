import 'package:dartz/dartz.dart';
import 'package:trader_app/core/constants/storage_constants.dart';
import 'package:trader_app/core/errors/failures.dart';
import 'package:trader_app/core/helpers/error_handler.dart';
import 'package:trader_app/core/services/api_endpoints.dart';
import 'package:trader_app/core/services/api_services.dart';
import 'package:trader_app/core/services/storage_services.dart';
import 'package:trader_app/features/finances/data/models/external/finance_external_model.dart';
import 'package:trader_app/features/finances/data/models/external/single_finance_external_model.dart';
import 'package:trader_app/features/finances/data/models/finance_summary_model.dart';
import 'package:trader_app/features/finances/data/models/meal/finance_meal_model.dart';
import 'package:trader_app/features/finances/data/models/meal/single_finance_meal_model.dart';
import 'package:trader_app/features/finances/data/models/methods/finance_method_model.dart';
import 'package:trader_app/features/finances/data/models/monthly/finance_monthly_model.dart';
import 'package:trader_app/features/finances/data/models/monthly/single_finance_monthly_model.dart';
import 'package:trader_app/features/finances/data/repos/finances_repo.dart';

class FinancesRepoImp implements FinancesRepo {
  final ApiServices apiServices;

  FinancesRepoImp({required this.apiServices});

  // COMMON METHODS
  @override
  Future<Either<Failure, FinanceMethodModel>> getFinanceMethods() {
    // TODO: implement getFinanceMethods
    return ErrorHandler.handleApiResponse<FinanceMethodModel>(
      apiCall: () => apiServices.get(endPoint: ApiEndpoints.getFinancesMethods),
      errorContext: 'get finances methods',
      responseParser: (response) {
        final data = response['data'];
        return FinanceMethodModel.fromJson(data);
      },
    );
  }

  @override
  Future<Either<Failure, FinanceSummaryModel>> getFinancesSummary({
    required String type,
  }) {
    // TODO: implement getFinancesSummary
    return ErrorHandler.handleApiResponse<FinanceSummaryModel>(
      apiCall: () => apiServices.get(
        endPoint: ApiEndpoints.getFinancesSummary,
        query: {"type": type},
      ),
      errorContext: 'get finances summary',
      responseParser: (response) {
        final data = response['data'];
        return FinanceSummaryModel.fromJson(data);
      },
    );
  }

  // EXTERNAL METHODS
  @override
  Future<Either<Failure, SingleFinanceExternalModel>>
  getExternalFinanceDetails({required String shipmentId}) {
    // TODO: implement getExternalFinanceDetails
    return ErrorHandler.handleApiResponse<SingleFinanceExternalModel>(
      apiCall: () => apiServices.get(
        endPoint: ApiEndpoints.getExternalFinanceDetails.replaceAll(
          '{shipmentId}',
          shipmentId,
        ),
        query: {"shipmentId": shipmentId},
      ),
      errorContext: 'get external finance details',
      responseParser: (response) {
        final data = response['data'];
        return SingleFinanceExternalModel.fromJson(data);
      },
    );
  }

  @override
  Future<Either<Failure, List<FinanceExternalModel>>> getExternalFinances({
    required String type,
    required String status,
    required int page,
  }) {
    // TODO: implement getExternalFinances
    return ErrorHandler.handleApiResponse<List<FinanceExternalModel>>(
      apiCall: () => apiServices.get(
        endPoint: ApiEndpoints.getFinancesItems,
        query: {"type": type, "status": status, "page": page},
      ),
      errorContext: 'get trader external finances',
      responseParser: (response) {
        final List data = response['data'];
        final int meta = response['meta']['totalPages'];
        StorageServices.storeData(
          StorageConstants.EXTERNAL_FINANCES_PAGES,
          meta,
        );
        return data.map((e) => FinanceExternalModel.fromJson(e)).toList();
      },
    );
  }

  // MEAL METHODS
  @override
  Future<Either<Failure, SingleFinanceMealModel>> getMealFinanceDetails({
    required String paymentId,
  }) {
    // TODO: implement getMealFinanceDetails
    return ErrorHandler.handleApiResponse<SingleFinanceMealModel>(
      apiCall: () => apiServices.get(
        endPoint: ApiEndpoints.getMealFinanceDetails.replaceAll(
          '{paymentId}',
          paymentId,
        ),
        query: {"paymentId": paymentId},
      ),
      errorContext: 'get meal finance details',
      responseParser: (response) {
        final data = response['data'];
        return SingleFinanceMealModel.fromJson(data);
      },
    );
  }

  @override
  Future<Either<Failure, List<FinanceMealModel>>> getMealFinances({
    required String type,
    required String status,
    required int page,
  }) {
    // TODO: implement getMealFinances
    return ErrorHandler.handleApiResponse<List<FinanceMealModel>>(
      apiCall: () => apiServices.get(
        endPoint: ApiEndpoints.getFinancesItems,
        query: {"type": type, "status": status, "page": page},
      ),
      errorContext: 'get trader meal finances',
      responseParser: (response) {
        final List data = response['data'];
        final int meta = response['meta']['totalPages'];
        StorageServices.storeData(StorageConstants.MEAL_FINANCES_PAGES, meta);
        return data.map((e) => FinanceMealModel.fromJson(e)).toList();
      },
    );
  }

  // MONTHLY METHODS
  @override
  Future<Either<Failure, SingleFinanceMonthlyModel>> getMonthlyFinanceDetails({
    required String paymentId,
  }) {
    // TODO: implement getMonthlyFinanceDetails
    return ErrorHandler.handleApiResponse<SingleFinanceMonthlyModel>(
      apiCall: () => apiServices.get(
        endPoint: ApiEndpoints.getMonthlyFinanceDetails.replaceAll(
          '{paymentId}',
          paymentId,
        ),
        query: {"paymentId": paymentId},
      ),
      errorContext: 'get monthly finance details',
      responseParser: (response) {
        final data = response['data'];
        return SingleFinanceMonthlyModel.fromJson(data);
      },
    );
  }

  @override
  Future<Either<Failure, List<FinanceMonthlyModel>>> getMonthlyFinances({
    required String type,
    required String status,
    required int page,
  }) {
    // TODO: implement getMonthlyFinances
    return ErrorHandler.handleApiResponse<List<FinanceMonthlyModel>>(
      apiCall: () => apiServices.get(
        endPoint: ApiEndpoints.getFinancesItems,
        query: {"type": type, "status": status, "page": page},
      ),
      errorContext: 'get trader monthly finances',
      responseParser: (response) {
        final List data = response['data'];
        final int meta = response['meta']['totalPages'];
        StorageServices.storeData(
          StorageConstants.MONTHLY_FINANCES_PAGES,
          meta,
        );
        return data.map((e) => FinanceMonthlyModel.fromJson(e)).toList();
      },
    );
  }
}
