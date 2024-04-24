// Import spackages and files
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:volun_tek/src/features/home/presentation/widget/refactored/task_card.dart';
import 'package:volun_tek/src/routing/routes.dart';

// Provider for managing tasks
import '../provider/task_provider.dart';

// Widget for displaying tasks filtered by cause
class SearchByCauseView extends ConsumerWidget {
  // Constructor
  const SearchByCauseView({super.key, required this.causes, this.title});

  // List of causes and title
  final List causes;
  final String? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // App bar with title
      appBar: AppBar(
        title: Text(title ?? causes[0].cause),
      ),
      // Body containing task cards
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView.separated(
          itemCount: causes.length,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            // Task card for each task
            return TaskCard(
              task: causes[index],
              onTap: () {
                // Set selected task using provider
                ref.read(taskProvider.notifier).state = causes[index];
                // Navigate to task details page
                Navigator.pushNamed(context, opportunityView);
              },
            );
          },
        ),
      ),
    );
  }
}
