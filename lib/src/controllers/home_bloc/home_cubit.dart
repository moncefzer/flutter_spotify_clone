import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  //todo : implment  home bloc
  // will manage fetching sections
  // each section have playlists
  // each playlist is a list of songs
  // the clicked playlist from the home page
  // will be passed to the playist_page to display
  // if clicked passed to the music player bloc to play it
}
