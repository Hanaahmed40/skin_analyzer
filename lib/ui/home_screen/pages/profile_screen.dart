import 'package:event_planning/core/helpers/extensions.dart';
import 'package:event_planning/cubits/profile_cubit.dart';
import 'package:event_planning/di.dart';
import 'package:event_planning/widget/logout_bloc_listener.dart';
import 'package:event_planning/widget/profile_img_bloc_selector.dart';
//import 'package:event_planning/widget/profile_pass_field_bloc_selector.dart';
import 'package:event_planning/widget/profile_text_fields.dart';
import 'package:event_planning/widget/update_pass_button_bloc_consumer.dart';
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
          SliverPadding(
            padding: const EdgeInsets.all(24.0),
            sliver: SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 24,
                children: [
                  const ProfileImgBlocSelector(),
                  const ProfileTextFields(),
                  Row(
                    spacing: 16,
                    children: [
                      const Expanded(child: UpdateUserButtonBlocConsumer()),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            context.showAppDialog(
                              contentWidget: BlocProvider.value(
                                value: context.read<ProfileCubit>(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                 child: Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    TextFormField(
      controller: context.read<ProfileCubit>().passwordController,
      obscureText: context.watch<ProfileCubit>().state.isPassObscure,
      decoration: InputDecoration(
        labelText: 'New Password',
        suffixIcon: IconButton(
          icon: Icon(
            context.watch<ProfileCubit>().state.isPassObscure
                ? Icons.visibility_off
                : Icons.visibility,
          ),
          onPressed: () =>
              context.read<ProfileCubit>().togglePassVisibility(),
        ),
      ),
    ),
    const SizedBox(height: 16),
    const UpdatePassButtonBlocConsumer(),
  ],
),

                                ),
                              ),
                            );
                          },
                          child: Text('Update password'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
