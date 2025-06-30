import 'package:event_planning/cubits/profile_cubit.dart';
import 'package:event_planning/di.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => getIt.get<ProfileCubit>(),
      child: Center(
        child: Text('Profile screen'),
      ),
    );
  }
}
