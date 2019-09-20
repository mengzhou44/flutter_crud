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
    print('getAllTasks');
    print(this.tasks.length);
    _subject.sink.add(tasks);
  }

  addTask(Task task) async {
    try{
       await _repository.addTask(task);
    } catch (exception) {
      throw Exception('Failed to  add task');
    }  
  }

  updateTask(Task task) async {
     try{
       await _repository.updateTask(task);
    } catch (exception) {
      throw Exception('Failed to save task');
    }  
  
  }

  dispose() {
    _subject.close();
  }
}

final bloc = TasksBloc();
