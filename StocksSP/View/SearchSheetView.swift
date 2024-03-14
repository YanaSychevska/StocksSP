//
//  SearchSheetView.swift
//  StocksSP
//
//  Created by YanaSychevska on 09.03.24.
//

import SwiftUI

struct SearchSheetView: View {
    @EnvironmentObject var mainVM: MainViewModel
    @StateObject var viewModel: SearchSheetViewModel = SearchSheetViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                TextField("Enter ticker or company name", text: $viewModel.searchText)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 20)
                    .background(Color.gray.opacity(0.2))
                    .clipped()
                    .cornerRadius(10)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 16)
                        }
                    )
                Spacer()
            }
            if let tickers = viewModel.tickers {
                List {
                    ForEach(tickers, id: \.ticker) { ticker in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(ticker.name)
                                    .font(.caption)
                                Text(ticker.ticker)
                                    .font(.caption)
                                    .foregroundStyle(Color.gray)
                            }
                            Spacer()
                            if mainVM.tickers.contains(ticker.ticker) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(Color.green)
                            } else {
                                Button(action: {
                                    mainVM.tickers.append(ticker.ticker)
                                }, label: {
                                    Image(systemName: "plus.circle")
                                })
                            }
                        }
                    }
                }
                .listStyle(.plain)
            } else {
                
                Spacer()
                
                Text("Please Search Your Item")
                
                Spacer()
            }
        }
        .padding()
    }
}

#Preview {
    SearchSheetView()
}
