import Foundation
import Alamofire

/// NetworkManager to handle API requests with snake_case support and ready-to-use CRUD functions.
class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://fakestoreapi.com"
    
    private init() {}
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    // MARK: - Request Function
    
    /// Generic request function for any HTTP method with async/await
    private func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        parameters: Encodable? = nil,
        headers: HTTPHeaders? = nil
    ) async throws -> T {
        guard let url = URL(string: "\(baseURL)/\(endpoint)") else {
            throw NetworkError.invalidURL
        }
        
        // Encode parameters if provided
        var encodedParameters: Data? = nil
        if let parameters = parameters {
            do {
                encodedParameters = try encoder.encode(parameters)
            } catch {
                throw error
            }
        }
        
        // Create request
        var urlRequest = URLRequest(url: url)
        urlRequest.method = method
        urlRequest.httpBody = encodedParameters
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let headers = headers {
            for header in headers {
                urlRequest.addValue(header.value, forHTTPHeaderField: header.name)
            }
        }
        
        // Perform the request
        let dataTask = AF.request(urlRequest).validate().serializingDecodable(T.self, decoder: decoder)
        return try await dataTask.value
    }
    
    // MARK: - CRUD Functions
    
    /// Create - POST
    func create<T: Decodable, U: Encodable>(
        endpoint: String,
        parameters: U
    ) async throws -> T {
        try await request(endpoint: endpoint, method: .post, parameters: parameters)
    }
    
    /// Read - GET
    func read<T: Decodable>(
        endpoint: String
    ) async throws -> T {
        try await request(endpoint: endpoint, method: .get)
    }
    
    /// Update - PUT
    func update<T: Decodable, U: Encodable>(
        endpoint: String,
        parameters: U
    ) async throws -> T {
        try await request(endpoint: endpoint, method: .put, parameters: parameters)
    }
    
    /// Delete - DELETE
    func delete<T: Decodable>(
        endpoint: String
    ) async throws -> T {
        try await request(endpoint: endpoint, method: .delete)
    }
}

// MARK: - NetworkError Enum
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
