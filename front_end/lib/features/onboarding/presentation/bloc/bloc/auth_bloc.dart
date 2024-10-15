import 'package:bloc/bloc.dart';
import 'package:front_end/core/usecase/usecase.dart';
import 'package:front_end/features/book/domain/usecase/delete_book_usecase.dart';
import 'package:front_end/features/onboarding/domain/entity/log_in_entity.dart';
import 'package:front_end/features/onboarding/domain/entity/sign_up_entity.dart';
import 'package:front_end/features/onboarding/domain/usecase/log_out_usecase.dart';
import 'package:front_end/features/onboarding/domain/usecase/login_usecase.dart';
import 'package:front_end/features/onboarding/domain/usecase/signUp_usecase.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;
  final LogInUseCase logInUseCase;
  final LogoutUsecase loguoutUsecase;
  final DeleteBookUsecase deleteBookUsecase;

  AuthBloc(this.signUpUseCase, this.logInUseCase, this.loguoutUsecase,
      this.deleteBookUsecase)
      : super(AuthInitial()) {
    on<SingUpEvent>((event, emit) async {
      emit(AuthLoadingState());

      final res = await signUpUseCase(UseCaseParams(event.signUpEntity));

      res.fold(
        (l) {
          emit(AuthErrorState(message: l.message));
        },
        (r) {
          emit(AuthSuccessState(message: r));
        },
      );
    });

    on<LogInEvent>((event, emit) async {
      emit(AuthLoadingState());
      final res = await logInUseCase(LogInParams(event.logInEntity));

      res.fold(
        (l) {
          emit(AuthErrorState(message: l.message));
        },
        (r) {
          emit(AuthSuccessState(message: r));
        },
      );
    });

    on<LogOutEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        final result = await loguoutUsecase(NoParams());
        result.fold(
          (failure) => emit(UserLogoutState(
              message: "Failed to logout, please try again",
              status: AuthStatus.error)),
          (response) => emit(UserLogoutState(
              message: "Logged out successfully", status: AuthStatus.loaded)),
        );
      },
    );
  }
}
