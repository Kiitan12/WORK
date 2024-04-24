import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:volun_tek/src/features/home/application/services/task_services.dart';
import 'package:volun_tek/src/features/home/domain/model/task.dart';

// State provider for managing the task services
final taskServiceProvider = StateProvider<TaskServices>(
  (ref) => TaskServices(),
);

// Future provider for fetching trending tasks
final getTrendingTask = FutureProvider<List<Task>>((ref) {
  final task = ref.watch(taskServiceProvider);

  return task.getTasks('trendingTasks');
});

// Future provider for fetching all tasks
final getAllTask = FutureProvider<List<Task>>((ref) {
  final task = ref.watch(taskServiceProvider);

  return task.getTasks('tasks');
});

// State notifier provider for managing loading state of tasks
final loadingTaskProvider = StateNotifierProvider<TaskServices, bool>(
  (ref) => TaskServices(),
);

// State provider for storing individual task data
final taskProvider = StateProvider<Task>(
  (ref) => Task(
    title: '',
    description: '',
    imgUrl: '',
    time: '',
    location: '',
    cause: '',
    id: '',
    favorites: [],
  ),
);

// State provider for storing causes data
final causesProvider = StateProvider((ref) => []);
