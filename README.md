
# 🎲 Score Tracker - 10,000 Game

Welcome to the **10,000** game score tracker! This app is designed to simplify scorekeeping and enhance the fun and interactive experience of playing **10,000**.

## 📋 Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## 🌟 Features

- **Add Players**: Easily add players and manage their scores in real-time.
- **Score Adjustment**: Quickly modify scores with one-click buttons to add or subtract points.
- **Automatic Winner Detection**: When a player reaches the target score, a congratulatory animation and modal pop up to announce the winner.
- **Score Reset**: Reset all scores to start a new game session.
- **Welcome Screen**: If no players are added, a start screen displays the app logo and an "Add Player" button to begin the game.

## 📥 Installation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/agarrec-vivlio/10000.git
   cd 10000
   ```

2. **Install Dependencies:**

   Make sure you have Flutter installed. If not, [follow this guide to install Flutter](https://flutter.dev/docs/get-started/install).

   Then, run:

   ```bash
   flutter pub get
   ```

3. **Run the Application:**

   ```bash
   flutter run
   ```

## ⚙️ Configuration

To use your custom logo:

1. Replace the `logo.png` image in the `assets` folder with your logo.
2. Update `pubspec.yaml` if needed:

   ```yaml
   flutter:
     assets:
       - assets/logo.png
   ```

## 🚀 Usage

1. **Add a Player**: Click the **Add Player** button on the welcome screen or in the AppBar to add players to the game.
2. **Update Scores**: Click on the `+50`, `-50`, `+100` buttons to adjust scores for each player, or click the custom score icon to enter a specific score.
3. **Winner Detection**: When a player reaches the target score, a victory animation displays to celebrate the winner, and scores are then reset.
4. **Reset Scores**: Use the reset button at the bottom of the screen to clear all scores and start a new session.

## 🤝 Contributing

Contributions are welcome! To contribute:

1. **Fork** the repository.
2. **Clone** your fork: `git clone https://github.com/your-username/10000.git`
3. **Create a branch** for your feature: `git checkout -b feature/your-feature-name`
4. **Make your changes** and **commit** them: `git commit -m 'Add some feature'`
5. **Push** your branch: `git push origin feature/your-feature-name`
6. **Open a Pull Request**

