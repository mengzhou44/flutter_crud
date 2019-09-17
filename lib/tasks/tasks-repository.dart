import 'package:graphql_flutter/graphql_flutter.dart';
import './tasks-model.dart';

HttpLink httpLink = HttpLink(uri: "http://localhost:3000/graphql");

GraphQLClient client = GraphQLClient(
    link: httpLink,
    cache: OptimisticCache(
      dataIdFromObject: typenameDataIdFromObject,
    ));

class TasksRepository {
  Future<TasksModel> getTasks(int userId) async {
    final QueryResult data = await client.query(QueryOptions(document: '''
                query {
                      tasks(userId: $userId) {
                        id,
                        completed,
                        description
                      }
                    }
                '''));
 
     return TasksModel.fromJson(data.data['tasks'].cast<Map<String, dynamic>>());
  }
}
