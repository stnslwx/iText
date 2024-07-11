//  DatabaseManager.swift
//  iText
//  Created by Stanislaw Astashenko on 11/07/2024.

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    public func testDB(){
        database.child("testDB").setValue(["someTest": true])
    }
}
