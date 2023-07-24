import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  ProductCard({Key? key, required this.product}) : super(key: key);
  final QueryDocumentSnapshot<Map<String, dynamic>> product;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: InkWell(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Center(child: Image.network(
                  product['productimage'][0].toString(),
                  width: 50,
                  height: 50,
                )),
                Text(product['product_name'].toString()),
                Text(product['description'].toString()),
                Row(
                  children: [
                    Icon(Icons.currency_rupee,size: 12,),
                    Text("${product['price']}/-",style: TextStyle(
                      fontWeight:FontWeight.bold,fontSize: 15,
                    ),),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
