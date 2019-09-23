import 'package:rxdart/rxdart.dart';
import 'tasks-model.dart';
import 'tasks-repository.dart';

class TasksBloc {
  List<Task> tasks = List<Task>();
  BehaviorSubject<List<Task>> _subject;

  TasksBloc() {
    _subject = new BehaviorSubject<List<Task>>.seeded(this.tasks);
  }

  final _repository = TasksRepository();

  Observable<List<Task>> get allTasks => _subject.stream;

  getAllTasks() async {
    this.tasks = await _repository.getAllTasks();
    _subject.sink.add(tasks);
  }

  addTask(Task task) async {
     await _repository.addTask(task); 
  }

  updateTask(Task task) async {
    await _repository.updateTask(task);
  }


   deleteTask(int id) async {
       await _repository.deleteTask(id);
  }


  dispose() {
    _subject.close();
  }
}

final bloc = TasksBloc();
