//
//  Modelo.swift
//  NotasFinalCore
//
//  Created by Isai Abraham on 19/09/22.
//

import Foundation
import CoreData
import UIKit

class Modelo {
    
    public static let shared = Modelo()
    
    func contexto() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    func saveData(titulo: String, desc: String){
        
        let context = contexto()
        let entityNotas = NSEntityDescription.insertNewObject(forEntityName: "Notas", into: context) as! Notas
        entityNotas.titulo = titulo
        entityNotas.desc = desc
        
        
        do {
            try context.save()
            print("guardo")
        } catch let error as NSError {
            print("no guardo", error.localizedDescription)
        }
        
    }
    
    func editData(titulo: String, desc: String, notas: Notas){
        
        let context = contexto()
        notas.setValue(titulo, forKey: "titulo")
        notas.setValue(desc, forKey: "desc")
        
        
        do {
            try context.save()
            print("edito")
        } catch let error as NSError {
            print("no edito", error.localizedDescription)
        }
        
    }
    
}

