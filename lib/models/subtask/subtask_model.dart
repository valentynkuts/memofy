class SubtaskModel {

  String description;
  bool isDone;

  SubtaskModel({required this.description, this.isDone = false});

  void toggleDone(){
    isDone = !isDone;
  }

}