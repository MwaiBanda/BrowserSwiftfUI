# BrowserSwiftfUI
SwiftUI Browser App
# How to run 
Download code -> open project -> select simulator(iphone 12 pro max tested✅) -> run<br>
# Features 
- Web browsering
- News Articles
- Bookmarking (vist, add & delete)<br>
# Design Decisions
- MVVM architecture 
-  I used the algorithms library for additional array operations i.e chunked(by: ) I use to construct the 3 x 2 grid of suggestions 
- callbacks to push up actions & data
- I wanted the webview to appear within the same view as the search bar
# Tradeoffs
- directly accessing apis in view for speed instead of injecting apis as dependencies in Viewmodel 
- design wise if this was a production project I would like search bar to stick to the navbar when scrolling downwards
<table>
  <tr>
    <td>Suggestions</td>
     <td>Web</td>
     <td>Bookmarks</td>
  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/49708426/161402315-6d0660c3-edcf-4dd5-a3b3-278b83007813.PNG" width=320 height=450></td>
    <td><img src="https://user-images.githubusercontent.com/49708426/161402339-a75311b3-68dd-41e4-8e5b-c8011f22cde4.PNG" width=320 height=450></td>
    <td><img src="https://user-images.githubusercontent.com/49708426/161402423-87a5393e-a4bf-440c-80e1-ca3be97e10e5.png" width=320 height=450></td>
   
  </tr>
  </table>
