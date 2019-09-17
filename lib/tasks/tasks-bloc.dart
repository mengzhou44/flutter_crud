import 'package:rxdart/rxdart.dart';
import 'tasks-model.dart';
import 'tasks-repository.dart';

class TasksBloc {
  
  final _subject = PublishSubject<TasksModel>();

  Observable<TasksModel> get allTasks => _subject.stream;

  getTasks() async {
    TasksModel tasks = await TasksRepository().getTasks(1);
    _subject.sink.add(tasks);
  }

  dispose() {
    _subject.close();
  }
}

final bloc = TasksBloc();


