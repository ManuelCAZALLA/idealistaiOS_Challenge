//
//  ApiError.swift
//  idealistaiOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 13/2/25.
//

import Foundation

public enum APIError: Error {
    case malformedURL
    case noData
    case decodingFailed
    case unknown
}
