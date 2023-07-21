class SemModel {
  final String? label;
  bool? isSelected;

  SemModel({this.label, this.isSelected});
}

final List<SemModel> semList = [
  SemModel(label: '5 SEM', isSelected: false),
  SemModel(label: '10 SEM', isSelected: false),
  SemModel(label: '15 SEM', isSelected: false),
  SemModel(label: '20 SEM', isSelected: false),
];
