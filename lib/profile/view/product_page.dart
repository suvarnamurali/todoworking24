import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/profile/product_repo.dart';

class Product extends StatelessWidget {
 Product({super.key});
  TextEditingController _nameController=TextEditingController();
  TextEditingController _descriptionController=TextEditingController();
  TextEditingController _priceController=TextEditingController();
  List <XFile> ? images;
  Future <dynamic> getImage() async{
    final imagePicker = ImagePicker();
     images=await imagePicker.pickMultiImage();
   
  }

final _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.blueGrey,
        title: Text("Profile",style: TextStyle(fontSize: 20),),
      ),
     body: Form(
      key: _formKey,
       child: Column(
     
         children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .03,
          ),
           Padding(padding: EdgeInsets.all(8.0),
           child: TextFormField(
            controller: _nameController,
            validator: (value) {
              if(value!.isEmpty){
                return "PLEASE FILL THIS FIELD";
              }
            },
            decoration: InputDecoration(
              labelText: "NAME"
            ),
           ) ,
           ),
            SizedBox(
            height: MediaQuery.of(context).size.height * .01,
          ),
           Padding(padding: EdgeInsets.all(8.0),
           child: TextFormField(
            controller: _descriptionController,
            validator: (value) {
              if(value!.isEmpty){
                return "PLEASE FILL THIS FIELD";
              }
            },
            decoration: InputDecoration(
              labelText: "DESCRIPTION"
            ),
           ) ,
           ),
            SizedBox(
            height: MediaQuery.of(context).size.height * .01,
          ),
           Padding(padding: EdgeInsets.all(8.0),
           child: TextFormField(
            controller: _priceController,
            validator: (value) {
              if(value!.isEmpty){
                return "PLEASE FILL THIS FIELD";
              }
            },
            decoration: InputDecoration(
              labelText: "PRICE"
            ),
           ) ,
           ),
            SizedBox(
            height: MediaQuery.of(context).size.height * .01,
          ),
     
          TextButton(onPressed: () {

            getImage();
            
          }, child: Text("IMAGE")),
     
           SizedBox(
            height: MediaQuery.of(context).size.height * .02,
          ),
          ElevatedButton(onPressed: () {
            if(_formKey.currentState!.validate()){
              ProductRepo().createProduct(
                _nameController.text,
                 _descriptionController.text, 
                 _priceController.text,
                 images!);
                 _nameController.clear();
                 _descriptionController.clear();
                 _priceController.clear();
            }
            
          }, child: Text("SUBMIT")),
     
     
         ],
       ),
     ),
    );
  }
}