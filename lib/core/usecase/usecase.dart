// Use case interface for handling usecases
abstract class UseCase<Type, Params> {
  Future<Type> call({Params params});
}
