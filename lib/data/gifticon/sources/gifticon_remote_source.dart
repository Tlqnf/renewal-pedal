import 'package:pedal/data/api/dio_client.dart';
import 'package:pedal/data/models/gifticon/gifticon_purchase_response.dart';
import 'package:pedal/data/models/gifticon/gifticon_response.dart';
import 'package:pedal/data/models/gifticon/my_gifticon_response.dart';
import 'package:pedal/data/models/gifticon/point_transaction_response.dart';

class GifticonRemoteSource {
  final DioClient _client;

  GifticonRemoteSource(this._client);

  Future<List<GifticonResponse>> getGifticons() async {
    final response = await _client.get('/gifticons');
    final list = response.data as List<dynamic>;
    return list
        .map((e) => GifticonResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<GifticonResponse> getGifticonById(String gifticonId) async {
    final response = await _client.get('/gifticons/$gifticonId');
    return GifticonResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<GifticonPurchaseResponse> purchaseGifticon(String gifticonId) async {
    final response = await _client.post('/gifticons/$gifticonId/purchase');
    return GifticonPurchaseResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<List<MyGifticonResponse>> getMyGifticons() async {
    final response = await _client.get('/gifticons/me/purchases');
    final list = response.data as List<dynamic>;
    return list
        .map((e) => MyGifticonResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> useGifticon(String userGifticonId) async {
    await _client.post('/gifticons/me/$userGifticonId/use');
  }

  Future<List<PointTransactionResponse>> getPointTransactions() async {
    final response = await _client.get('/gifticons/me/points/transactions');
    final list = response.data as List<dynamic>;
    return list
        .map(
          (e) => PointTransactionResponse.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  Future<int> addPoints(int amount) async {
    final response = await _client.post(
      '/gifticons/me/points/add',
      data: {'amount': amount},
    );
    return (response.data as Map<String, dynamic>)['points'] as int;
  }

  Future<int> subtractPoints(int amount) async {
    final response = await _client.post(
      '/gifticons/me/points/subtract',
      data: {'amount': amount},
    );
    return (response.data as Map<String, dynamic>)['points'] as int;
  }
}
