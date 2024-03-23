import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ricky_morty_wiki/core/constants/api_endpoints.dart';
import 'package:ricky_morty_wiki/core/constants/graphql_queries.dart';
import 'package:ricky_morty_wiki/features/cast_details/model/cast_details_model.dart';

class CastDetailsRepository {
  Future<CastDetailsModel> getCastDetails({int? id}) async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.baseGraphql),
      headers: ApiEndpoints.headers,
      body: jsonEncode({
        "query": GraphQLQueries.getCastDetailsQuery(id: id),
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      CastDetailsModel castDetailsModel = CastDetailsModel.fromJson(result);
      log(response.body);
      return castDetailsModel;
    } else {
      throw Exception('Failed to load characters ${response.statusCode}');
    }
  }
}
