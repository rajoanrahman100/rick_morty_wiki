class GraphQLQueries {
  static String getAllCharactersQuery(page) {
    return """
      query {
        characters(page: $page) {
          results {
            id
            name
            image
            status
            species
            type
            gender
          }
        }
      }
    """;
  }

  static String getAllLocationsQuery(page) {
    return """
      query {
        locations(page:$page) {
          results {
            id
            name
            type 
          }
        }
      }
    """;
  }

  static String getCharactersFilteredQuery({String? status, String? query}) {
    return """
      query {
        characters(filter: { $status: "$query" }) {
          results {
              id
              name
              image
              status
              species
              type
              gender
          }
        }
      }

    """;
  }
}
