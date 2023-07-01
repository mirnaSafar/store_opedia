import 'package:bloc/bloc.dart';

part 'verify_password_state.dart';

class VerifyPasswordCubit extends Cubit<VerifyPasswordState> {
  VerifyPasswordCubit() : super(VerifyPasswordInitial());
}
