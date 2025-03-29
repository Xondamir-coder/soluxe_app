import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/helpers/local_storage_helper.dart';
import 'package:soluxe/models/filters.dart';

Future<Filters> fetchFilters(String category) async {
  try {
    final token = (await LocalStorageHelper.getAccountData()).token;
    final body = await FetchHelper.fetch(
      url: 'filters',
      token: token,
      queryParams: {
        'category': category,
      },
    );
    return Filters.fromMap(body);
  } catch (e) {
    rethrow;
  }
}
