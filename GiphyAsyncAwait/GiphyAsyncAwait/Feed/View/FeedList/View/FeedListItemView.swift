//
//  FeedListItemView.swift
//  GiphyAsyncAwait
//
//  Created by Varun on 12/05/23.
//

import SwiftUI
import FLAnimatedImage

struct FeedListItemView: View {
    let viewModel: FeedListItemViewModel
    
    init(viewModel: FeedListItemViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(spacing: 10) {
            GIFView(type: .url(viewModel.images.small.url))
                .background(Color("SlateBlack"))
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    if let trendingDateTime = viewModel.trendingDateTime {
                        Spacer()
                        Text(trendingDateTime)
                            .font(.caption)
                            .foregroundColor(Color("AppGrey"))
                    }
                }.padding(.trailing, 10)
                Text(viewModel.title)
                    .font(.subheadline)
                    .foregroundColor(Color("AppWhite"))
                if let aurthorName = viewModel.aurthorName {
                    Text(aurthorName)
                        .font(.caption)
                        .foregroundColor(Color("AppGrey"))
                }
                Spacer()
                Color("AppGrey")
                    .frame(height: 1)
            }
            .padding(.top, 10)
        }
        .padding(.all, 5)
        .frame(height: 150, alignment: .leading)
        .background(Color.black)
    }
}

struct FeedListItemView_Previews: PreviewProvider {
    static var previews: some View {
        FeedListItemView(viewModel: FeedListItemViewModel.dummyViewModel)
    }
}
