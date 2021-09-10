import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_app/models/department.dart';
import 'package:movie_app/provider/department_provider.dart';
import 'package:movie_app/repository/employee_repository.dart';
import 'package:movie_app/widgets/img_picker.dart';
import 'package:movie_app/widgets/white_button.dart';
import 'package:provider/provider.dart';

class AddEditEmployeeForm extends StatefulWidget {
  const AddEditEmployeeForm({Key? key}) : super(key: key);

  @override
  _AddEditEmployeeFormState createState() => _AddEditEmployeeFormState();
}

class _AddEditEmployeeFormState extends State<AddEditEmployeeForm> {
  GlobalKey buttonKey = GlobalKey();

  var _name = "";
  var _email = "";
  int? _departmentId;

  var _isUploading = false;

  final _emailFocus = FocusNode();
  final _departmentFocus = FocusNode();
  final _profilePictureController = TextEditingController();

  final _form = GlobalKey<FormState>();
  XFile? _selectedImage;

  final employeeRepository = EmployeeRepository();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailFocus.dispose();
    _departmentFocus.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(0, 255, 255, 255), width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
        ),
        labelStyle: TextStyle(color: Color.fromARGB(255, 146, 144, 148)),
        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10));
  }

  void _openImagePicker() async {
    showBottomSheet(
        context: context,
        builder: (ctx) => ImgPicker((xFile) {
              if (xFile != null) {
                Navigator.of(context).pop();
                _profilePictureController.text = xFile.name.split("/").last;
                _selectedImage = xFile;
              }
            }));
  }

  void _save() async {
    final currentState = _form.currentState;
    print(currentState);
    if (currentState != null && currentState.validate() && _selectedImage != null && _departmentId != null) {
      currentState.save();
      final result = await employeeRepository.addNewEmployee(_name, _email, _selectedImage!, _departmentId!);
      setState(() {
        _isUploading = true;
      });
      result.whenWithResult(
        success: (value) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.data)));
          Navigator.of(context).pop(true);
        },
        error: (value) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.message)));
        }
      );

    }
  }

  Widget _buildTextFieldLabel(String labelText) {
    return Container(
        margin: EdgeInsets.only(left: 6),
        width: double.infinity,
        child: Text(labelText,
            style: TextStyle(color: Colors.black.withOpacity(0.6))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                Color.fromARGB(255, 241, 241, 242),
                Color.fromARGB(255, 241, 241, 242).withOpacity(0.7),
                Color.fromARGB(255, 241, 241, 242).withOpacity(0.4)
              ],
              stops: [
                0.0,
                1,
                1
              ]),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            )
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      padding: EdgeInsets.only(left: 32, right: 32, top: 32, bottom: 24),
      child: Form(
        key: _form,
        child: Column(
          children: [
            Text("Add Employee  ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            _buildTextFieldLabel("Name"),
            SizedBox(height: 5),
            TextFormField(
              style: TextStyle(color: Colors.black, fontSize: 14),
              cursorColor: Colors.black,
              decoration: _inputDecoration(),
              maxLines: 1,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_emailFocus);
              },
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "Name has to be filled";
                return null;
              },
              onSaved: (value) {
                _name = value ?? _name;
              },
            ),
            SizedBox(height: 20),
            _buildTextFieldLabel("Email"),
            SizedBox(height: 5),
            TextFormField(
              focusNode: _emailFocus,
              maxLines: 1,
              style: TextStyle(color: Colors.black, fontSize: 14),
              cursorColor: Colors.black,
              textInputAction: TextInputAction.next,
              decoration: _inputDecoration(),
              onFieldSubmitted: (_) {
                _departmentFocus.requestFocus();
              },
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "Email has to be filled";
                if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) return "Invalid email";
                return null;
              },
              onSaved: (value) {
                _email = value ?? _email;
              },
            ),
            SizedBox(height: 20),
            _buildTextFieldLabel("Department"),
            SizedBox(height: 5),
            Consumer<DepartmentProvider>(
                builder: (_, item, builder) => DropdownButtonFormField<int>(
                      onSaved: (value) {
                        // _todo = _todo.copyAndReplace(newTodotype: value);
                      },
                      focusNode: _departmentFocus,
                      value: _departmentId,
                      onChanged: (value) {
                        setState(() {
                          _departmentId = value;
                        });
                      },
                      validator: (value) {
                        if (value == null)
                          return "You have to choose the todo type";
                        return null;
                      },
                      iconEnabledColor: Colors.white,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      dropdownColor: Theme.of(context).backgroundColor,
                      items: <DropdownMenuItem<int>>[
                        ...item.departmentList
                            .map((e) => DropdownMenuItem<int>(
                                child: Text(e.name), value: e.id))
                            .toList()
                      ],
                      decoration: _inputDecoration(),
                    )),
            SizedBox(height: 20),
            _buildTextFieldLabel("Profile Picture"),
            SizedBox(height: 5),
            Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                            controller: _profilePictureController,
                            maxLines: 1,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            cursorColor: Colors.black,
                            textInputAction: TextInputAction.next,
                            decoration: _inputDecoration(),
                            onFieldSubmitted: (_) {},
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return "Profile image should not be empty";
                              return null;
                            })),
                    SizedBox(width: 10),
                    Icon(Icons.camera_alt)
                  ],
                ),
                Positioned.fill(
                  child: GestureDetector(
                    child: Container(
                      color: Colors.white.withOpacity(0),
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    onTap: () {
                      _openImagePicker();
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: 50),
            MainButton(onTap: () {
              _save();
            })
          ],
        ),
      ),
    );
  }
}
