import 'package:companionapp_mh/models/udata.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:companionapp_mh/screens/home/udata_tile.dart';

class UdataList extends StatefulWidget {
  const UdataList({super.key});

  @override
  State<UdataList> createState() => _UdataListState();
}

class _UdataListState extends State<UdataList> {
  @override
  Widget build(BuildContext context) {
    final udata = Provider.of<List<Udata>>(context);
    //print(udata.docs);
    if(udata!=null) {
      return ListView.builder(
          itemCount: udata.length,
          itemBuilder: (context,index){
            return UdataTile(udata:udata[index]);
          },
      );
    }
    else{
      return CircularProgressIndicator();
    }
  }
}
