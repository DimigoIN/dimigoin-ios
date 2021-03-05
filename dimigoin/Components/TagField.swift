//
//  TagField.swift
//  dimigoin
//
//  Created by 변경민 on 2021/03/05.
//  Copyright © 2021 seohun. All rights reserved.
//

import SwiftUI

public struct TagField : View {
    @Binding public var tags: [String]
    @State private var newTag: String = ""
    @State var color: Color = Color.accent
    private var placeholder: String = ""
    
    public var body: some View {
        VStack(spacing: 0) {
            TextField(placeholder, text: $newTag, onEditingChanged: { _ in
                appendNewTag()
            }, onCommit: {
                appendNewTag()
            })
            .fixedSize()
            .disableAutocorrection(true)
            .accentColor(color)
            .id("TextField")
            .padding([.leading, .vertical])
            .frame(maxWidth: .infinity-40, alignment: .leading)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(color, lineWidth: 0.75)
            )
            .onChange(of: newTag) { change in
                if change.isContainSpaceAndNewlines() {
                    appendNewTag()
                }
                
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(tags, id: \.self) { tag in
                        HStack {
                            Text("\(tag)")
                                .notoSans(.medium, size: 13)
                                .fixedSize()
                                .foregroundColor(color.opacity(0.8))
                                .padding([.leading], 10)
                                .padding(.vertical, 5)
                            Button(action: {
                                withAnimation {
                                    tags.removeAll { $0 == tag }
                                }
                            }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(color.opacity(0.8))
                                    .font(.system(size: 12, weight: .bold, design: .rounded))
                                    .padding([.trailing], 10)
                            }
                        }.background(color.opacity(0.1).cornerRadius(.infinity))
                    }
                    
                }
            }.padding(.top)
        }
    }
    func appendNewTag() {
        var tag = newTag
        if !isBlank(tag: tag) {
            if tag.last == " " {
                tag.removeLast()
                if !isOverlap(tag: tag) {
                    withAnimation {
                        tags.append(tag)
                    }
                }
            } else {
                if !isOverlap(tag: tag) {
                    withAnimation {
                        tags.append(tag)
                    }
                }
            }
        }
        newTag.removeAll()
    }
    func isOverlap(tag: String) -> Bool {
        if tags.contains(tag) {
            return true
        } else {
            return false
        }
    }
    func isBlank(tag: String) -> Bool {
        let tmp = tag.trimmingCharacters(in: .whitespaces)
        if tmp == "" {
            return true
        } else {
            return false
        }
    }
    public init(tags: Binding<[String]>, placeholder: String) {
        self._tags = tags
        self.placeholder = placeholder
    }
}

extension String {
    func isContainSpaceAndNewlines() -> Bool {
        return rangeOfCharacter(from: .whitespacesAndNewlines) != nil
    }
}
