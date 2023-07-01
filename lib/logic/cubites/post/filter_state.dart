part of 'filter_cubit.dart';

abstract class FilterState {}

class FilterInitial extends FilterState {}

class FilterProgress extends FilterState {}

class NoPostYet extends FilterState {}

class LocationsFilteredSuccessfully extends FilterState {}

class RatingsFilteredSuccessfully extends FilterState {}

class CategoriesFilteredSuccessfully extends FilterState {}

class FilterdWithOldestPosts extends FilterState {}

class FilterFailed extends FilterState {
  String message;
  FilterFailed({required this.message});
}
