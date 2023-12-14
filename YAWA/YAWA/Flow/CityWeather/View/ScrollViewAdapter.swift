//
//  ScrollViewAdapter.swift
//  YAWA
//
//  Created by Bassist Zero on 12/14/23.
//

import UIKit

protocol ScrollViewAdapterDelegate: AnyObject { }

class ScrollViewAdapter: NSObject {

    weak var delegate: ScrollViewAdapterDelegate?

}
