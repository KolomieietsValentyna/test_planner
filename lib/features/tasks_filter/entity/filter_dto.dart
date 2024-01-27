class FilterDto {
  List<String> categories;
  List<String> status;

  FilterDto({this.categories = const [], this.status = const []});
}
