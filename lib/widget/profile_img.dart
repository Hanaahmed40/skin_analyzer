import 'package:event_planning/core/helpers/extensions.dart';
import 'package:event_planning/widget/custom_cached_network_img.dart';
import 'package:flutter/material.dart';

import '../core/utils/app_utils.dart';

class ProfileImg extends StatelessWidget {
  const ProfileImg({super.key});

  @override
  Widget build(BuildContext context) {
    final avatarUrl = currentUser!.avatarUrl;
    return avatarUrl != null
        ? CustomCachedNetworkImg(
            imageUrl: avatarUrl,
            imageBuilder: (_, img) => CircleAvatar(
              radius: 120,
              backgroundColor: Colors.blue,
              backgroundImage: img,
            ),
          )
        : CircleAvatar(
            radius: 120,
            backgroundColor: Colors.blue,
            child: Text(
              currentUser?.email?.capitalizeFirst() ?? 'A',
              style: TextStyle(color: Colors.white),
            ),
          );
  }
}
