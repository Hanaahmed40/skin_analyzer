import 'package:event_planning/cubits/profile_cubit.dart';
import 'package:event_planning/di.dart';
import 'package:event_planning/widget/logout_bloc_listener.dart';
import 'package:event_planning/widget/profile_img_bloc_selector.dart';
import 'package:event_planning/widget/profile_text_fields.dart';
import 'package:event_planning/widget/update_user_button_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => getIt.get<ProfileCubit>(),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            backgroundColor: Colors.blue,
            title: const Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: const [LogoutBlocListener()],
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 24,
              children: const [
                ProfileImgBlocSelector(),
                ProfileTextFields(),
                SizedBox(height: 16),
                UpdateUserButtonBlocConsumer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
