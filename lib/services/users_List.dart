import 'package:admin_panel/database/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.transparent,
      title: Text('Users List',style: TextStyle(color:Colors.black),),
      centerTitle: true,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.list,color:Colors.black),
        )
      ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _auth.users,
        builder: (context, snapshot) {
          if(snapshot.hasData){
          var data = snapshot.data;
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: data.documents.length,
            itemBuilder: (context,int index ) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(data.documents[index]['profileImage'] ),
                ),
                title: Text(data.documents[index]['username']),
                subtitle:Text(data.documents[index]['email']) ,
                trailing: Icon(Icons.edit),
              );
            }

          );
          }else{
            return Text('No users yet');
          }
        }
      ),
    );
  }
}