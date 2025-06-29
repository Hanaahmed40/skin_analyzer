import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/main_cubit.dart';
import '../cubits/main_state.dart';
import '../models/tip.dart';

class RandomTipContentBlocSelector extends StatelessWidget {
  const RandomTipContentBlocSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MainCubit, MainState, Tip?>(
      selector: (state) => state.tip,
      builder: (context, tip) => tip == null
          ? FittedBox(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : Text(
              tip.tip,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
    );
  }
}
