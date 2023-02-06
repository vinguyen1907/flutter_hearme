Function emailValidate = (value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  } else if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return 'Please enter a valid email';
  }
  return null;
};

Function passwordValidate = (value) {
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
  if (value == null || value.isEmpty) {
    return 'Please enter password';
  } else if (value.length < 6) {
    return 'Password must be at least 6 characters';
  } else if (!regex.hasMatch(value)) {
    return 'Please enter a valid password(Example: Abc@123)';
  }
  return null;
};
