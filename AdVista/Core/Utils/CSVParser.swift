import Foundation

enum CSVParser {
    static func parse(_ text: String) -> [[String]] {
        var rows: [[String]] = []
        var row: [String] = []
        var field = ""
        var inQuotes = false

        var iterator = text.makeIterator()
        var current = iterator.next()

        while let char = current {
            if inQuotes {
                if char == "\"" {
                    let nextChar = iterator.next()
                    if nextChar == "\"" {
                        field.append("\"")
                        current = iterator.next()
                        continue
                    } else {
                        inQuotes = false
                        current = nextChar
                        continue
                    }
                } else {
                    field.append(char)
                }
            } else {
                switch char {
                case "\"":
                    inQuotes = true
                case ",":
                    row.append(field)
                    field = ""
                case "\n":
                    row.append(field)
                    rows.append(row)
                    row = []
                    field = ""
                case "\r":
                    break
                default:
                    field.append(char)
                }
            }
            current = iterator.next()
        }

        if !field.isEmpty || !row.isEmpty {
            row.append(field)
            rows.append(row)
        }

        return rows
    }
}
