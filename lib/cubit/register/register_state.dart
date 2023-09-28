part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterSuccessState extends RegisterState {}
class RegisterLoadingState extends RegisterState {}
class RegisterErrorState extends RegisterState {
  String errmessage;
  RegisterErrorState({
    required this.errmessage
});
}
