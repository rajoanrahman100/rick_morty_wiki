class GraphQLQueries {
  static String getAllCharactersQuery({String? status, String? query, int? page}) {
    return """
      query {
        characters( filter: { $status: "$query" },page: $page) {
         info {
            count
            pages
         }
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


  static String getCastDetailsQuery({int? id}) {
    return """
        query {
           character(id: $id) {
              id
              name
              image
              status
              species
             
              gender
              location{
                name
              }
              origin{
                name
              }
              episode{
                name 
              }   
    
           }
        }

    """;
  }

  static String getEpisodeList() {
    return """
        query {
           episodes{
              results{
                name
                episode
                id
             }
           }

        }

    """;
  }
}
