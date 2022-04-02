//
//  SearchView.swift
//  BrowserSwiftUI
//
//  Created by Mwai Banda on 4/2/22.
//

import SwiftUI
import SDWebImageSwiftUI
import Algorithms

struct SearchView: View {
    @State private var bookmarks = [Bookmark]()
    @State private var showGo = true
    @State private var articles = [Article]()
    @State private var searchText = ""
    @Binding var url: String
    @StateObject private var newsAPI = NewsAPI()
    @StateObject private var searchViewModel = SearchViewModel()
    @StateObject private var metadataAPI = MetadataAPI()

    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack {
                VStack(spacing: 0) {
                    HStack(spacing: 10) {
                        if !showGo {
                            if !url.isEmpty {
                            Button {
                                withAnimation {
                                url = ""
                                }
                            } label: {
                                Image(systemName: "square.grid.2x2")
                            }
                            Button {
                                if bookmarks.contains(where: { b in
                                    return (b.metadata.website.last == "/" ? String(b.metadata.website.dropLast()) : b.metadata.website) == url
                                }) {
                                    bookmarks.removeAll { b in
                                        return (b.metadata.website.last == "/" ? String(b.metadata.website.dropLast()) : b.metadata.website) == url
                                    }
                                    StoreUserDefaults.shared.saveCollection(bookmarks, key: Constants.BookmarkKey)
                                } else {
                                metadataAPI.getUrlMetadata(url: url.replacingOccurrences(of: "https://", with: "")) { res in
                                    switch res {
                                        
                                    case .success(let bookmark):
                                        print(bookmark)
                                        bookmarks.append(bookmark)
                                        StoreUserDefaults.shared.saveCollection(bookmarks, key: Constants.BookmarkKey)
                                    case .failure(let err):
                                        print(err.localizedDescription)
                                    }
                                }
                                }
                            } label: {
                                Image(systemName: bookmarks.contains(where: { b in
                                    return (b.metadata.website.last == "/" ? String(b.metadata.website.dropLast()) : b.metadata.website) == url
                                }) ? "bookmark.fill" : "bookmark")
                            }
                            }
                        }
                        HStack {
                            TextField("Search for website",
                                      text: $searchText, onEditingChanged: { isEditing in
                                withAnimation {
                                    if isEditing {
                                showGo = true
                                    }
                                }
                            }, onCommit: {
                                if !searchText.isEmpty {
                                withAnimation {
                                    showGo = false

                                }
                                url = searchText.first == "w" || searchText.first != "h" ? "https://" + searchText.lowercased() : searchText
                                searchText = url
                                }
                            })
                                .keyboardType(.URL)
                                .textContentType(.URL)
                                .textInputAutocapitalization(.never)
                                .padding(10)
                            Spacer()
                        }
                        .background(Color.white)
                        .cornerRadius(30)
                        if showGo {
                        Button("Go", action: {
                            if !searchText.isEmpty {
                            showGo = false
                            url = searchText.first == "w" || searchText.first != "h" ? "https://" + searchText.lowercased() : searchText
                            searchText = url
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }

                        })
                            .foregroundColor(Color(hex: Constants.YellowHex))
                            .padding(10)
                        }
                    }.padding(.horizontal)
                        .padding(.vertical, 10)
                    Divider()
                    if url.isEmpty {
                        HomeScreen
                            .padding(.top)
                        
                    } else {
                        WebView(url: URL(string: url)!, webView: searchViewModel.webView)
                            .frame(height: screenBounds.height - screenBounds.height * 0.31)
                            .onAppear(perform: {
                                showGo = false
                            })
                            .toolbar {
                                ToolbarItemGroup(placement: .bottomBar) {
                                    Button {
                                        searchViewModel.goBack()
                                    } label: {
                                        Image(systemName: "arrowshape.turn.up.backward")
                                    }
                                    .disabled(!searchViewModel.canGoBack)

                                    
                                    Button {
                                        searchViewModel.goForward()
                                    } label: {
                                        Image(systemName: "arrowshape.turn.up.right")
                                    }
                                    .disabled(!searchViewModel.canGoForward)

                                    
                                    Spacer()
                                }
                            }
                        
                    }
                }
            }
            
        }
        .onAppear {
            if !url.isEmpty && searchText.isEmpty  {
                let copyUrl = url
                searchText = String(copyUrl.dropLast())
            }
            newsAPI.getArticles { result in
                switch result {
                case .success(let articles):
                    DispatchQueue.main.async {
                        self.articles = articles
                        self.bookmarks = StoreUserDefaults.shared.loadCollection(key: Constants.BookmarkKey)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
    }
    var HomeScreen: some View {
        VStack(alignment: .leading) {
            VStack {
                ForEach(suggestions.chunks(ofCount: Int(screenBounds.width/125)),id: \.self){ row in
                    HStack {
                        ForEach(row, id: \.id){ suggestion in
                            Button {
                                url = suggestion.webURL
                                searchText = url
                            } label: {
                                WebImage(url: URL(string: suggestion.imageURL))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 95, height: 95)
                                    .padding(5)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color(.lightGray), lineWidth: 1)
                                    )
                                    .padding(5)
                            }
                        }
                    }.padding(.horizontal).padding(.horizontal)
                }
            }
            Text("Articles For You".uppercased())
                .fontWeight(.medium)
                .foregroundColor(.gray)
                .padding(.horizontal).padding(.horizontal)
                .padding(.vertical)
            VStack {
                ForEach(articles, id: \.id){ article in
                    HStack(alignment: .top) {
                        if  (article.urlToImage ?? "").isEmpty {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.lightGray))
                                .frame(width: 100, height: 90)                        } else {
                        WebImage(url: URL(string: article.urlToImage ?? ""))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 90)
                            .clipped()
                            .cornerRadius(10)
                        }
                        VStack(alignment: .leading){
                            Text(article.title ?? "")
                                .font(.headline)
                                .bold()
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(maxHeight: .infinity)
                                .padding(.bottom, 5)
                            Text(article.articleDescription ?? "")
                                .lineLimit(2)
                                .foregroundColor(.black)
                            Spacer()
                            
                        }
                        Spacer()
                    }.padding(.horizontal).padding(.horizontal)
                        .padding(.bottom)
                }
            }
            Spacer()
            
        }
    }
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(url: .constant(""))
    }
}
