//
//  ShowsError.swift
//  SharedTools
//
//  Created by Michal Ciurus on 13/04/2018.
//  Copyright © 2018 michalciurus. All rights reserved.
//

import Foundation

public protocol EmitsError {
    var errorEvent: EventObservable<String> { get }
}
