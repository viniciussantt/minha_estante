// Representa o estado da tela sing_up.

abstract class SignUpState {}

class SignUpInitialState extends SignUpState{}

class SignUpLoadingState extends SignUpState{}

class SignUpSuccessState extends SignUpState{}

class SignUpErrorState extends SignUpState{}