//
//  ViewControllerSegundaPantalla.swift
//  NotasFinalCore
//
//  Created by Isai Abraham on 15/09/22.
//

import UIKit

class ViewControllerSegundaPantalla: UIViewController {

    @IBOutlet weak var boton: UIBarButtonItem!
    @IBOutlet weak var TituloNota: UITextField!
    @IBOutlet weak var DescNota: UITextView!
    
    var notas : Notas?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = notas != nil ? "Editar nota" : "Crear nota"
        TituloNota.text = notas?.titulo
        DescNota.text = notas?.desc

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Guardar(_ sender: Any) {
        
        
        
        if notas != nil {
            Modelo.shared.editData(titulo: TituloNota.text ?? " ", desc: DescNota.text, notas: notas!)
            navigationController?.popViewController(animated: true)
        }else{
            Modelo.shared.saveData(titulo: TituloNota.text ?? "", desc: DescNota.text)
            navigationController?.popViewController(animated: true)
        }
    }
    func validarText(){
        boton.isEnabled = false
        
        TituloNota.addTarget(self, action: #selector(validarTextField), for: .editingChanged)
    }
    
    func validarText2(){
        TituloNota.addTarget(self, action: #selector(validarTextField), for: .editingChanged)
    }
    
    
    @objc func validarTextField(sender: UITextField){
        guard let titulo2 = TituloNota.text, !titulo2.isEmpty else{
            boton.isEnabled = false
            
            return
        }
        boton.isEnabled = true
       
        
    }
     
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "AVISO", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ENTENDIDO", style: .default, handler: nil))
        present(alert,animated: true, completion: nil)
 
    }

}
