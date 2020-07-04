//
//  TextStyles.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/07/04.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

extension Text {
    func highlight() -> Text {
        self
            .foregroundColor(Color("Highlight"))
    }
    func headline() -> Text {
        self
            .font(Font.custom("NanumSquare", size: 17))
    }
    func helperText() -> Text {
        self
            .font(Font.custom("NanumSquareR", size: 13))
            .foregroundColor(Color("HelperMessage"))
    }
    func PrimaryButton() -> some View {
        self
            .font(Font.custom("NanumSquareEB", size: 17))
            .padding()
            .background(Color("Primary"))
            .foregroundColor(Color.white)
            .cornerRadius(7.0)
    }
    func RoundedButton() -> some View {
        self
            .font(Font.custom("NanumSquareEB", size: 17))
            .frame(width: 312, height: 22)
            .padding()
            .background(Color("Primary"))
            .foregroundColor(Color.white)
            .cornerRadius(7.0)
    }
    func caption() -> Text {
        self
            .font(Font.custom("NanumSquareR", size: 13))
    }
    func body() -> Text {
        self
            .font(Font.custom("NanumSquareR", size: 15))
    }
}

struct TextStyles_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}