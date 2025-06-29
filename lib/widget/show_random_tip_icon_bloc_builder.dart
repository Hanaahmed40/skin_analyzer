import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/main_cubit.dart';
import '../cubits/main_state.dart';
import '../utils/app_colors.dart';

class ShowRandomTipIconBlocBuilder extends StatelessWidget {
  const ShowRandomTipIconBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      buildWhen: (_, current) =>
          current.status == MainStateStatus.fetchRandomTipLoading ||
          current.status == MainStateStatus.fetchRandomTipSuccess ||
          current.status == MainStateStatus.fetchRandomTipFailure,
      builder: (context, state) {
        switch (state.status) {
          case MainStateStatus.fetchRandomTipLoading:
            return FittedBox(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          default:
            return Icon(
              Icons.chat_bubble_outlined,
              size: 30,
              color: AppColors.whiteColor,
            );
        }
      },
    );
  }
}
