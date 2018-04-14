//
//  DateFormatter+UI.swift
//  ParticleBox
//
//  Created by Michal Ciurus on 13/04/2018.
//  Copyright © 2018 michalciurus. All rights reserved.
//

import Foundation

extension DateFormatter {
    static func UIFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
}
