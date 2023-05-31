part of 'adlist_bloc.dart';

abstract class SearchAdsEvent extends Equatable {
  const SearchAdsEvent();

  @override
  List<Object> get props => [];
}

class SearchAdsEventSearch extends SearchAdsEvent {
  final String search;
  final String priceMin;
  final String priceMax;
  final String paginate;
  final String shortBy;
  final String filterBy;
  final String category;
  final String subCategory;
  final String locationSearchValue;
  final String cityValue;
  final String countryCode;
  const SearchAdsEventSearch(this.search, this.priceMin, this.priceMax, this.paginate, this.shortBy, this.filterBy, this.category, this.subCategory, this.cityValue, this.locationSearchValue, this.countryCode);

  @override
  List<Object> get props => [search,priceMin,priceMax,paginate,shortBy,filterBy,category,subCategory, locationSearchValue, cityValue, countryCode];
}

class SearchAdsEventLoadMore extends SearchAdsEvent {
  const SearchAdsEventLoadMore();
}
