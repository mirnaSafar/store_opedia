import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'owner_state.dart';

class OwnerCubit extends Cubit<OwnerState> {
  OwnerCubit() : super(OwnerInitial());
}
