//
//  TabBar.swift
//  WPRK (iOS)
//
//  Created by Mwai Banda on 9/9/21.
//

import SwiftUI
import UIKit
import AVFoundation

struct TabBar: View {
    @State private var selection = 2
    @State private var url = ""

    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                ContentWrapper {
                    IncognitoView()
                }
                .onAppear {
                    let haptic = UIImpactFeedbackGenerator(style: .light)
                    haptic.impactOccurred()
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Image(systemName: "person.crop.circle")
                    .foregroundColor(selection == 1 ? .black : Color(.lightGray))

                Text("Incognito")
                    .foregroundColor(selection == 1 ? .black : Color(.lightGray))

            }
            .tag(1)

            NavigationView {
                ContentWrapper {
                    SearchView(url: $url)
                    
                }
                .onAppear {
                    let haptic = UIImpactFeedbackGenerator(style: .light)
                    haptic.impactOccurred()
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
  
                    
                Image(systemName: "waveform.and.magnifyingglass")
                    .foregroundColor(selection == 2 ? .black : Color(.lightGray))

                Text("Search")
                    .foregroundColor(selection == 2 ? .black : Color(.lightGray))


            }

            .tag(2)
            .navigationViewStyle(StackNavigationViewStyle())
            
            NavigationView {
                ContentWrapper {
                    BookmarkView(onVisitWebsite: {
                        url = $0
                        selection = 2
                    })
                    
                }
                .onAppear {
                    let haptic = UIImpactFeedbackGenerator(style: .light)
                    haptic.impactOccurred()
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Image(systemName: "bookmark")
                    .foregroundColor(selection == 3 ? .black : Color(.lightGray))
                Text("Bookmarks")
                    .foregroundColor(selection == 3 ? .black : Color(.lightGray))

            }

            .tag(3)
        }
        .accentColor(Color(hex: Constants.YellowHex))
        
    }


}



struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
