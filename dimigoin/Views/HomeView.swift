//
//  HomeView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/08.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit
import LocalAuthentication

struct HomeView: View {
    
    @EnvironmentObject var mealAPI: MealAPI
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var tokenAPI : TokenAPI
    @EnvironmentObject var userAPI: UserAPI
    @Binding var showIdCard: Bool
    @State var currentLocation = 0
//    @State var currentCardIdx = 0
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack{
                ZStack {
                    VStack {
                        if UIDevice.current.userInterfaceIdiom == .phone {
                            VSpacer(70)
                        } else {
                            VSpacer(20)
                        }
                        Image("school").resizable().aspectRatio(contentMode: .fit).frame(width: UIScreen.screenWidth).opacity(0.3)
                    }
                    HStack {
                        Image("logo").resizable().aspectRatio(contentMode: .fit).frame(height: 38)
                        Spacer()
                        Button(action: {
                            localAuthentication()
                        }) {
                            // MARK: replace userPhoto-sample to userImage when backend ready
                            Image("userPhoto-sample")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 38)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color("accent"), lineWidth: 2)
                                )
                        }
                    }.horizonPadding()
                }
                VSpacer(15)
                LocationSelectionView(currentLocation: $currentLocation)
                Spacer()
                Text("오늘의 급식").font(Font.custom("NotoSansKR-Bold", size: 20)).horizonPadding()
                MealPagerView()
                    .environmentObject(mealAPI)
            }
        }
    }
    func localAuthentication() -> Void {

            let laContext = LAContext()
            var error: NSError?
            let biometricsPolicy = LAPolicy.deviceOwnerAuthenticationWithBiometrics

            if (laContext.canEvaluatePolicy(biometricsPolicy, error: &error)) {

                if let laError = error {
                    print("laError - \(laError)")
                    return
                }

                var localizedReason = "Unlock device"
                if #available(iOS 11.0, *) {
                    if (laContext.biometryType == LABiometryType.faceID) {
                        localizedReason = "Unlock using Face ID"
                        print("FaceId support")
                    } else if (laContext.biometryType == LABiometryType.touchID) {
                        localizedReason = "Unlock using Touch ID"
                        print("TouchId support")
                    } else {
                        print("No Biometric support")
                    }
                } else {
                    // Fallback on earlier versions
                }


                laContext.evaluatePolicy(biometricsPolicy, localizedReason: localizedReason, reply: { (isSuccess, error) in

                    DispatchQueue.main.async(execute: {

                        if let laError = error {
                            print("laError - \(laError)")
                        } else {
                            if isSuccess {
                                print("sucess")
                            } else {
                                print("failure")
                            }
                        }

                    })
                })
            }


        }
}


