abstract class NewsAppStates {}

class InitialState extends NewsAppStates {}

class BottomNavState extends NewsAppStates {}


class BusinessLoadingState extends NewsAppStates {}
class NewsGetBusinessSuccessState extends NewsAppStates {}
class NewsGetBusinessErrorState extends NewsAppStates {}


class ScienceLoadingState extends NewsAppStates {}
class NewsGetScienceSuccessState extends NewsAppStates {}
class NewsGetScienceErrorState extends NewsAppStates {}


class SportsLoadingState extends NewsAppStates {}
class NewsGetSportsSuccessState extends NewsAppStates {}
class NewsGetSportsErrorState extends NewsAppStates {}


class SearchLoadingState extends NewsAppStates {}
class NewsSearchSuccessState extends NewsAppStates {}
class NewsSearchErrorState extends NewsAppStates {}

class NewsDarkModeState extends NewsAppStates {}
