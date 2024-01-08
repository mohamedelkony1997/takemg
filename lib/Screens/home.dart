// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takemg/bussineslogic/cubit/login_cubit.dart';
import 'package:takemg/models/login.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: BlocBuilder<DataCubit, List<DataModel>>(
        builder: (context, storedData) {
          return ListView.builder(
            itemCount: storedData.length,
            itemBuilder: (context, index) {
              final DataModel item = storedData[index];
              return ListTile(
                title: Text(item.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.description),
                    Text(item.email),
                  ],
                ),
                leading: Image.network(
                  item.imgLink,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset("assets/download.png");
                  },
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _showEditDialog(context, item);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _showDeleteConfirmationDialog(context, item);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         _showAddItemDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, DataModel item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this item?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _deleteItem(context, item);
                Navigator.of(context).pop();
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(BuildContext context, DataModel item) {
    final dataCubit = context.read<DataCubit>();
    dataCubit.deleteItem(item.email, item.id);
  }

  void _showEditDialog(BuildContext context, DataModel item) {
    TextEditingController titleController = TextEditingController(text: item.title);
    TextEditingController descriptionController = TextEditingController(text: item.description);
    TextEditingController emailController = TextEditingController(text: item.email);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Item"),
          content: ListView(
           
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _editItem(context, item, titleController.text, descriptionController.text, emailController.text);
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _editItem(BuildContext context, DataModel item, String newTitle, String newDescription, String newEmail) {
    final dataCubit = context.read<DataCubit>();
    dataCubit.editItem(item.email, item.id, newTitle, newDescription, newEmail);
  }
  void _showAddItemDialog(BuildContext context) {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController imgLinkController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Add Item"),
        content: ListView(
     
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            
            TextFormField(
              controller: imgLinkController,
              decoration: InputDecoration(labelText: 'Image Link'),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              _addItem(context,  titleController.text, descriptionController.text, imgLinkController.text,emailController.text,);
              Navigator.of(context).pop();
            },
            child: Text("Add"),
          ),
        ],
      );
    },
  );
}

void _addItem(BuildContext context, String title, String description, String imgLink,String email,) {
  final dataCubit = context.read<DataCubit>();
  dataCubit.addItem(title, description, imgLink, email);
}

}
