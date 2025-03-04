// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class SongModel {
  final String thumbnail_url;
  final String song_name;
  final String song_url;
  final String artist;
  final String id;
  final String hex_code;

  SongModel({
    required this.thumbnail_url,
    required this.song_name,
    required this.song_url,
    required this.artist,
    required this.id,
    required this.hex_code,
  });

  SongModel copyWith({
    String? thumbnail_url,
    String? song_name,
    String? song_url,
    String? artist,
    String? id,
    String? hex_code,
  }) {
    return SongModel(
      thumbnail_url: thumbnail_url ?? this.thumbnail_url,
      song_name: song_name ?? this.song_name,
      song_url: song_url ?? this.song_url,
      artist: artist ?? this.artist,
      id: id ?? this.id,
      hex_code: hex_code ?? this.hex_code,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'thumbnail_url': thumbnail_url,
      'song_name': song_name,
      'song_url': song_url,
      'artist': artist,
      'id': id,
      'hex_code': hex_code,
    };
  }

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      thumbnail_url: map['thumbnail_url']?.toString() ?? '',
      song_name: map['song_name']?.toString() ?? '',
      song_url: map['song_url']?.toString() ?? '',
      artist: map['artist']?.toString() ?? '',
      id: map['id']?.toString() ?? '',
      hex_code: map['hex_code']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SongModel.fromJson(String source) =>
      SongModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SongModel(thumbnail_url: $thumbnail_url, song_name: $song_name, song_url: $song_url, artist: $artist, id: $id, hex_code: $hex_code)';
  }

  @override
  bool operator ==(covariant SongModel other) {
    if (identical(this, other)) return true;

    return other.thumbnail_url == thumbnail_url &&
        other.song_name == song_name &&
        other.song_url == song_url &&
        other.artist == artist &&
        other.id == id &&
        other.hex_code == hex_code;
  }

  @override
  int get hashCode {
    return thumbnail_url.hashCode ^
        song_name.hashCode ^
        song_url.hashCode ^
        artist.hashCode ^
        id.hashCode ^
        hex_code.hashCode;
  }
}
