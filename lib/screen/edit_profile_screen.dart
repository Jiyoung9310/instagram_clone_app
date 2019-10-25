import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_app/models/user_model.dart';
import 'package:instagram_clone_app/services/database_service.dart';
import 'package:instagram_clone_app/services/storage_service.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
  EditProfileScreen({this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final _formKey = GlobalKey<FormState>();
  File _profileImage;
  String _name = ' ';
  String _bio = ' ';
  bool _isLoading = false;

  _submit() async {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();

      setState(() {
        _isLoading = true;
      });
      // Update user in DB
      String _profileImageUrl = '';
      if(_profileImageUrl == null) {
        _profileImageUrl = widget.user.profileImageUrl;
      } else {
        _profileImageUrl = await StorageService.uploadUserProfileImage(widget.user.profileImageUrl, _profileImage);
      }
      User user = User(id: widget.user.id, name: _name, bio: _bio, profileImageUrl: _profileImageUrl);
      // DB update
      DatabaseService.updateUser(user);
      Navigator.pop(context);
    }
  }

  _handleImageFromGallery() async{
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(imageFile != null) {
      setState(() {
        _profileImage = imageFile;
      });
    }
  }

  _displayPhotoImage() {
    //no new image
    if(_profileImage == null) {
      //no exist profile image
      if(widget.user.profileImageUrl.isEmpty) {
        //display placeholer
        return AssetImage('assets/images/user_placeholder.jpg');
      } else {
        //user profile image exists
        return CachedNetworkImageProvider(widget.user.profileImageUrl);
      }
    }else {
      //new profile image
      return FileImage(_profileImage);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _name = widget.user.name;
    _bio = widget.user.bio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Edit Profile', style: TextStyle(color: Colors.black),),
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          children: <Widget>[
            _isLoading ? LinearProgressIndicator(
              backgroundColor: Colors.blue[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ) : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 60.0,
                      backgroundColor: Colors.grey,
                      backgroundImage: _displayPhotoImage(),
                    ),
                    FlatButton(
                        onPressed: () => _handleImageFromGallery(),
                        child: Text('Change Profile Image', style: TextStyle(color: Theme.of(context).accentColor, fontSize: 16.0),)
                    ),
                    TextFormField(
                      initialValue: _name,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        icon: Icon(Icons.person, size: 30.0,), labelText: 'Name',),
                      validator: (input) => input.trim().length < 1 ? ' Please enter a valid name' : null,
                      onSaved: (input) => _name = input,
                    ),
                    TextFormField(
                      initialValue: _bio,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        icon: Icon(Icons.book, size: 30.0,), labelText: 'Bio',),
                      validator: (input) => input.trim().length > 150 ? ' Please enter a bio less than 150 characters' : null,
                      onSaved: (input) => _bio = input,
                    ),
                    Container(
                        margin: EdgeInsets.all(40.0),
                        height: 40.0,
                        width: 250.0,
                        child: FlatButton(
                          onPressed: _submit,
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: Text('Save Profile', style: TextStyle(fontSize: 18.0),),
                        )
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
