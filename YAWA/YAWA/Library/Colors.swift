//
//  Colors.swift
//  YAWA
//
//  Created by Bassist Zero on 12/4/23.
//

import UIKit.UIColor

// MARK: - Single Colors

extension UIColor {

    static var primary: UIColor {
        varyUIColor(
            light: .init(hex: "#2F5AF4")!,
            dark: .init(hex: "#121212")!
        )
    }

    static var border: CGColor {
        varyCGColor(
            light: .init(redValue: 78, greenValue: 115, blueValue: 246, alpha: 1)!,
            dark: .init(redValue: 63, greenValue: 72, blueValue: 85, alpha: 1)!
        )
    }

}

// MARK: - Gradient Colors

extension UIColor {

    static var gradientBackground: [CGColor] {
        varyGradient(
            light: [
                primary,
                UIColor(hex: "#0F9EA8")!
            ],
            dark: [
                primary,
                UIColor(hex: "#1E2937")!
            ]
        )
    }

}

// MARK: - varyColor Helper

extension UIColor {

    private static func varyUIColor(light: UIColor, dark: UIColor) -> UIColor {
        UIColor { traits -> UIColor in
            return traits.userInterfaceStyle == .light ? light : dark
        }
    }

    private static func varyCGColor(light: UIColor, dark: UIColor) -> CGColor {
        UIScreen.main.traitCollection.userInterfaceStyle == .light ? light.cgColor : dark.cgColor
    }

    private static func varyGradient(light: [UIColor], dark: [UIColor]) -> [CGColor] {
        UIScreen.main.traitCollection.userInterfaceStyle == .light ? light.map { $0.cgColor } : dark.map { $0 .cgColor }
    }

}
