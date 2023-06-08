import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_owner_state.dart';

class UpdateOwnerCubit extends Cubit<UpdateOwnerState> {
  UpdateOwnerCubit() : super(UpdateOwnerInitial());
}
