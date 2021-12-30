//
//  ImagePickerDelegate.swift
//  Sport
//
//  Created by admin on 29/12/2021.
//

import Foundation
import UIKit

protocol ImagePickerDelegate: AnyObject {
    func pickImage(indexPath:IndexPath)
}
