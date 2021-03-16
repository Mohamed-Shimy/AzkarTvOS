//
//  SubSectionsView.swift
//  iPrayUI
//
//  Created by Mohamed Shemy on Fri 18 Dec 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import SwiftUI

struct AzkarSubSectionsView : View
{
    @EnvironmentObject var store: AzkarStore
    let section: Section
    
    var body: some View
    {
        VStack(spacing: 50)
        {
            NavigationTitle(title: section.title)
            
            ScrollView(.vertical, showsIndicators: false)
            {
                LazyVStack(spacing: 50)
                {
                    ForEach(store[section], content: AzkarSubSectionCell.init)
                }
            }
        }
        .navigationBarHidden(true)
        .islamicBackground()
    }
}

struct AzkarSubSectionsView_Previews : PreviewProvider
{
    @ObservedObject private static var store = AzkarStore()
    
    static var previews: some View
    {
        AzkarSubSectionsView(section: store[6])
            .environment(\.layoutDirection, .rightToLeft)
            .environment(\.locale, Locale(identifier: "ar"))
            .environmentObject(store)
    }
}

struct AzkarSubSectionCell : View
{
    let subSection: SubSection
    
    var body: some View
    {
        NavigationLink(destination: AzkarContentView(subSection: subSection))
        {
            Text(subSection.title)
                .padding(10)
                .font(.title2)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .frame(maxWidth: .infinity, minHeight: 64)
                .linearGradientBackground()
                .cornerRadius(15)
                .cellBackgroundStyle(RoundedRectangle(cornerRadius: 15))
        }
        .animation(.spring(response: 1, dampingFraction: 0.5, blendDuration: 1))
        .padding(.horizontal, 50)
        .buttonStyle(PlainButtonStyle())
    }
}
