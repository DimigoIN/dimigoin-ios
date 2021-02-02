//
//  TextStyles.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/07/04.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

enum NotoSansFontWeight: String {
    case regular = "Regular"
    case medium = "Medium"
    case bold = "Bold"
    case black = "Black"
}

enum NanumSquareFontWeight: String {
    case extraBold = "EB"
}

extension Text {
    func notoSans(_ weight: NotoSansFontWeight, size: CGFloat) -> Text {
        self.font(Font.custom("NotoSansKR-\(weight.rawValue)", size: size))
    }
    
    func notoSans(_ weight: NotoSansFontWeight, size: CGFloat, _ color: Color) -> Text {
        self.font(Font.custom("NotoSansKR-\(weight.rawValue)", size: size))
            .foregroundColor(color)
    }
    
    func nanumSquare(_ weight: NanumSquareFontWeight, size: CGFloat) -> Text {
        self.font(Font.custom("NanumSquare\(weight.rawValue)", size: size))
    }
    
    func nanumSquare(_ weight: NanumSquareFontWeight, size: CGFloat, _ color: Color) -> Text {
        self.font(Font.custom("NanumSquare\(weight.rawValue)", size: size))
            .foregroundColor(color)
    }
    func opennas(size: CGFloat, _ color: Color) -> Text {
        self.font(Font.custom("Openas", size: size))
            .foregroundColor(color)
    }

    func gray1() -> Text {
        self.foregroundColor(Color("gray1"))
    }
    
    func gray2() -> Text {
        self.foregroundColor(Color("gray2"))
    }
    
    func gray3() -> Text {
        self.foregroundColor(Color("gray3"))
    }
    
    func gray4() -> Text {
        self.foregroundColor(Color.gray4)
    }
    
    func gray5() -> Text {
        self.foregroundColor(Color("gray5"))
    }
    
    func gray6() -> Text {
        self.foregroundColor(Color("gray6"))
    }
    
    func gray7() -> Text {
        self.foregroundColor(Color("gray7"))
    }
}
