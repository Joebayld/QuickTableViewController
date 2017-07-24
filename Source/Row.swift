//
//  Row.swift
//  QuickTableViewController
//
//  Created by Ben on 01/09/2015.
//  Copyright (c) 2015 bcylin.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation

/// Any type that conforms to this protocol is capable of representing a row in a table view.
public protocol Row {
  /// The title text of the row.
  var title: String { get }
  /// The subtitle text of the row.
  var subtitle: Subtitle? { get }
  /// The reuse identifier of the table view cell to display the row.
  var cellReuseIdentifier: String { get }
  /// A closure related to the action of the row.
  var action: ((Row) -> Void)? { get }
  
  /// Generate the table cell for the given tableView
  func cell(forTableView tableView: UITableView) -> UITableViewCell?
    
  /// table options
    var shouldKeepSelection: Bool { get}
    var shouldHighlight: Bool { get }
}

extension Row {
  
    public var shouldKeepSelection: Bool { return false }
    public var shouldHighlight: Bool { return false }
  
  internal func defaultCell(forTableView tableView: UITableView) -> UITableViewCell? {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)
    return cell
  }
  
  internal func postCellSetup(forCell cell: UITableViewCell?) {
    cell?.textLabel?.text = title
    
    if let icon = (self as? IconEnabled)?.icon {
      if let image = icon.image {
        cell?.imageView?.image = image
      }
      if let image = icon.highlightedImage {
        cell?.imageView?.highlightedImage = image
      }
    }
  }
  
}


extension Row {

  /// Returns true iff `lhs` and `rhs` have equal titles and subtitles.
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.title == rhs.title && lhs.subtitle == rhs.subtitle
  }

}
