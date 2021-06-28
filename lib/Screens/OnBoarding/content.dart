class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent({required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Choose',
      image: 'assets/png/b.png',
      discription: "Lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem lorem ipsum "
  ),
  UnbordingContent(
      title: 'Refer',
      image: 'assets/png/bb.png',
      discription: "Refer 5 friends and join event free of cost. "
  ),
  UnbordingContent(
      title: 'Events',
      image: 'assets/png/bbb.png',
      discription: "Lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem lorem ipsum. "
  ),
];