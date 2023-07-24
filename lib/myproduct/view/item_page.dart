import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/myproduct/widgets/product_card.dart';
import 'package:my_app/profile/view/product_page.dart';

class MyProducts extends StatelessWidget {
  MyProducts({super.key});
  final _itemRef = FirebaseFirestore.instance.collection('product');
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _itemRef.where('userid',isEqualTo: _auth.currentUser!.uid).snapshots(),
        builder: ( context, snapshot) {
          if(snapshot.hasData){
            final products=snapshot.data!.docs;
            print('$products ************************************************');
          
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 20,childAspectRatio: 0.7),
          itemCount:products.length,
          itemBuilder: (BuildContext context,int index) {
            return ProductCard(product: products[index]);
            
          },);
        }else{
          return 
          Center(child: CircularProgressIndicator());
        }}
      ),
    );
  }
}