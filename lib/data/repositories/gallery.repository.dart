import '../../core/apis/api.dart';
import '../../core/consts/const.dart';
import '../models/model.dart';

class GalleryRepository {
  const GalleryRepository();

  Future<(List<PixabayImageModel> images, int total)> search({String query = '', int page = 1}) async {
    final json = await ApiCall.instance.get(
      UrlApi.images,
      queryParameters: <String, dynamic>{
        'image_type': CPixabay.imageType,
        'page': page,
        'per_page': CPixabay.perPage,
        if (query.isNotEmpty) 'q': query,
      },
    );

    return PixabayImageModel.listFromJson(json);
  }
}
