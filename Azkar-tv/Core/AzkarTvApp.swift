//
//  Azkar_tvApp.swift
//  Azkar-tv
//
//  Created by Mohamed Shemy on Sun 14 Mar 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import SwiftUI

@main
struct AzkarTvApp : App
{
    @ObservedObject private var azkarStore = AzkarStore()
    @ObservedObject private var favoritesStore = FavoritesStore()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene
    {
        WindowGroup
        {
            AzkarSectionView()
                .environment(\.layoutDirection, .rightToLeft)
                .environment(\.locale, Locale(identifier: "ar"))
                .environment(\.managedObjectContext, favoritesStore.context)
                .environmentObject(azkarStore)
                .environmentObject(favoritesStore)
        }
        .onChange(of: scenePhase, perform: handelScenePhase)
    }
    
    private func handelScenePhase(_ phase:  ScenePhase)
    {
        switch phase
        {
            case .background: PersistenceController.favorites.save()
            default: break
        }
    }
}
