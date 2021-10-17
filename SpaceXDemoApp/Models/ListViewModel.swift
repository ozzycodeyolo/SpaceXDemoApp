//
//  ListViewModel.swift
//  SpaceXDemoApp
//
//  Created by Jan Kučera on 16.10.2021.
//

import SwiftUI
import Alamofire


final class ListViewModel: ObservableObject {
    
    
    @AppStorage("sortingOrder") var sortingOrder: Int = 1
    
    @Published var launches: [LaunchModel] = [LaunchModel]()
    @Published var textForSearching: String = ""
    
    private let networkManager: NetworkManager = NetworkManager()
    
    
    init() {
        downloadLaunches()
    }
    
    
}


extension ListViewModel {
    
    func downloadLaunches() {
        networkManager.downloadPastLaunches { launches in
            guard let newLaunches = launches else { return }
            self.launches = self.sortLaunches(newLaunches)
        }
    }
    
}

extension ListViewModel {
    
    func sortLaunches(by key: Int) {
        sortingOrder = key
        launches = sortLaunches(launches)
    }
    
    private func sortLaunches(_ givenLaunches: [LaunchModel]) -> [LaunchModel] {
        switch sortingOrder {
        case 0:
            return givenLaunches.sorted { $0.name < $1.name }
        case 1:
            return givenLaunches.sorted { $0.dateUTC < $1.dateUTC }
        default:
            return givenLaunches.sorted { $0.name < $1.name }
        }
    }
    
}
