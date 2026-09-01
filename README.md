# MoneyTrack

A complete Flutter finance tracker that works **100% locally/offline**.

## Features

- Material 3 UI
- Google Fonts (Poppins)
- `setState` state management
- Local dummy transactions
- Add income and expenses
- Category selection
- Automatic income, expense, and balance calculations
- Shared bottom navigation
- No backend
- No API key
- No HTTP/network calls

## Run

```bash
flutter pub get
flutter run
```

## Project structure

```text
lib/
├── main.dart
├── models/
│   └── transaction_model.dart
├── theme/
│   └── app_theme.dart
├── screens/
│   ├── home_screen.dart
│   ├── add_screen.dart
│   ├── overview_screen.dart
│   └── profile_screen.dart
├── widgets/
│   ├── transaction_tile.dart
│   ├── custom_bottom_nav.dart
│   ├── balance_card.dart
│   ├── summary_card.dart
│   └── action_card.dart
└── data/
    └── dummy_data.dart
```

> Note: Google Fonts is the only runtime package. The app contains no API key, backend, or internet/API request code.
