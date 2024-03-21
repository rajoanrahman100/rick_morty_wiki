import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ricky_morty_wiki/core/constants/api_endpoints.dart';
import 'package:ricky_morty_wiki/core/constants/graphql_queries.dart';
import 'package:ricky_morty_wiki/features/cast/model/character_model.dart';

class CharacterRepository {
  Future<CharacterModel> getAllCharacters(page) async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.baseGraphql),
      headers: ApiEndpoints.headers,
      body: jsonEncode({
        "query":GraphQLQueries.getAllCharactersQuery(page),
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      CharacterModel characterModel = CharacterModel.fromJson(result);
      log(response.body);
      return characterModel;
    } else {
      throw Exception('Failed to load characters ${response.statusCode}');
    }
  }
}
