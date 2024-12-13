//
//  CurrentWeatherDetailView.swift
//  Home
//
//  Created by Wilson Desimini on 12/13/24.
//

import SwiftUI
import Models

struct CurrentWeatherDetailView: View {
    let viewModel: CurrentWeatherDetailViewModel

    var body: some View {
        VStack {
            AsyncImage(url: viewModel.iconURL)
            HStack {
                Text(viewModel.nameText)
                    .font(.title)
                Image(systemName: "location.fill")
            }
            Text(viewModel.tempText)
                .font(.largeTitle)
            HStack {
                VStack {
                    Text("Humidity")
                    Text(viewModel.humidityText)
                }
                VStack {
                    Text("UV")
                    Text(viewModel.uvText)
                }
                VStack {
                    Text("Feels Like")
                    Text(viewModel.feelslikeText)
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(15)
            Spacer()
        }
    }
}

#Preview {
    CurrentWeatherDetailView(
        viewModel: .init(
            weather: .init(
                location: .init(name: "San Francisco", region: "California", country: "United States", lat: 37.77, lon: -122.41, tzId: "America/Los_Angeles", localtimeEpoch: 1639358470, localtime: "2021-12-13 13:41"),
                current: .init(lastUpdatedEpoch: 0, lastUpdated: "", tempC: 0, tempF: 31, isDay: 0, condition: .init(text: "", icon: "//cdn.weatherapi.com/weather/64x64/day/296.png", code: 1183), windMph: 0, windKph: 0, windDegree: 0, windDir: "", pressureMb: 0, pressureIn: 0, precipMm: 0, precipIn: 0, humidity: 0, cloud: 0, feelslikeC: 0, feelslikeF: 0, windchillC: 0, windchillF: 0, heatindexC: 0, heatindexF: 0, dewpointC: 0, dewpointF: 0, visKm: 0, visMiles: 0, uv: 0, gustMph: 0, gustKph: 0)
            )
        )
    )
}
