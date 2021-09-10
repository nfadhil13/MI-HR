import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_app/widgets/white_button.dart';

class ImgPicker extends StatelessWidget {

  Function(XFile?) onDone;
  final picker = ImagePicker();

  ImgPicker(this.onDone);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            )
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))
      ),
      padding: EdgeInsets.all(8).copyWith(bottom: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () async {
                XFile? image = await picker.pickImage(source: ImageSource.gallery);
                onDone(image);
              },
              child: ListTile(
                leading: Icon(Icons.folder, color: Colors.white),
                title: Text("Gallery", style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () async{
                XFile? image = await picker.pickImage(source: ImageSource.camera);
                onDone(image);
              },
              child: ListTile(
                leading: Icon(Icons.camera_alt, color:  Colors.white),
                title: Text("Camera", style: TextStyle(color: Colors.white)),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("Cancel", style: TextStyle(color: Theme.of(context).primaryColor),),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.white
                )
            )
          ],
        ),
      ),
    );
  }
}
