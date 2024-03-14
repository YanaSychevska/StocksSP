//
//  MainView.swift
//  StocksSP
//
//  Created by YanaSychevska on 08.03.24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel: MainViewModel = MainViewModel()
    
    var body: some View {
        NavigationStack {
                List {
                    ForEach(viewModel.stocks, id: \.ticker) { stock in
                        NavigationLink {
                            StockDetailView(stockDaily: stock)
                        } label: {
                            HStack {
                                HStack {
                                    if let goesUp = stock.isGoesUp {
                                        Image(systemName: goesUp ? "arrow.up.right" : "arrow.down.left")
                                            .foregroundStyle(goesUp ? Color.green : Color.red)
                                    }
                                    Text(stock.ticker)
                                    
                                }
                                Spacer()
                                VStack {
                                    Text("open: \(stock.openPriceS)")
                                    Text("close: \(stock.closePriceS)")
                                }
                            }
                        }
                    }
                    .onDelete(perform: delete)
                }
                .refreshable {
                    viewModel.gethHourlyBars()
                }
                .toolbar {
                    Button {
                        viewModel.isSearchViewShown.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }

                }
            }
            .listStyle(.plain)
            .onAppear(perform: {
                viewModel.gethHourlyBars()
            })
            .sheet(isPresented: $viewModel.isSearchViewShown,
                   onDismiss: {
                viewModel.gethHourlyBars()
            }, content: {
                SearchSheetView()
                    .environmentObject(viewModel)
            })
    }
    
    func delete(at offsets: IndexSet) {
        viewModel.stocks.remove(atOffsets: offsets)
        viewModel.tickers.remove(atOffsets: offsets)
    }
}

#Preview {
    MainView()
}
