
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:qubitarts/core/helpers/extensions.dart';


import '../../../../core/routes/routes.dart';
import '../../../../core/sharedWidgets/show_dialog_error.dart';
import '../../../../core/theming/colors.dart';

import '../../logic/login_cubit.dart';

class SignInStateUi extends StatelessWidget {
  const SignInStateUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginLoading) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => WillPopScope(
              onWillPop: () => Future.value(false),
              child: const Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.yellow,
                ),
              ),
            ),
          );
        }
        // Handle LoginSuccess state
        else if (state is LoginSuccess) {
          log('object');
         // NavBarCubit.get(context).changeIndex(0);

          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
          context.pushNamedAndRemoveUntil(Routes.navBarScreen, predicate: (Route<dynamic> route) { return false;});

        }
        // Handle LoginError and show the dialog here
        if (state is LoginError) {
          log('LoginError');
          Navigator.of(context).pop();

          ShowDialogError.showErrorDialog(
              context,
              "attention", // Pass the "attention" title here
              state.error
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
//test
//test
//test
