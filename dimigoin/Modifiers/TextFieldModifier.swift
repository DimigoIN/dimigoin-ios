//
//  TextFieldModifier.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .frame(width: 312)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("divider"), lineWidth: 1)
            )
            .disableAutocorrection(true)
            .autocapitalization(.none)
    }
}
