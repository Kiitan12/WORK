import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:volun_tek/src/features/home/presentation/widget/refactored/task_card.dart';

import '../../../../constants/app_style.dart';
import '../../../../constants/colors.dart';
import '../provider/user_provider.dart';

class Favourite extends StatelessWidget {
  const Favourite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBackgroundColor,
        title: Text(
          'Favourite',
          style: AppStyle.kHeading1.copyWith(
            color: kGray16,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Consumer(
          builder: (context, ref, child) {
            final favorites = ref.watch(getFavoritesProvider);
            return favorites.when(
              data: (data) {
                if (data.isEmpty) {
                  return const Center(
                    child: Text('No Favourite Task'),
                  );
                }
                return ListView.separated(
                  itemCount: data.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return TaskCard(task: data[index]);
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => Center(
                child: Text('Error: $error'),
              ),
            );
          },
        ),
      ),
    );
  }
}
