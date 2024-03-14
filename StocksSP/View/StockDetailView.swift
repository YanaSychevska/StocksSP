//
//  StockDetailedView.swift
//  StocksSP
//
//  Created by YanaSychevska on 08.03.24.
//

import SwiftUI
import Charts

struct StockDetailView: View {
    let stockDaily: StocksDailyBars
    @StateObject var viewModel: StockDetailViewModel = StockDetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack(alignment: .lastTextBaseline) {
                    Text(stockDaily.ticker)
                        .font(.title)
                    Text(viewModel.stockInfo.name)
                        .font(.title3)
                        .foregroundStyle(Color.gray)
                    Spacer()
                }
                if let results = stockDaily.results,
                    let firstResult = results.first,
                    let lastResult = results.last {
                    Chart {
                        ForEach(results, id: \.t) { stock in
                            LineMark(x: .value("Hour", stock.hourOfAgrWindow), y: .value("Price", stock.o))
                        }
                    }
                    .chartYScale(domain: [stockDaily.lowPriceD, stockDaily.highPriceD])
                    .chartXScale(domain: [firstResult.hourOfAgrWindow, lastResult.hourOfAgrWindow])
                }
                
                
                HStack (spacing: 40) {
                    VStack (alignment: .leading) {
                        HStack {
                            Text("Open: ")
                            Spacer()
                            Text(stockDaily.openPriceS)
                        }
                        Divider()
                        HStack {
                            Text("High: ")
                            Spacer()
                            Text(stockDaily.highPriceS)
                        }
                        Divider()
                        HStack {
                            Text("Low: ")
                            Spacer()
                            Text(stockDaily.lowPriceS)
                        }
                    }
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Vol: ")
                            Spacer()
                            Text(stockDaily.volPriceS)
                        }
                        Divider()
                        HStack {
                            Text("VolWeight: ")
                            Spacer()
                            Text(stockDaily.volWeightPriceS)
                        }
                        Divider()
                        HStack {
                            Text("Close: ")
                            Spacer()
                            Text(stockDaily.closePriceS)
                        }
                    }
                }
                if let description = viewModel.stockInfo.description {
                    Text(description)
                }
            }
            .padding(.vertical, 40)
            .padding(.horizontal, 20)
            .onAppear(perform: {
                viewModel.getStockDetails(for: stockDaily.ticker)
            })
        }
    }
}

#Preview {
    StockDetailView(stockDaily: StocksDailyBars(results: [StocksHourlyBars(open: 310.0,
                                                                             close: 340.0,
                                                                             high: 33.0,
                                                                             low: 31.0,
                                                                             volume: 32900800,
                                                                             volumeWeight: 32.9,
                                                                             timestamp: 30303030)],
                                                  ticker: "DIS"))
}
