//
//  BookmarkView.swift
//  BrowserSwiftUI
//
//  Created by Mwai Banda on 4/2/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookmarkView: View {
    @State private var bookmarks = [Bookmark]()
    var onVisitWebsite: (String) -> Void
    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(bookmarks, id: \.self) { bookmark in

            Menu {
                Button { onVisitWebsite(bookmark.metadata.website)} label: {
                    Label("Vist Website", systemImage: "")

                }
                Button {
                    bookmarks.removeAll { b in
                        return b.metadata.website == bookmark.metadata.website
                    }
                    StoreUserDefaults.shared.saveCollection(bookmarks, key: Constants.BookmarkKey)
                } label: {
                    Label("Remove Bookmark", systemImage: "")

                }
            } label: {
                VStack {
                    HStack(alignment: .top) {
                        if (bookmark.metadata.banner ?? "" ).isEmpty {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.lightGray))
                                .frame(width: 100, height: 90)

                        } else {
                            WebImage(url: URL(string: bookmark.metadata.banner ?? ""))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 90)
                                .clipped()
                                .cornerRadius(10)
                        }
                        VStack(alignment: .leading){
                            Text(bookmark.metadata.title ?? "")
                                .font(.headline)
                                .bold()
                                .multilineTextAlignment(.leading)
                            Text(bookmark.metadata.metadataDescription ?? "")
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                        }.foregroundColor(Color(hex: Constants.BlackHex))
                        Spacer()
                    }.padding(.horizontal)
                        .padding(.bottom)
                    
                
                }.padding(.top)
            }

            }
        }
        .onAppear {
            DispatchQueue.main.async {
                bookmarks = StoreUserDefaults.shared.loadCollection(key: Constants.BookmarkKey)
            }
        }
    }
}

struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView(onVisitWebsite: { $0 })
    }
}
