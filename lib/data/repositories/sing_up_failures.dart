

class SignUpWithEmailAndPasswordFailure {
  final String message;

  const SignUpWithEmailAndPasswordFailure([this.message = "An unkonwn error occured."]);

  factory SignUpWithEmailAndPasswordFailure.code(String code){
    switch(code){
      case 'weak-password': return const SignUpWithEmailAndPasswordFailure("Please Enter a Strong Password.");
      case 'invalid-email': return const SignUpWithEmailAndPasswordFailure("Email is not valid or badly formated.");
      case 'email-already-in-use': return const SignUpWithEmailAndPasswordFailure("An account already exists for this email.");
      case 'operation-not-allowed': return const SignUpWithEmailAndPasswordFailure("Operation not allowed. Please Contact Support team.");
      case 'user-disabled': return const SignUpWithEmailAndPasswordFailure("This user has been disabled. Please contact support team for help.");
      default: return const SignUpWithEmailAndPasswordFailure();
    }
  }

}