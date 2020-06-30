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
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 7.0)
                    .stroke(Color("TextFieldBorder"), lineWidth: 1.5)
            )
    }
}

struct TextFieldModifier_Previews: PreviewProvider {
    @State static var previewText = ""
    
    static var previews: some View {
        TextField("텍스트 필드", text: $previewText)
            .modifier(TextFieldModifier())
            .padding()
            .previewLayout(.sizeThatFits)
            .border(Color("TextFieldBorder"), width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
    }
}
