import 'package:dartz/dartz.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/core/usecases/usecase.dart';
import 'package:food_ecommerce/features/store/domain/entities/product.dart';

import '../repositories/product_repo.dart';

class GetProductsUsecase extends UseCase<List<Product>, NoParams> {
  final ProductRepo repo;

  GetProductsUsecase(this.repo);

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return await repo.getProducts();
  }
}

// class GetP {
//   final ProductRepoImpl popularProductRepo;

//   PopularProductController({required this.popularProductRepo});

//   List<dynamic> _popularProductList = [];
//   List<dynamic> get popularProductList => _popularProductList;

  // Future<void> getPopularProductList() async {
  //   Response response = await popularProductRepo.getPopularProductList();

  //   if (response.statusCode == 200) {
  //     _popularProductList = [];
  //     _popularProductList.addAll(_popularProductList);
  //     update();
  //   } else {}
  // }
//}
