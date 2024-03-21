class GraphQLQueries {
  static String getAllCharactersQuery() {
    return """
      query {
        characters(page: 1) {
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