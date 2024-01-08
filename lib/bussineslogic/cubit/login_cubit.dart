import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takemg/models/login.dart';
import 'package:takemg/repositery/Auth/loginrepositery.dart';

class DataCubit extends Cubit<List<DataModel>> {
  final DataRepository repository = DataRepository();

  DataCubit() : super([]);

  Future<void> fetchData(String email) async {
    try {
      final data = await repository.fetchData(email);
      emit(data);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteItem(String email, int id) async {
    try {
      await repository.deleteItem(email, id);

      fetchData(email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> editItem(String email, int id, String title, String description,
      String imgLink) async {
    try {
      await repository.editItem(email, id, title, description, imgLink);

      fetchData(email);
    } catch (e) {
      print(e.toString());
    }
  }
Future<void> addItem(String title, String description, String imgLink, String email) async {
    try {
      await repository.addItem(title, description, imgLink, email);

      fetchData(email);
    } catch (e) {
      print(e.toString());
    }
  }
}
