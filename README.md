# AdVista

AdVista est un MVP iOS développé en SwiftUI pour explorer et analyser des creatives publicitaires.
L’objectif de ce projet est de démontrer une exécution rapide, une architecture propre
et une gestion réaliste des données à l’aide de Firebase et de données CSV servant de seed data.

---

## ✨ Fonctionnalités

- Parcours des creatives publicitaires avec KPIs clés
- Écran dashboard / vue d’ensemble
- Liste des creatives et vue de détail
- Chargement dynamique des données
- Intégration de Firebase (Firestore)
- Import de données CSV (seed data)
- Possibilité de basculer entre la **source CSV** et la **source Firebase**
- Interface SwiftUI propre et conforme aux guidelines Apple

---

## 🧠 Architecture

- **SwiftUI**
- **MVVM**
- Structure modulaire par features
- Séparation claire des responsabilités :
  - Views
  - ViewModels
  - Services
  - Models

---

## 📦 Sources de données

L’application prend en charge **deux sources de données** :

### 1. **CSV (local)**
- Utilise le fichier CSV fourni dans l’assignement
- Les données sont parsées et mappées vers les modèles métier
- Utile pour les tests locaux et la mise en place rapide du MVP

### 2. **Firebase (Firestore)**
- Les données CSV sont considérées comme des *seed / fake data*
- Importées dans Firestore sous forme de documents structurés (JSON)
- L’application récupère les creatives directement depuis Firestore
- Un **switch** permet de changer la source de données à l’exécution

> Firestore est utilisé uniquement comme source de données pour ce MVP  
> (sans authentification ni logique backend avancée).

---

## 🔥 Configuration Firebase :

- Firebase est initialisé via le SDK iOS standard
- La configuration est effectuée à l’aide du fichier `GoogleService-Info.plist`
- Aucun credential admin n’est utilisé ou exposé
- Firestore est utilisé en mode lecture pour ce test

---

## 📁 Structure du projet :

```
AdVista/                ← racine du dépôt
├── AdVista/            ← code source de l’application
│   ├── App/
│   ├── Core/
│   ├── DesignSystem/
│   ├── Features/
│   ├── Navigation/
│   ├── Resources/
│   ├── Preview/
│   ├── Assets.xcassets/
│   └── Preview Content/
├── AdVista.xcodeproj/
├── AdVistaTests/
└── AdVistaUITests/
```

▶️ Build & Run :

Ouvrir AdVista.xcodeproj dans Xcode

Sélectionner le scheme AdVista

Choisir un simulateur iOS (iOS 18.2+)

Lancer l’application (Cmd + R)

🧪 Périmètre MVP & compromis :

Focus sur la fonctionnalité cœur et l’exécution

UI volontairement simple et lisible (pas d’animations complexes)

Utilisation minimale et pragmatique de Firebase

Logique d’import CSV adaptée aux contraintes de Firestore (documents JSON)

Cette approche reflète une vision réaliste du MVP :
livrer rapidement une application fonctionnelle, extensible et facile à faire évoluer.

🛠 Outils utilisés :

-SwiftUI

-Firebase (Firestore)

-Xcode

-Codex CLI (utilisé pour accélérer le développement)

📌 Remarques:
Ce projet a été réalisé dans le cadre d’un test MVP sur une journée.
Des améliorations telles que l’authentification, des filtres avancés,
le cache offline ou la pagination peuvent être ajoutées facilement si nécessaire.
