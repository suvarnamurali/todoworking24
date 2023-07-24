import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:my_app/profile/product.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class ProductRepo {
  final _auth = FirebaseAuth.instance;
  final CollectionReference productRef =
      FirebaseFirestore.instance.collection("product");
  Future<void> createProduct(String name, String description, String price,
      List<XFile> images) async {
        final uuid = Uuid();
        final date = DateTime.now();
        final pid=uuid.v4();
        List<String>? productImages=[];
        try {
          for (final element in images){
            final reference=FirebaseStorage.instance.ref().child("product_image").child(element.name);
            final file=File(element.path);
            await reference.putFile(file);
            final productImage=await reference.getDownloadURL();
            productImages.add(productImage);

          }
          await productRef.doc(pid).set({
            "product_name":name,
            "description":description,
            "price":price,
            "productid":pid,
            "productimage":productImages,
            "userid":_auth.currentUser!.uid,
          });
        } catch (e) {
          
        }

      }
}
