class Viaje{
    const property idiomas = #{}    
   
    method implicaEsfuerzo()
    method broncearse() 
    method diasDeViaje()
    method idiomasQueSeHablan() = idiomas
    method viajeInteresante() = idiomas.size() > 1
    method agregarIdioma(idioma){
        idiomas.add(idioma)
    }
}
class ViajeDePlaya inherits Viaje{
    const largo
    override method diasDeViaje() = self.largo()/500
    override method implicaEsfuerzo() = self.largo() > 1200
    method largo() = largo
    override method broncearse() = true
}
class Ciudad inherits Viaje{
    var property atracciones

    method cantidadDeAtracciones() = atracciones
    override method viajeInteresante() = super() || self.cantidadDeAtracciones() == 5
    override method diasDeViaje() = self.cantidadDeAtracciones()/2
    override method implicaEsfuerzo() = self.cantidadDeAtracciones().between(5, 8)
    override method broncearse() = false
}
class CiudadTropical inherits Ciudad{
    
    override method diasDeViaje() = super() + 1    
    override method broncearse() = true
}
class SalidaDeTrekking inherits Viaje{
    var kilometros
    var diasDeSol
    method kilometros() = kilometros
    method diasDeSol() = diasDeSol
    override method viajeInteresante() = super() && self.diasDeSol() > 140
    override method diasDeViaje() = self.kilometros()/50
    override method implicaEsfuerzo() = self.kilometros() > 80
    override method broncearse() = self.diasDeSol() > 200 || (self.diasDeSol().between(100, 200) && self.kilometros() > 120)

}
class Gimnasia inherits Viaje{
    override method idiomasQueSeHablan() = #{ "Español" }
    override method diasDeViaje() = 1
    override method implicaEsfuerzo() = true
    override method broncearse() = false
}
       
    
