//
//  Language.swift
//  iPrayUI
//
//  Created by Mohamed Shemy on Sat 12 Dec 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import SwiftUI

class Language: NSObject, Identifiable, ObservableObject
{
    let id: String
    let direction: LayoutDirection
    let locale: Locale
    
    init(_ identifier: String, direction: LayoutDirection)
    {
        self.id = identifier
        self.direction = direction
        locale = Locale(identifier: identifier)
    }
}

extension Language
{
    static let arabic = Language("ar", direction: .rightToLeft)
    static let english = Language("en", direction: .leftToRight)
}

extension Language
{
    static func == (lhs: Language, rhs: Language) -> Bool
    {
        lhs.id == rhs.id
    }
}
