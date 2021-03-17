//
//  AlertButton.swift
//  dimigoin
//
//  Created by 변경민 on 2021/03/10.
//  Copyright © 2021 seohun. All rights reserved.
//
import SwiftUI

extension Alert {
    enum ButtonType {
        case `default`
        case cancel
        case warning
        case danger
    }
    enum ButtonPosition {
        case trailing
        case leading
        case center
    }
    public enum ButtonIcon: String {
        case warningmark = "warningmark"
        case dangermark = "dangermark"
        case checkmark = "checkmark"
        case logoutmark = "logout"
    }
    
    public struct Button: View {
        let label: String
        var backgroundColor: Color = Color.gray4
        var buttonPosition: Alert.ButtonPosition = .center
        var action: (() -> Void)?

        init(label: String, color: Color, position: Alert.ButtonPosition, action: (() -> Void)? = {}) {
            self.label = label
            self.backgroundColor = color
            self.buttonPosition = position
            self.action = action
        }
        
        public var body: some View {
            SystemButton(action: {
                UIApplication.shared.windows.first!.rootViewController?.dismiss(animated: true, completion: nil)
                if let action = self.action {
                    action()
                }
            }) {
                Text(label)
                    .notoSans(.bold, size: 14)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .frame(height: 45)
                    .foregroundColor(Color.systemBackground)
                    .background(getButtonBackgroundByPosition(buttonPosition).fill(backgroundColor))
            }
        }
        
        // button types
        public static func center(_ label: String, action: (() -> Void)? = {}) -> Alert.Button {
            return Alert.Button(label: label, color: .gray4, position: .center, action: action)
        }
        
        public static func center(_ label: String, color: Color) -> Alert.Button {
            return Alert.Button(label: label, color: color, position: .center)
        }
        
        public static func dismiss() -> Alert.Button {
            return Alert.Button(label: "취소", color: .gray4, position: .leading)
        }
        
        public static func ok() -> Alert.Button {
            return Alert.Button(label: "확인", color: .accent, position: .trailing)
        }
        
        public static func ok(action: @escaping () -> Void) -> Alert.Button {
            return Alert.Button(label: "확인", color: .accent, position: .trailing, action: action)
        }
        
//        public static func logoutCheck() -> Alert.Bu
//        public static func
    }
}

func getButtonBackgroundByPosition(_ position: Alert.ButtonPosition) -> RoundSquare {
    switch position {
    case .center: return RoundSquare(topLeft: 0, topRight: 0, bottomLeft: 10, bottomRight: 10)
    case .trailing: return RoundSquare(topLeft: 0, topRight: 0, bottomLeft: 0, bottomRight: 10)
    case .leading: return RoundSquare(topLeft: 0, topRight: 0, bottomLeft: 10, bottomRight: 0)
    }
}
func getButtonColorByType(_ type: Alert.ButtonType) -> Color {
    switch type {
    case .default: return Color.accent
    case .cancel: return Color.gray4
    case .warning: return Color.yellow
    case .danger: return Color.red
    }
}
