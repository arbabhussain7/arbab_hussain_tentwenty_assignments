import 'package:dio_rest_api/features/movies/data/models/video_model.dart';

class VideoResponseModel {
  final int id;
  final List<VideoModel> results;
  VideoResponseModel({required this.id, required this.results});
  factory VideoResponseModel.fromJson(Map<String, dynamic> json) {
    return VideoResponseModel(
      id: json['id'] ?? 0,
      results:
          (json['results'] as List<dynamic>?)
              ?.map((video) => VideoModel.fromJson(video))
              .toList() ??
          [],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'results': results.map((video) => video.toJson()).toList(),
    };
  }
}
