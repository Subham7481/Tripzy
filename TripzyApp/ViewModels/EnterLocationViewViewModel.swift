import Foundation
import Combine

class EnterLocationViewViewModel: ObservableObject {
    @Published var startLocation: String = ""
    @Published var endLocation: String = ""
    @Published var locationSuggestions: [String] = [] // Store location suggestions
    @Published var calculatedAmount: Double? = nil
    @Published var errorMessage: String? = nil

    private var cancellables = Set<AnyCancellable>()
    private let hereAPIKey = "f1XQxM1L4gtxiqbQMUyRXMrS0bJEPmmgdbPmzKZICpQ"

    // Function to fetch location suggestions
    func fetchSuggestions(for query: String) {
        guard !query.isEmpty else {
            locationSuggestions = []
            return
        }

        // Ensure that the query is encoded correctly
        let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        // Update URL to restrict results to Delhi, India (specifying the country filter)
        let urlString = "https://geocode.search.hereapi.com/v1/geocode?q=\(queryEncoded)%2C%20India&apiKey=\(self.hereAPIKey)"
        
        guard let url = URL(string: urlString) else { return }

        // Fetch data using Combine's dataTaskPublisher
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: HerePlacesResponse.self, decoder: JSONDecoder())
            .replaceError(with: HerePlacesResponse(items: []))
            .map { $0.items.map { $0.title } }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] suggestions in
                self?.locationSuggestions = suggestions
            }
            .store(in: &cancellables)
    }

    // Function to get coordinates for a location
    private func getCoordinates(for location: String, completion: @escaping (Position?) -> Void) {
        let encodedLocation = location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://geocode.search.hereapi.com/v1/geocode?q=Delhi&apiKey=f1XQxM1L4gtxiqbQMUyRXMrS0bJEPmmgdbPmzKZICpQ"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching coordinates: \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                completion(nil)
                return
            }

            do {
                let response = try JSONDecoder().decode(HerePlacesResponse.self, from: data)
                if let firstPlace = response.items.first {
                    completion(firstPlace.position)
                } else {
                    completion(nil)
                }
            } catch {
                print("Error decoding coordinates response: \(error)")
                completion(nil)
            }
        }.resume()
    }

    // Function to calculate distance using HERE Routing API
    private func calculateDistance(from start: String, to end: String, completion: @escaping (Double?) -> Void) {
        getCoordinates(for: start) { startCoordinates in
            guard let startCoordinates = startCoordinates else {
                completion(nil)
                return
            }

            self.getCoordinates(for: end) { endCoordinates in
                guard let endCoordinates = endCoordinates else {
                    completion(nil)
                    return
                }

                // Construct the URL for HERE Routing API with coordinates
                let urlString = "https://router.hereapi.com/v8/routes?transportMode=car&origin=\(startCoordinates)&destination=\(endCoordinates)&apiKey=\(self.hereAPIKey)"
                
                guard let url = URL(string: urlString) else {
                    completion(nil)
                    return
                }

                // Fetch the route data and extract the distance
                URLSession.shared.dataTask(with: url) { data, _, error in
                    if let error = error {
                        print("Error fetching distance: \(error)")
                        completion(nil)
                        return
                    }

                    guard let data = data else {
                        completion(nil)
                        return
                    }

                    do {
                        let response = try JSONDecoder().decode(HereRoutingResponse.self, from: data)
                        let distanceInMeters = response.routes.first?.sections.first?.summary.length ?? 0
                        let distanceInKm = Double(distanceInMeters) / 1000.0 // Convert to kilometers
                        completion(distanceInKm)
                    } catch {
                        print("Error decoding distance response: \(error)")
                        completion(nil)
                    }
                }.resume()
            }
        }
    }

    // Function to calculate fare based on distance
    private func calculateFare(for distance: Double) -> Double {
        let baseFare = 50.0
        let perKmRate = 10.0
        return baseFare + (distance * perKmRate)
    }

    // Validate and calculate amount
    func calculateAmount() {
        guard !startLocation.isEmpty, !endLocation.isEmpty else {
            errorMessage = "Please select both start and end locations."
            return
        }

        errorMessage = nil
        calculateDistance(from: startLocation, to: endLocation) { [weak self] distance in
            DispatchQueue.main.async {
                if let distance = distance {
                    self?.calculatedAmount = self?.calculateFare(for: distance)
                } else {
                    self?.errorMessage = "Unable to calculate distance."
                }
            }
        }
    }
}

// MARK: - HERE API Response Models
struct HerePlacesResponse: Codable {
    let items: [HerePlace]
}

struct HerePlace: Codable {
    let title: String
    let position: Position
}

struct Position: Codable {
    let lat: Double
    let lng: Double
}

struct HereRoutingResponse: Codable {
    let routes: [Route]
}

struct Route: Codable {
    let sections: [Section]
}

struct Section: Codable {
    let summary: Summary
}

struct Summary: Codable {
    let length: Int // Distance in meters
}
