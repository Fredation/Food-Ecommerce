import 'package:food_ecommerce/core/abstractions/injection_module.dart';
import 'package:food_ecommerce/core/model/build_config.dart';
import 'package:food_ecommerce/core/network/api.dart';
import 'package:food_ecommerce/core/storage/storage.dart';
import 'package:food_ecommerce/features/address/data/datasources/address_ds.dart';
import 'package:food_ecommerce/features/address/data/repositories/address_repo_impl.dart';
import 'package:food_ecommerce/features/address/domain/reposiory/address_repo.dart';
import 'package:food_ecommerce/features/address/domain/usecases/create_address_usecase.dart';
import 'package:food_ecommerce/features/address/domain/usecases/delete_address_usecase.dart';
import 'package:food_ecommerce/features/address/domain/usecases/get_addresses_usecase.dart';
import 'package:food_ecommerce/features/address/presentation/state/address_cubit.dart';
import 'package:food_ecommerce/features/auth/data/datasources/auth_ds.dart';
import 'package:food_ecommerce/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:food_ecommerce/features/auth/domain/repositories/auth_repo.dart';
import 'package:food_ecommerce/features/auth/domain/usecases/get_user_data_usecase.dart';
import 'package:food_ecommerce/features/auth/domain/usecases/log_out_usecase.dart';
import 'package:food_ecommerce/features/auth/domain/usecases/login_usecase.dart';
import 'package:food_ecommerce/features/auth/domain/usecases/register_usecase.dart';
import 'package:food_ecommerce/features/auth/domain/usecases/save_user_image_to_storage.dart';
import 'package:food_ecommerce/features/auth/domain/usecases/save_user_to_db.dart';
import 'package:food_ecommerce/features/auth/domain/usecases/update_user_db_usecase.dart';
import 'package:food_ecommerce/features/auth/presentation/state/auth_cubit.dart';
import 'package:food_ecommerce/features/cart/data/datasources/cart_ds.dart';
import 'package:food_ecommerce/features/cart/data/repositories/cart_repo_impl.dart';
import 'package:food_ecommerce/features/cart/domain/repository/cart_repo.dart';
import 'package:food_ecommerce/features/cart/domain/usecases/add_cart_add_usecase.dart';
import 'package:food_ecommerce/features/cart/domain/usecases/add_recipient_usecase.dart';
import 'package:food_ecommerce/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:food_ecommerce/features/cart/domain/usecases/get_cart_add_usecase.dart';
import 'package:food_ecommerce/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:food_ecommerce/features/cart/domain/usecases/get_recipient_usecase.dart';
import 'package:food_ecommerce/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:food_ecommerce/features/cart/presentation/state/cart_cubit.dart';
import 'package:food_ecommerce/features/store/data/datasources/store_ds.dart';
import 'package:food_ecommerce/features/store/data/repositories/product_repo_impl.dart';
import 'package:food_ecommerce/features/store/domain/repositories/product_repo.dart';
import 'package:food_ecommerce/features/store/domain/usecases/get_favorites_usecase.dart';
import 'package:food_ecommerce/features/store/domain/usecases/get_products_usecase.dart';
import 'package:food_ecommerce/features/store/domain/usecases/toggle_fav_usecase.dart';
import 'package:food_ecommerce/features/store/presentation/state/store_cubit.dart';
import 'package:get_it/get_it.dart';
import 'dart:async';

class AppInjectionModule implements InjectionModule {
  @override
  FutureOr<void> registerDependencies(
      {required GetIt injector, required BuildConfig buildConfig}) {
    injector.registerLazySingleton<Storage>(() => StorageImpl());

    // injector.registerLazySingleton(() => Api(buildConfig: buildConfig));

    //features
    injector.registerFactory(
      () => AuthCubit(
        registerUsecase: injector.get(),
        loginUsecase: injector.get(),
        logoutUsecase: injector.get(),
        saveUserToDBUsecase: injector.get(),
        getUserDataUsecase: injector.get(),
        saveUserImageToStorageUsecase: injector.get(),
        updateUserDBUsecase: injector.get(),
      ),
    );
    injector.registerFactory(
      () => StoreCubit(
        getProductsUsecase: injector.get(),
        getFavoriteUsecase: injector.get(),
        toggleFavUsecase: injector.get(),
      ),
    );
    injector.registerFactory(
      () => CartCubit(
        addToCartUsecase: injector.get(),
        getCartUsecase: injector.get(),
        removeFromCartUsecase: injector.get(),
        addCartAddressUsecase: injector.get(),
        addRecipientUsecase: injector.get(),
        getCartAddressUsecase: injector.get(),
        getRecipientUsecase: injector.get(),
      ),
    );
    injector.registerFactory(
      () => AddressCubit(
        createAddressUsecase: injector.get(),
        getAddressesUsecase: injector.get(),
        deleteAddressUsecase: injector.get(),
      ),
    );

    //usecases
    injector.registerLazySingleton(() => RegisterUsecase(injector()));
    injector.registerLazySingleton(() => LoginUsecase(injector()));
    injector.registerLazySingleton(() => LogoutUsecase(injector()));
    injector.registerLazySingleton(() => GetProductsUsecase(injector()));
    injector.registerLazySingleton(() => SaveUserToDBUsecase(injector()));
    injector.registerLazySingleton(() => GetUserDataUsecase(injector()));
    injector
        .registerLazySingleton(() => SaveUserImageToStorageUsecase(injector()));
    injector.registerLazySingleton(() => AddToCartUsecase(injector()));
    injector.registerLazySingleton(() => RemoveFromCartUsecase(injector()));
    injector.registerLazySingleton(() => GetCartUsecase(injector()));
    injector.registerLazySingleton(() => CreateAddressUsecase(injector()));
    injector.registerLazySingleton(() => GetAddressesUsecase(injector()));
    injector.registerLazySingleton(() => DeleteAddressUsecase(injector()));
    injector.registerLazySingleton(() => GetFavoriteUsecase(injector()));
    injector.registerLazySingleton(() => ToggleFavUsecase(injector()));
    injector.registerLazySingleton(() => UpdateUserDBUsecase(injector()));
    injector.registerLazySingleton(() => AddCartAddressUsecase(injector()));
    injector.registerLazySingleton(() => AddRecipientUsecase(injector()));
    injector.registerLazySingleton(() => GetCartAddressUsecase(injector()));
    injector.registerLazySingleton(() => GetRecipientUsecase(injector()));

    //repositories
    injector.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(authDS: injector()),
    );
    injector.registerLazySingleton<ProductRepo>(
      () => ProductRepoImpl(storeDS: injector()),
    );
    injector.registerLazySingleton<CartRepo>(
      () => CartRepoImpl(cartDS: injector()),
    );
    injector.registerLazySingleton<AddressRepo>(
      () => AddressRepoImpl(addressDS: injector()),
    );

    //datasources
    injector.registerLazySingleton<AuthDS>(
      () => AuthDSImpl(storage: injector()),
    );
    injector.registerLazySingleton<StoreDS>(
      () => StoreDSImpl(storage: injector()),
    );
    injector.registerLazySingleton<CartDS>(
      () => CartDSImpl(),
    );
    injector.registerLazySingleton<AddressDS>(
      () => AddressDSImpl(),
    );
  }
}
