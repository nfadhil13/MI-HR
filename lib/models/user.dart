class User {

  final int id;
  final String name;
  final String jobTitle;
  final String imageProfileURL;
  final bool isImageFromURL;

  User({
    required this.id,
    required this.name,
    required this.jobTitle,
    required this.imageProfileURL,
    this.isImageFromURL = true
  });


  static User createUserWithDefaultImage({
    required int id,
    required String name,
    required String jobTitle,
    String? imageProfileURL
  }){
    return User(
      id: id,
      name: name,
      jobTitle: jobTitle,
      imageProfileURL: imageProfileURL ?? "assets/img/profile_pic.jpg",
      isImageFromURL: imageProfileURL != null
    );
  }

}