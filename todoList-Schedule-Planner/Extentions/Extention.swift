//
//  Extention.swift
//  todoList-Schedule-Planner
//
//  Created by admin on 30/11/2023.
//

import SwiftUI
import Foundation

extension Encodable {
    func asDictionary() -> [String:Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
        } catch {
            return [:]
        }
    }
    
    func saveToFile(_ filePath: URL) throws {
        let dictionary = self.asDictionary()
        let jsonData = try JSONSerialization.data(withJSONObject: dictionary )
        try jsonData.write(to: filePath)
    }
}

extension Decodable {
    static func fromDictionary(_ dictionary: [String: Any]?) -> Self? {
        guard let data = try? JSONSerialization.data(withJSONObject: dictionary ?? [:]) else { return nil }
        do {
            let decodedObject = try JSONDecoder().decode(Self.self, from: data)
            return decodedObject
        } catch {
            return nil
        }
    }
    
    static func loadFromFile(_ filePath: URL) throws -> Self? {
        let data = try Data(contentsOf: filePath)
        let dictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        return Self.fromDictionary(dictionary)
    }
}

extension View {
    
    func hAlign(_ aligment: Alignment) -> some View {
        self.frame(maxWidth: .infinity, alignment: aligment)
    }
    
    func vAlign(_ aligment: Alignment) -> some View {
        self.frame(maxHeight: .infinity, alignment: aligment)
    }
}


enum Ubuntu {
    case light
    case lightItalic
    case italic
    case bold
    case boldItalic
    case medium
    case mediumItalic
    case regular
    
    var weight: Font.Weight {
        switch self {
        case .light:
            return .light
        case .lightItalic:
            return .light
        case .italic:
            return .medium
        case .bold:
            return .bold
        case .boldItalic:
            return .bold
        case .medium:
            return .medium
        case .mediumItalic:
            return .medium
        case .regular:
            return .regular
        }
    }
}

extension View {
    func ubuntu(_ size: CGFloat, weight: Ubuntu) -> some View {
        self
            .font(.custom("Ubuntu", size: size))
            .fontWeight(weight.weight)
    }
}

extension Date {
    func toString(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension TimeInterval {
    func formattedDateString(_ stringFormart: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = stringFormart
        
        let date = Date(timeIntervalSince1970: self)
        return dateFormatter.string(from: date)
    }
}

extension VerticalAlignment {
    enum CustomAlignment: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }

    static let customAlignment = VerticalAlignment(CustomAlignment.self)
}

extension View {
    func innerShadow<S: Shape, SS: ShapeStyle>(shape: S, color: SS, lineWidth: CGFloat = 1, offsetX: CGFloat = 0, offsetY: CGFloat = 0, blur: CGFloat = 4, blendMode: BlendMode = .normal, opacity: Double = 1) -> some View {
        return self
            .overlay {
                shape
                    .stroke(color, lineWidth: lineWidth)
                    .blendMode(blendMode)
                    .offset(x: offsetX, y: offsetY)
                    .blur(radius: blur)
                    .mask(shape)
                    .opacity(opacity)
            }
    }
}

extension NSObject{
    
    public static var classIdentifier: String {
        return String(describing: self)
    }
}
