import 'dart:convert';
import 'dart:developer';

import 'package:ricky_morty_wiki/core/constants/api_endpoints.dart';
import 'package:ricky_morty_wiki/core/constants/graphql_queries.dart';
import 'package:ricky_morty_wiki/features/episodes/model/episode_model.dart';
import 'package:http/http.dart' as http;

class EpisodeRepository {
  Future<EpisodeModel> getEpisodeList() async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.baseGraphql),
      headers: ApiEndpoints.headers,
      body: jsonEncode({
        "query": GraphQLQueries.getEpisodeList(),
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      EpisodeModel episodeModel = EpisodeModel.fromJson(result);
      log(response.body);
      return episodeModel;
    } else {
      throw Exception('Failed to load characters ${response.statusCode}');
    }
  }

}