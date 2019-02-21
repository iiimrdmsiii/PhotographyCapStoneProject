//
//  DateFormatter.swift
//  CapStone Project (Photographer)
//
//  Created by Dallin Smuin on 2/21/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import Foundation

struct DOBDateFormatter: Codable {

    var DOB: Date
    
    static let dateOfBirthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()

}
