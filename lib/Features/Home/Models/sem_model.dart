class SemModel {
  final int? label;
  bool? isSelected;

  SemModel({this.label, this.isSelected});
}

final List<SemModel> semList = [
  SemModel(
    label: 5,
  ),
  SemModel(
    label: 10,
  ),
  SemModel(
    label: 15,
  ),
  SemModel(label: 20),
];
