//
//  AzkarContentView.swift
//  iPrayUI
//
//  Created by Mohamed Shemy on Fri 18 Dec 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import SwiftUI

struct AzkarContentView : View
{
    @EnvironmentObject var favoritesStore: FavoritesStore
    @EnvironmentObject var store: AzkarStore
    let subSection: SubSection
    
    @State private var favImage: String = "heart"
    private var isFavorite: Bool { favoritesStore.isFavorite(subSection.id)  }
    
    var body: some View
    {
        VStack
        {
            NavigationTitle(title: subSection.title,
                            trailingImage: Image(systemName: favImage),
                            acrion: toggleFavorites)
            
            ScrollView(.vertical, showsIndicators: false)
            {
                LazyVStack(spacing: 25)
                {
                    ForEach(store[subSection], content: AzkarContentCell.init)
                }
            }
            .ignoresSafeArea(.all, edges: .horizontal)
        }
        .navigationBarHidden(true)
        .islamicBackground()
        .onAppear() { favImage = isFavorite ? "heart.fill" : "heart"}
    }
    
    private func toggleFavorites()
    {
        withAnimation
        {
            if isFavorite
            {
                deleteFromFavorites()
            }
            else
            {
                addToFavorites()
            }
        }
    }
    
    private func deleteFromFavorites()
    {
        if favoritesStore.delete(subSection)
        {
            favImage = "heart"
        }
    }
    
    private func addToFavorites()
    {
        if favoritesStore.add(subSection)
        {
            favImage = "heart.fill"
        }
    }
}

struct AzkarContentView_Previews : PreviewProvider
{
    @ObservedObject private static var store = AzkarStore()
    @ObservedObject private static var favoritesStore = FavoritesStore()
    
    static var previews: some View
    {
        let section = store[0]
        AzkarContentView(subSection: store[section][4])
            .environment(\.layoutDirection, .rightToLeft)
            .environment(\.locale, Locale(identifier: "ar"))
            .environmentObject(store)
            .environmentObject(favoritesStore)
    }
}

struct AzkarContentCell : View
{
    @State private var count: Int = 0
    let content: Zikr
    
    var body: some View
    {
        Button(action: increaseCount)
        {
            HStack(alignment: .top, spacing: 5)
            {
                let isFinish = count == content.count && content.count > 0
                if content.count > 0
                {
                    Controlls(totalCount: content.count, count: $count)
                        .padding(10)
                }
                
                Text(content.data)
                    .frame(maxHeight: .infinity)
                    .padding(30)
                    .font(.title2)
                    .foregroundColor(.foreground)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(10)
                    .frame(maxWidth: .infinity)
                    .background(isFinish ?
                                    Color.red.opacity(0.7).blur(radius: 5) :
                                    Color.green.opacity(0.7).blur(radius: 5))
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 80)
        .buttonStyle(PlainButtonStyle())
    }
    
    private func increaseCount()
    {
        withAnimation
        {
            count = count == content.count ? 0 : count + 1
        }
    }
}

extension AzkarContentCell
{
    struct Controlls : View
    {
        let totalCount: Int
        @Binding var count: Int
        
        private var isFinish: Bool { count == totalCount }
        
        var body: some View
        { let size: CGFloat = 64
            
            VStack(spacing: 10)
            {
                Text("\(count)")
                    .azkarContentControlsStyle(size: size,
                                               backgroundColor: isFinish ? Color.red : Color.background)
                
                Text("\(totalCount)")
                    .azkarContentControlsStyle(size: size, backgroundColor: .green)
            }
            .padding(.leading, 5)
            .font(.headline)
            .frame(width: size)
            .shadow(color: .background, radius: 2, x: 0, y: 0)
            .buttonStyle(PlainButtonStyle())
        }
    }
}

extension View
{
    func azkarContentControlsStyle(size: CGFloat,
                                   backgroundColor: Color = .background,
                                   forgroundColor: Color = .foreground) -> some View
    {
        self
            .frame(width: size, height: size)
            .foregroundColor(forgroundColor)
            .background(backgroundColor)
            .clipShape(Circle())
    }
}
