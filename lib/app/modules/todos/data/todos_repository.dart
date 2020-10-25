import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

import '../../../database/i_database_connection.dart';
import '../../../entities/todo.dart';
import '../../../exceptions/database_error_exception.dart';
import '../view_models/todo_input_model.dart';
import 'i_todos_repository.dart';

@LazySingleton(as: ITodosRepository)
class TodosRepository implements ITodosRepository {
  TodosRepository(this._connection);
  final IDatabaseConnection _connection;

  @override
  Future<List<Todo>> getTodosByUserId(String userId) async {
    final MySqlConnection conn = await _connection.openConnection();
    try {
      final Results result = await conn.query("""
        SELECT * 
        FROM todos
        WHERE users_id = ?
        ORDER BY dueDate, description
      """, [userId]);
      if (result.isEmpty) {
        return [];
      } else {
        final List<Todo> auxList = [];
        for (Row row in result) {
          final Map<String, dynamic> fields = row.fields;
          final Todo auxTodo = Todo(
            id: fields["id"] as String,
            description: (fields["description"] as Blob).toString(),
            dueDate: fields["dueDate"] as String,
            completed: fields["completed"] as int == 1,
          );
          auxList.add(auxTodo);
        }
        return auxList;
      }
    } catch (e) {
      print(e);
      throw DatabaseErrorException("Não foi possível obter a lista de todos");
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<void> newTodo(TodoInputModel todoInputModel) async {
    final MySqlConnection conn = await _connection.openConnection();
    try {
      await conn.query("""
        INSERT INTO todos VALUES(?, ?, ?, ?, ?)
      """, [
        todoInputModel.id,
        todoInputModel.description,
        todoInputModel.dueDate,
        todoInputModel.completed,
        todoInputModel.userId,
      ]);
    } catch (e) {
      throw DatabaseErrorException("Erro ao inserir Todo");
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<void> deleteTodo(String todoId) async {
    final MySqlConnection conn = await _connection.openConnection();
    try {
      await conn.query("""
        DELETE FROM todos
        WHERE id = ?
      """, [todoId]);
    } catch (e) {
      throw DatabaseErrorException("Falha ao excluir todo");
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<void> updateTodo(String todoId, TodoInputModel todoInputModel) async {
    final MySqlConnection conn = await _connection.openConnection();
    try {
      final Results result = await conn.query("""
        UPDATE todos
        SET description = ?, dueDate = ?, completed = ?
        WHERE id = ? and users_id = ?
      """, [
        todoInputModel.description,
        todoInputModel.dueDate,
        todoInputModel.completed,
        todoId,
        todoInputModel.userId,
      ]);
      if (result.isNotEmpty) {
        final Map<String, dynamic> fields = result.first.fields;
        print(fields);
      }
    } catch (e) {
      print(e);
      throw DatabaseErrorException("Não foi possível atualizar o todo");
    }
  }
}
