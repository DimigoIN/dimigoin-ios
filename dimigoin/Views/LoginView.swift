//
//  LoginView.swift
//  dimigoin-ios
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import DimigoinKit

struct LoginView: View {
    @EnvironmentObject var tokenAPI: TokenAPI
    @EnvironmentObject var alertManager: AlertManager
    @State var username = ""
    @State var password = ""
    @State var showErrorMessage:Bool = false
    @State var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Spacer()
                VStack {
                    Image("logo").resizable().aspectRatio(contentMode: .fit).frame(height: 42.8)
                    VSpacer(43.5)
                    TextField("아이디를 입력하세요", text: $username).textContentType(.username)
                        .accessibility(identifier: "textfield.username")
                        .modifier(TextFieldModifier(isError: $showErrorMessage))
                        .modifier(ClearButton(text: $username))
                    VSpacer(10)
                    SecureField("패스워드를 입력하세요", text: $password, onCommit: {
                        dismissKeyboard()
                    }).textContentType(.password)
                        .accessibility(identifier: "textfield.password")
                        .modifier(TextFieldModifier(isError: $showErrorMessage))
                        .modifier(ClearButton(text: $password))
                    if showErrorMessage {
                        VSpacer(17)
                        Text("존재하지 않는 아이디거나 잘못된 패스워드입니다.").font(Font.custom("NotoSansKR-Medium", size: 12)).warning()
                        VSpacer(17)
                    } else {
                        VSpacer(30)
                    }
                    Button(action : {
                        LOG("get token")
                        isLoading = true
                        let parameters: [String: String] = [
                            "username": "\(self.username)",
                            "password": "\(self.password)"
                        ]
                        let endPoint = "/auth"
                        let method:HTTPMethod = .post
                        AF.request(rootURL+endPoint, method: method, parameters: parameters, encoding: JSONEncoding.default).response { response in
                            if let status = response.response?.statusCode {
                                switch(status) {
                                case 200:
                                    let json = JSON(response.value!!)
                                    self.tokenAPI.accessToken = json["accessToken"].string!
                                    self.tokenAPI.refreshToken = json["refreshToken"].string!
                                    self.dismissKeyboard()
                                    self.tokenAPI.debugToken()
                                    self.tokenAPI.saveTokens()
                                    self.tokenAPI.tokenStatus = .exist
                                    isLoading = false
                                default:
                                    LOG("get token failed")
                                    withAnimation() {
                                        self.showErrorMessage = true
                                    }
                                    debugPrint(response)
                                    self.tokenAPI.tokenStatus = .none
                                    isLoading = false
                                }
                            }
                        }
                    }) {
                        HStack {
                            if(isLoading) {
                                if #available(iOS 14.0, *) {
                                    ProgressView()
                                }
                            }
                            HSpacer(10)
                            Text("로그인")
                                .font(Font.custom("NotoSansKR-Bold", size: 18))
                                .foregroundColor(Color.white)
                        }
                        .frame(width: 335, height: 50)
                        .background(Color(isLoading ? "disabled-button": "accent").cornerRadius(10))
                    }.accessibility(identifier: "button.login")
                }
                VSpacer(20)
                Button(action: {
                    
                }) {
                    HStack {
                        Image("infomark").frame(width: 13, height: 13)
                        Text("아이디 또는 비밀번호를 잊으셨나요?").font(Font.custom("NotoSansKR-Medium", size: 12)).disabled()
                    }
                }
                Spacer()
            }.padding(.horizontal)
            .edgesIgnoringSafeArea(.top)
            .keyboardResponsive()
            AlertView(isShowing: $alertManager.isShowing)
                .environmentObject(alertManager)
        }
    }
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
