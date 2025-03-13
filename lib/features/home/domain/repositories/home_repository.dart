import 'package:formularios_app/core/either/either.dart';
import 'package:formularios_app/features/home/domain/entiites/address.dart';

abstract class HomeRepository {
  Future<Either<String, String>> getEmailUSer();
  Future<Either<dynamic, List<Address>>> getAddreses({required String email});
  Future<Either<dynamic, dynamic>> registerAddress({required Address address});
}
