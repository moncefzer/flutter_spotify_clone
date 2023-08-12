import 'song.dart';

class Playlist {
  final String id;
  final String title;
  final String coverUrl;
  final List<Song> songs;

  const Playlist({
    required this.id,
    required this.coverUrl,
    required this.title,
    required this.songs,
  });

  static var playlists = [
    Playlist(
      id: '0',
      coverUrl: Song.songs[0].coverUrl,
      title: 'Your liked',
      songs: Song.songs,
    ),
    Playlist(
        id: '1',
        coverUrl: Song.songs[1].coverUrl,
        title: 'Your liked',
        songs: Song.songs),
    Playlist(
      id: '2',
      coverUrl: Song.songs[2].coverUrl,
      title: 'Your liked',
      songs: Song.songs,
    ),
    Playlist(
      id: '3',
      coverUrl: Song.songs[3].coverUrl,
      title: 'Your liked',
      songs: Song.songs,
    ),
    Playlist(
      id: '4',
      coverUrl: Song.songs[4].coverUrl,
      title: 'Your liked',
      songs: Song.songs,
    ),
    Playlist(
        id: '5',
        coverUrl: Song.songs[1].coverUrl,
        title: 'Your liked',
        songs: Song.songs),
    Playlist(
      id: '6',
      coverUrl: Song.songs[0].coverUrl,
      title: 'Your liked',
      songs: Song.songs,
    ),
    Playlist(
        id: '7',
        coverUrl: Song.songs[1].coverUrl,
        title: 'Your liked',
        songs: Song.songs),
    Playlist(
      id: '8',
      coverUrl: Song.songs[0].coverUrl,
      title: 'Your liked',
      songs: Song.songs,
    ),
  ];
}
