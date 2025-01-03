# The Cocktail DB App

The Cocktail DB App is a Flutter-based mobile application that provides users with information about cocktails, ingredients, and recipes. Users can explore random drinks, learn about ingredients, and dive into details of their favorite cocktails. The app is powered by TheCocktailDB API.

---

## Features

- **Random Drink Generator**: Displays a random cocktail with vibrant colors extracted from the drink's image.
- **Ingredient Browser**: Browse through a list of ingredients with detailed information.
- **Pull-to-Refresh**: Reload random drinks seamlessly by pulling down on the screen.
- **Dynamic Colors**: Uses PaletteGenerator to dynamically style the UI based on cocktail images.
- **GoRouter Navigation**: Navigate effortlessly between screens.

---

## Screens

1. **Home Screen**:
   - Header section with app branding.
   - Random Drink section with drink name, category, and alcoholic information.
   - List of random ingredients.

2. **Details Screen**:
   - Displays full cocktail details including recipe, instructions, and a larger image.

3. **Ingredients Screen**:
   - Lists ingredients and their uses in cocktails.

---

## Technical Details

### Core Technologies
- **Flutter**: For building the mobile application.
- **GoRouter**: For navigation and routing.
- **CachedNetworkImage**: For efficient image loading and caching.
- **PaletteGenerator**: For dynamic color extraction from images.

### Architecture
- **State Management**: `ValueNotifier` is used for lightweight state management.
- **HTTP Client**: Custom-built HTTP client for API communication.
- **Modular Widgets**: Reusable widgets like `RandomDrink` and `RandomIngredients`.

---

## Setup and Installation

1. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd thecocktaildb_app
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the Application**:
   ```bash
   flutter run
   ```

4. **Build for Release** (Optional):
   ```bash
   flutter build apk
   ```

---

## Folder Structure

```plaintext
lib/
|- data/             # Models and Repositories
|- screens/          # Application screens
|- widgets/          # Custom reusable widgets
|- services/         # Utility functions and API integrations
```

---

## How to Contribute

1. Fork the repository.
2. Create a new branch.
3. Make changes and test thoroughly.
4. Submit a pull request with a detailed description.

---

## Future Improvements

- Implement search functionality for cocktails and ingredients.
- Add user authentication for saving favorite drinks.
- Enhance the UI with animations and transitions.

---

## License

This project is licensed under the MIT License. See the LICENSE file for details.

---

## Acknowledgements

- **TheCocktailDB API**: For providing a rich database of cocktails and ingredients.
- Flutter community for the tools and resources to build this app.

