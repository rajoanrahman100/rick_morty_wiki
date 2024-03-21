import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ricky_morty_wiki/core/constants/api_endpoints.dart';
import 'package:ricky_morty_wiki/core/constants/graphql_queries.dart';
import 'package:ricky_morty_wiki/features/location/model/location_model.dart';

class LocationRepository {
  Future<LocationModel> getAllLocations() async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.baseGraphql),
      headers: ApiEndpoints.headers,
      body: jsonEncode({
        "query":GraphQLQueries.getAllLocationsQuery(1),
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      LocationModel locationModel = LocationModel.fromJson(result);
      log(response.body);
      return locationModel;
    } else {
      throw Exception('Failed to load characters ${response.statusCode}');
    }
  }
}
