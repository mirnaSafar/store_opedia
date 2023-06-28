import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopesapp/data/repositories/auth_repository.dart';

part 'verify_password_state.dart';

class VerifyPasswordCubit extends Cubit<VerifyPasswordState> {
  VerifyPasswordCubit() : super(VerifyPasswordInitial());
}
