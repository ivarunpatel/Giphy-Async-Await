//
//  FeedView.swift
//  GiphyAsyncAwait
//
//  Created by Varun on 11/05/23.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject private(set) public var viewModel: FeedViewModel
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("\(viewModel.items.count)").task {
            await viewModel.loadFeed()
        }
    }
}

//struct FeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView(viewModel: <#FeedViewModel#>)
//    }
//}
