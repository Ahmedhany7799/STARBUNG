# STARBUNG

**Starbung** is a premium, Flutter-based drink ordering app inspired by modern coffeehouse design. Whether it’s creamy cappuccinos, fresh fruit juice, or iced beverages, **Starbung** offers a rich and interactive user experience tailored for both casual users and coffee lovers.

---

![Starbung Demo]
:---(https://github.com/user-attachments/assets/4097870d-0677-49b7-9408-1c42a3b6760f)

---

## ✨ Highlights

> “Built with love for every sip.”

- 🧭 **Onboarding & Splash Screens** – Welcoming animations and sleek transitions using Lottie.
- 🥤 **Category Navigation** – Quickly explore Coffee, Juice, and Milk drinks.
- 🎠 **Interactive Carousel** – Rotate through drinks with animated 3D-style PageView.
- 💳 **3-Step Payment Process** – Choose payment method, fill details, and confirm.
- 🎨 **Curved Custom UI** – Created with `ClipPath`, `CustomClipper`, and modern layout.
- 🛒 **Cart System** – Persistent cart with quantity controls and visual cart indicator.
- 💚 **Color Theme** – Deep emerald green `#1E3932` with rich coffee accents.

---

## 📁 Project Structure
lib/
├── components/
│ ├── drink.dart
│ ├── favorites_provider.dart
│ └── toggle_widget.dart
│
├── models/
│ ├── categorymodel.dart
│ ├── model.dart
│ └── sizedmodel.dart
│
├── payment/
│ ├── order_summary.dart
│ ├── payment_details.dart
│ └── paymentmethod.dart
│
├── views/
│ ├── cart.dart
│ ├── details.dart
│ ├── home.dart
│ ├── onboarding.dart
│ └── splash.dart
│
├── widgets/
│ ├── background.dart
│ ├── category_item.dart
│ ├── product_image.dart
│ └── main.dart




---

## 💻 Tech Stack

| Technology        | Purpose                             |
|-------------------|-------------------------------------|
| **Flutter**        | UI Framework                        |
| **Dart**           | Main programming language           |
| `PageView`         | Product slider                      |
| `Hero`             | Animated transitions                |
| `ClipPath`         | Custom-shaped UI areas              |
| `Provider`         | State management (e.g., favorites)  |
| `flutter_svg`      | Vector icon support                 |
| `Lottie`           | Animated splash/onboarding screens  |

---

## 🧪 Key Features Explained

### 🛍️ Product Carousel  
A 3D-style drink viewer with smooth animations and dynamic scaling, making the browsing experience interactive and fun.

### 📦 Cart System  
Includes live indicator on the app bar, quantity management, and checkout logic using a 3-step flow.

### 💳 Payment Flow  
Choose from multiple payment options, fill in card/address details, and confirm with a summary and QR receipt.

### 💡 Favorite Items  
Add/remove favorite drinks across sessions with easy toggles (stored via `favorites_provider.dart`).

---

Created by [Ahmed Hany],

MIT License © 2025



