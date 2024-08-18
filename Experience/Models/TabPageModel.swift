//
//  TabPageModel.swift
//  Experience
//
//  Created by Adrien Surugue on 17/08/2024.
//

import Foundation
import SwiftUI

enum TabPageModel: String, CaseIterable {
    case page1 
    case page2
    case page3

    var title: String {
        switch self {
        case .page1:
            return "BAD"
        case .page2:
            return "NOT BAD"
        case .page3:
            return "GOOD"
        }
    }

    var index: Int {
        switch self {
        case .page1:
            return 0
        case .page2:
            return 1
        case .page3:
            return 2
        }
    }

    var color: Color {
        switch self {
        case .page1:
            return .red
        case .page2:
            return .yellow
        case .page3:
            return .green
        }
    }
}
