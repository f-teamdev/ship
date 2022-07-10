import 'package:flutter_triple/flutter_triple.dart';
import 'package:fpdart/fpdart.dart';

class CustomEitherAdapter<Left, Right> extends EitherAdapter<Left, Right> {
  final Either<Left, Right> usecase;

  CustomEitherAdapter._(this.usecase);

  @override
  T fold<T>(T Function(Left l) leftF, T Function(Right l) rightF) {
    return usecase.fold(leftF, rightF);
  }

  static Future<EitherAdapter<L, R>> adapter<L, R>(TaskEither<L, R> usecase) async {
    return await usecase.run().then((value) => CustomEitherAdapter._(value));
  }
}
