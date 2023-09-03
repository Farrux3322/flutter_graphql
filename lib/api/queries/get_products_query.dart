const getProductsQuery = '''
    query Products() {
    ships{
        id
        model
        name
        image
        status
        roles
        year_built
        type
    }
  }
''';
