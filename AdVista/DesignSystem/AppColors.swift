import SwiftUI

enum AppColors {
    static let backgroundTop = Color(uiColor: UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(red: 0.08, green: 0.10, blue: 0.12, alpha: 1.0)
            : UIColor(red: 0.93, green: 0.97, blue: 0.95, alpha: 1.0)
    })

    static let backgroundBottom = Color(uiColor: UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(red: 0.03, green: 0.04, blue: 0.05, alpha: 1.0)
            : UIColor(red: 0.99, green: 0.99, blue: 0.98, alpha: 1.0)
    })

    static let cardBackground = Color(uiColor: UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(red: 0.12, green: 0.13, blue: 0.15, alpha: 1.0)
            : UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.9)
    })

    static let cardBorder = Color(uiColor: UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor.white.withAlphaComponent(0.08)
            : UIColor.black.withAlphaComponent(0.05)
    })

    static let accent = Color(uiColor: UIColor { _ in
        UIColor(red: 0.34, green: 0.56, blue: 0.95, alpha: 1.0)
    })

    static let accentSoft = Color(uiColor: UIColor { _ in
        UIColor(red: 0.78, green: 0.87, blue: 0.98, alpha: 1.0)
    })

    static let success = Color(uiColor: UIColor { _ in
        UIColor(red: 0.30, green: 0.78, blue: 0.56, alpha: 1.0)
    })

    static let warning = Color(uiColor: UIColor { _ in
        UIColor(red: 0.98, green: 0.77, blue: 0.35, alpha: 1.0)
    })

    static let danger = Color(uiColor: UIColor { _ in
        UIColor(red: 0.95, green: 0.45, blue: 0.45, alpha: 1.0)
    })

    static let mutedText = Color(uiColor: UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor.white.withAlphaComponent(0.6)
            : UIColor.black.withAlphaComponent(0.55)
    })

    static let backgroundGradient = LinearGradient(
        colors: [backgroundTop, backgroundBottom],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
