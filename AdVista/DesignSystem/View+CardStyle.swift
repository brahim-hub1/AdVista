import SwiftUI

extension View {
    func cardStyle() -> some View {
        self
            .padding(Spacing.m)
            .background(AppColors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(AppColors.cardBorder, lineWidth: 1)
            )
            .shadow(color: AppColors.cardBorder.opacity(0.6), radius: 8, x: 0, y: 4)
    }
}
