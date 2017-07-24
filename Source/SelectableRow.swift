//
//  SelectableRow.swift
//  QuickTableViewController-iOS
//
//  Created by Joe Bay on 7/24/17.
//  Copyright © 2017 bcylin. All rights reserved.
//

import Foundation

/// A struct that represents a row that perfoms navigation when seleced.
public struct SelectableRow: Row, Equatable, IconEnabled {
  
  /// The title text of the row.
  public var title: String = ""
  
  /// The subtitle text of the row.
  public var subtitle: Subtitle?
  
  /// The icon of the row.
  public var icon: Icon?
  
  /// Returns **SelectableRow** as the reuse identifier of the table view cell to display the row.
  public let cellReuseIdentifier: String = "SelectableRow"//NSStringFromClass(SelectableRow.self)

  /// A closure related to the navigation when the row is selected.
  public var action: ((Row) -> Void)?
  
  /// Selection
  public var isSelected = false

  /// Create the cell to be used in the table view.
  public func cell(forTableView tableView: UITableView) -> UITableViewCell? {
    var cell = defaultCell(forTableView: tableView)
    
    if let subtitle = subtitle {
      switch subtitle {
      case .none:
        cell = cell ?? UITableViewCell(style: .default, reuseIdentifier: subtitle.style)
      case .belowTitle:
        cell = cell ?? UITableViewCell(style: .subtitle, reuseIdentifier: subtitle.style)
      case .rightAligned:
        cell = cell ?? UITableViewCell(style: .value1, reuseIdentifier: subtitle.style)
      case .leftAligned:
        cell = cell ?? UITableViewCell(style: .value2, reuseIdentifier: subtitle.style)
      }
      cell?.detailTextLabel?.text = subtitle.text
    }
    cell?.accessoryType = isSelected ? .checkmark : .none
    
    postCellSetup(forCell: cell)
    
    return cell
  }
  
    /// Indicates that row should highlight.
    public var shouldHighlight: Bool {
        return true
    }
    
    
  ///
  public init(title: String, subtitle: Subtitle, icon: Icon? = nil, action: ((Row) -> Void)? = nil, isSelected: Bool = false) {
    self.title = title
    self.subtitle = subtitle
    self.icon = icon
    self.action = action
    self.isSelected = isSelected
  }
  
  private init() {}
  
  // MARK: Equatable
  
  /// Returns true iff `lhs` and `rhs` have equal titles, subtitles and icons.
  public static func == (lhs: SelectableRow, rhs: SelectableRow) -> Bool {
    return lhs.title == rhs.title && lhs.subtitle == rhs.subtitle && lhs.icon == rhs.icon && lhs.isSelected == rhs.isSelected
  }
  
}

