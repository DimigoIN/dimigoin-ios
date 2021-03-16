//
//  AlertView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/09.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import Combine
import DimigoinKit

typealias SystemButton = Button

public struct Alert: View {
    @State var showAlert: Bool = false
    
    var cornerRadius: CGFloat = 10
    var shadowRadius: CGFloat = 10
    
    var content: AnyView
    var buttonStack: [Alert.Button]
    
    var animation: AnyTransition = AnyTransition.scale(scale: 1.2).combined(with: .opacity).animation(.easeOut(duration: 0.15))
    
    public init(content: @escaping () -> AnyView, leadingButton: Alert.Button, trailingButton: Alert.Button) {
        self.content = content()
        self.buttonStack = [leadingButton, trailingButton]
    }
    
    public init(icon: ButtonIcon, color: Color, message: String) {
        self.content = AnyView(
            VStack {
                VSpacer(48)
                Image(icon.rawValue).templateImage(width: 20, color)
                VSpacer(20)
                Text(message).notoSans(.bold, size: 15, color).padding(.bottom, 40)
            }
        )
        self.buttonStack = [
            Alert.Button.dismiss(),
            Alert.Button.ok()
        ]
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Spacer()
                    VStack(spacing: 0) {
                        content
                        HStack(spacing: 0) {
                            ForEach(0...buttonStack.count-1, id: \.self) {
                                self.buttonStack[$0]
                            }
                        }
                    }
                    .background(
                        Rectangle()
                            .frame(maxWidth: .infinity-40, minHeight: 0, maxHeight: .infinity, alignment: .center)
                            .foregroundColor(Color.systemBackground)
                            .cornerRadius(10)
                    )
                    .frame(minWidth: 0, maxWidth: geometry.size.width-40, alignment: .center)
                    .horizonPadding()
                    Spacer()
                }
                
            }
        }.frame(alignment: .center)
        
    }
    
    public enum ButtonIcon: String {
        case warningmark = "warning"
        case dangermark = "danger"
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
                AlertView.currentAlertVCReference?.dismiss(animated: true) {
                    AlertView.currentAlertVCReference = nil
                    if let action = self.action {
                        action()
                    }
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
        
        public static func dismiss() -> Alert.Button {
            return Alert.Button(label: "취소", color: .gray4, position: .leading)
        }
        
        public static func ok() -> Alert.Button {
            return Alert.Button(label: "확인", color: .accent, position: .trailing)
        }
        
        public static func ok(action: @escaping () -> Void) -> Alert.Button {
            return Alert.Button(label: "확인", color: .accent, position: .trailing, action: action)
        }
//        public static func
    }
}

public func getButtonIconColor(icon: Alert.ButtonIcon) -> Color {
    switch icon {
    case .checkmark: return Color.accent
    case .warningmark: return Color.yellow
    case .dangermark: return Color.red
    case .logoutmark: return Color.accent
    }
}

// struct AlertView: View {
//    @EnvironmentObject var alertManager: AlertManager
//    @EnvironmentObject var api: DimigoinAPI
//    @State var dragOffset = CGSize.zero
//    @State var startPos = CGPoint(x: 0, y: 0)
//    @State var placeName: String = ""
//    @State var remark: String = ""
//    @State var selectedPlace: Place = Place()
//
//    var body: some View {
//        GeometryReader { geometry in
//            VStack(spacing: 0) {
//                if alertManager.alertType == .text {
//                    VSpacer(35)
//                    Text(alertManager.content).notoSans(.bold, size: 14, Color.text)
//                    VSpacer(20)
//                    Text(alertManager.sub).notoSans(.medium, size: 12, Color("gray2")).multilineTextAlignment(.center)
//                } else if alertManager.alertType == .idCardReadme {
//                    idcardReadme
//                } else if alertManager.alertType == .attendance {
//                    VSpacer(20)
//                    Text("\(getStringTimeZone())").notoSans(.bold, size: 11, Color.accent)
//                    Text("어디에 계신가요?").notoSans(.bold, size: 16)
//                    VSpacer(20)
//                    NavigationLink(destination: SelectPlaceView(api: api, selectedPlace: $selectedPlace)) {
//                        HStack {
//                            Text(selectedPlace == Place() ? "장소를 선택하세요" : selectedPlace.name)
//                                .foregroundColor(Color.accent)
//                                .font(Font.custom("NanumSquareR", size: 14))
//                                .padding(.leading)
//                            Spacer()
//                            Image(systemName: "chevron.right")
//                                .padding(.trailing)
//                                .foregroundColor(Color.accent)
//                        }
//                    }
//                    .frame(width: 335, height: 50)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(Color("divider"), lineWidth: 1)
//                    )
//
//                    VSpacer(15)
//                    TextField("사유를 입력하세요", text: $remark).textContentType(.none)
//                        .modifier(TextFieldModifier())
//                        .modifier(ClearButton(text: $remark))
//                    VSpacer(20)
//                    Text("사전 허가된 활동 또는 감독 교사 승인 외\n임의로 등록할 경우 불이익을 받을 수 있습니다.")
//                        .notoSans(.medium, size: 12, Color("gray7")).multilineTextAlignment(.center)
//                } else if alertManager.alertType == .logout {
//                    VStack {
//                        VSpacer(35)
//                        Image(alertManager.getIconName()).templateImage(width: 30, alertManager.getAccentColor())
//                        VSpacer(23)
//                        Text(alertManager.content)
//                            .nanumSquare(.extraBold, size: 15, alertManager.getTitleColor())
//                        VSpacer(5)
//                    }
//                } else {
//                    VStack {
//                        VSpacer(35)
//                        Image(alertManager.getIconName()).templateImage(width: 30, alertManager.getAccentColor())
//                        VSpacer(23)
//                        Text(alertManager.content)
//                            .nanumSquare(.extraBold, size: 15, alertManager.getTitleColor())
//                        VSpacer(5)
//                        if alertManager.sub != "" {
//                            Text(alertManager.sub).notoSans(.medium, size: 12, Color.gray4.opacity(0.7))
//                        }
//                    }.animation(.none)
//                }
//                Spacer()
//                if alertManager.alertType == .logout {
//                    logoutButtons
//                } else if alertManager.alertType == .attendance {
//                    HStack(spacing: 0) {
//                        Button(action: {
//                            dismiss()
//                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//                        }) {
//                            Text("취소")
//                                .foregroundColor(Color.white)
//                                .font(Font.custom("NanumSquareEB", size: 14))
//                                .frame(height: 45)
//                                .frame(maxWidth: .infinity)
//                                .background(RoundSquare(topLeft: 0, topRight: 0, bottomLeft: 10, bottomRight: 0).fill(Color.gray4))
//                        }
//                        Button(action: {
//                            dismiss()
//                            api.changeUserPlace(placeName: selectedPlace.name, remark: remark == "" ? "없음" : remark) { result in
//                                switch result {
//                                case .success(()):
//                                    self.api.fetchUserCurrentPlace {
//                                        self.api.fetchAttendanceListData {
//                                            alertManager.createAlert("\"\(selectedPlace.name)\"(으)로 변경되었습니다.", .success)
//                                        }
//                                    }
//                                case .failure(let error):
//                                    switch error {
//                                    case .noSuchPlace:
//                                        alertManager.createAlert("유효하지 않은 장소 이름입니다.", .danger)
//                                    case .notRightTime:
//                                        alertManager.createAlert("인원 점검 시간이 아닙니다.", .danger)
//                                    case .tokenExpired:
//                                        print("")
//                                    case .unknown:
//                                        alertManager.createAlert("알 수 없는 에러", .danger)
//                                    }
//                                }
//                            }
//                        }) {
//                            Text("확인")
//                                .foregroundColor(Color.white)
//                                .font(Font.custom("NanumSquareEB", size: 14))
//                                .frame(height: 45)
//                                .frame(maxWidth: .infinity)
//                                .background(RoundSquare(topLeft: 0, topRight: 0, bottomLeft: 0, bottomRight: 10).fill(alertManager.getAccentColor()))
//                        }
//                    }
//                } else {
//                    Button(action: {
//                        dismiss()
//                    }) {
//                        Text(alertManager.alertType == .idCardReadme ? "닫기" : "확인")
//                            .foregroundColor(Color.white)
//                            .font(Font.custom("NanumSquareEB", size: 14))
//                            .frame(height: 45)
//                            .frame(maxWidth: .infinity)
//                            .background(RoundSquare(topLeft: 0, topRight: 0, bottomLeft: 10, bottomRight: 10).fill(alertManager.getAccentColor()))
//                    }
//                }
//
//            }
//            .frame(width: UIDevice.current.userInterfaceIdiom == .phone ? abs(geometry.size.width - 20) : 380, height: alertManager.alertType == .idCardReadme ? 260 : (alertManager.alertType == .attendance ? 314 : 195))
//            .background(Color(UIColor.systemBackground).cornerRadius(10))
//            .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .phone ? 10 : (geometry.size.width - 380)/2)
//            .padding(.top, (geometry.size.height - (alertManager.alertType == .idCardReadme ? 260 : (alertManager.alertType == .attendance ? 314 : 195)))/2)
//            .edgesIgnoringSafeArea(.all)
//            .keyboardResponsive()
//            .opacity(alertManager.isShowing ? 1 : 0)
//        }.frame(alignment: .center)
//
//    }
//
//    func dismiss() {
//        withAnimation(.spring()) {
//            alertManager.isShowing = false
//        }
//    }
//
//    var idcardReadme: some View {
//        return VStack {
//            HStack {
//                Image("infomark").templateImage(width: 12, height: 12, Color.gray4)
//                Text("사용 전 다음 내용을 반드시 읽어주세요").notoSans(.bold, size: 12, Color.gray4)
//            }.padding()
//            Text("1. 본 증은 학교가 정식 발급한 학생증입니다.\n이외 신분증 등 활용은 활용처의 규정에 따라 달라질 수 있습니다.\n\n2. 본 증은 본인 이외 타인이 소지 또는 활용할 수 없습니다.\n타인에게 양도하여 입은 피해는 본인의 책임입니다.\n\n3. 스크린샷 또는 사본으로 동일한 효력을 발생시킬 수 없습니다.")
//                .notoSans(.medium, size: 11, Color("gray6"))
//                .multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
//        }.animation(.none)
//        .padding(.vertical)
//    }
//
//    var logoutButtons: some View {
//        HStack(spacing: 0) {
//            Button(action: {
//                dismiss()
//            }) {
//                Text("취소")
//                    .foregroundColor(Color.white)
//                    .font(Font.custom("NanumSquareEB", size: 14))
//                    .frame(height: 45)
//                    .frame(maxWidth: .infinity)
//                    .background(RoundSquare(topLeft: 0, topRight: 0, bottomLeft: 10, bottomRight: 0).fill(Color.gray4))
//            }
//            Button(action: {
//                dismiss()
//                api.logout()
//            }) {
//                Text("확인")
//                    .foregroundColor(Color.white)
//                    .font(Font.custom("NanumSquareEB", size: 14))
//                    .frame(height: 45)
//                    .frame(maxWidth: .infinity)
//                    .background(RoundSquare(topLeft: 0, topRight: 0, bottomLeft: 0, bottomRight: 10).fill(alertManager.getAccentColor()))
//            }
//        }
//
//    }
//}
