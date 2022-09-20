//
//  ViewController.swift
//  NotasFinalCore
//
//  Created by Isai Abraham on 15/09/22.
//

import UIKit
import CoreData


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
//    Outlet
    
    @IBOutlet weak var tabla: UITableView!
//   Variables
    
    
    
    var notas = [Notas]()
    var fetchResultController : NSFetchedResultsController<Notas>!


    override func viewDidLoad() {
        super.viewDidLoad()
        tabla.delegate = self
        tabla.dataSource = self
        mostrarNotas()
    }
    
//    Tablas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let nota = notas[indexPath.row]
        cell.textLabel?.text = nota.titulo
        cell.detailTextLabel?.text = nota.desc
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Eliminar") { (_, _, _) in
            let contexto = Modelo.shared.contexto()
            let borrar = self.fetchResultController.object(at: indexPath)
            self.showAlert(message: "Se elimino")
            contexto.delete(borrar)
            
            
        }
       
        delete.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "enviar", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enviar" {
            if let id = tabla.indexPathForSelectedRow{
                let fila = notas[id.row]
                let destino = segue.destination as! ViewControllerSegundaPantalla
                destino.notas = fila
            }
        }
    }
    
    
    
    // NSFETCHEDRESULT
    func mostrarNotas(){
        let contexto = Modelo.shared.contexto()
        let fetchRequest :NSFetchRequest<Notas> = Notas.fetchRequest()
        let order = NSSortDescriptor(key: "titulo", ascending: true)
        fetchRequest.sortDescriptors = [order]
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: contexto, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        
        do {
            try fetchResultController.performFetch()
            notas = fetchResultController.fetchedObjects!
        } catch let error as NSError {
            print("No mostro nada", error.localizedDescription)
        }
        
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tabla.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tabla.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            self.tabla.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            self.tabla.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            self.tabla.reloadRows(at: [indexPath!], with: .fade)
        default:
            self.tabla.reloadData()
        }
        self.notas = controller.fetchedObjects as! [Notas]
    }
    func showAlert(message: String){
        let alert = UIAlertController(title: "AVISO", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ENTENDIDO", style: .default, handler: nil))
        present(alert,animated: true, completion: nil)
 
    }
    
}
