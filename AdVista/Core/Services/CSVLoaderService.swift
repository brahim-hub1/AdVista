import Foundation

enum CSVLoaderError: LocalizedError {
    case fileNotFound
    case invalidFormat

    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "Fichier CSV introuvable."
        case .invalidFormat:
            return "Format CSV invalide."
        }
    }
}

final class CSVLoaderService {
    func loadCreatives(
        filename: String = "AG1-Data",
        bundle: Bundle = .main
    ) throws -> [AdCreative] {
        guard let url = bundle.url(forResource: filename, withExtension: "csv") else {
            throw CSVLoaderError.fileNotFound
        }

        let raw: String
        do {
            raw = try String(contentsOf: url, encoding: .utf8)
        } catch {
            raw = try String(contentsOf: url, encoding: .isoLatin1)
        }
        let rows = CSVParser.parse(raw)
        guard rows.count > 1 else { return [] }

        let headers = rows[0].enumerated().map { index, header in
            let cleaned = header.trimmingCharacters(in: .whitespacesAndNewlines)
            if index == 0 {
                return cleaned.replacingOccurrences(of: "\u{FEFF}", with: "")
            }
            return cleaned
        }
        let headerIndex = Dictionary(uniqueKeysWithValues: headers.enumerated().map { ($0.element, $0.offset) })

        func value(_ key: String, in row: [String]) -> String {
            guard let index = headerIndex[key], index < row.count else { return "" }
            return row[index].trimmingCharacters(in: .whitespacesAndNewlines)
        }

        return rows.dropFirst().compactMap { row in
            AdCreativeMapper.creative { key in
                value(key, in: row)
            }
        }
    }
}
