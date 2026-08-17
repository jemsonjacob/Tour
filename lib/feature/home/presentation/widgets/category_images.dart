class CategoryImages {
  static const String defaultImage = 'assets/images/attraction.jpg';

  static String getImage(String? category) {
    final value = category?.toLowerCase().trim() ?? '';

    // Beach / water activities
    if (value.contains('beach') ||
        value.contains('surf') ||
        value.contains('fishing') ||
        value.contains('water')) {
      return 'assets/images/beach.jpg';
    }

    // Restaurants / food
    if (value.contains('restaurant') ||
        value.contains('fast food') ||
        value.contains('cafe') ||
        value.contains('coffee') ||
        value.contains('food')) {
      return 'assets/images/restaurant.jpg';
    }

    // Hotels / accommodation
    if (value.contains('hotel') ||
        value.contains('resort') ||
        value.contains('hostel')) {
      return 'assets/images/hotel.jpg';
    }

    // Museum
    if (value.contains('museum') || value.contains('gallery')) {
      return 'assets/images/museum.jpg';
    }

    // Zoo / animals
    if (value.contains('zoo') || value.contains('animal')) {
      return 'assets/images/zoo.jpg';
    }

    // Temple / religious places
    if (value.contains('temple') ||
        value.contains('church') ||
        value.contains('mosque') ||
        value.contains('shrine')) {
      return 'assets/images/temple.jpg';
    }

    // Parks / nature
    if (value.contains('park') ||
        value.contains('garden') ||
        value.contains('nature')) {
      return 'assets/images/parks.jpg';
    }

    // Fort / historical places
    if (value.contains('fort') ||
        value.contains('castle') ||
        value.contains('historic') ||
        value.contains('monument')) {
      return 'assets/images/forts.jpg';
    }

    return defaultImage;
  }
}
