/* 
### 6. Actividades recomendadas para socios
Agregar la posibilidad de preguntar, para una actividad, si es recomendada para un socio o no.

Para los **viajes**, se deben cumplir tres condiciones: que la actividad sea interesante, que le atraiga al socio, y que el socio no haya realizado ya la misma actividad.

Para las **clases de gimnasia**, la condición es que el socio tenga entre 20 y 30 años. 

<br>
*/

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
    method actividadRecomendadaParaSocio(unSocio){
        return self.viajeInteresante() && unSocio.leAtrae(self) && !unSocio.actividadesRealizadas().contains(self)
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
    override method actividadRecomendadaParaSocio(unSocio){
        return unSocio.edad().between(20,30) && !unSocio.actividadesRealizadas().contains(self)
    }
}
class TallerLiterario inherits Viaje{
    const libros = #{}
    var seTrabajaConLibros
    var cantPaginas
    var idiomaDelLibro
    var cantLibros
    const idiomasUsados = #{}
    var property autor
    method libros() = libros
    
    method losLibrosSonDe() = seTrabajaConLibros
    method idiomasUsados() = idiomasUsados
    method cantidadDePaginas() = cantPaginas
    method idiomaDelLibro() = idiomaDelLibro
    method cantidadDeLibros() = cantLibros
   override method diasDeViaje() = self.cantidadDeLibros() + 1
    override method implicaEsfuerzo() = libros.any({l => l.cantidadDePaginas() > 500})|| (libros.all({l => l.autor() == self.autor()}) && libros.size() > 1)
    override method broncearse() = false
    override method idiomasQueSeHablan() = idiomasUsados
    override method actividadRecomendadaParaSocio(unSocio){
        return unSocio.idiomasQueHabla().size() > 1
    }
}



class Socio {
    var edad
    var actividadesPermitidas
    var tipoDeSocio // sera el objeto de tipo de Socio
    const idiomasQueHabla = #{}
    const actividades = #{} // conjunto para evitar duplicados

    method cantidadDeActividades() = actividades.size()
    method esAdoradorDelSol() = actividades.all({a => a.broncearse()})
    method puedeAgregarActividad() = self.cantidadDeActividades() < actividadesPermitidas
    method actividadesRealizadas() = actividades
    method edad() = edad
    method idiomasQueHabla() = idiomasQueHabla
    method actividadesEsforzadas() = actividades.filter({a => a.implicaEsfuerzo()}).asSet()

    method realizarActividad(unaActividad) {
        if (!self.puedeAgregarActividad()) {
            self.error("No se pueden realizar más actividades")
        }
        actividades.add(unaActividad)
    }

    method leAtrae(unaActividad) = tipoDeSocio.aElSocio_leAtrae_(self, unaActividad)
}
object socioTranquilo{
    method aElSocio_leAtrae_(unSocio, unaActividad) = unaActividad.diasDeViaje() >= 4
}
object socioCoherente{
    method aElSocio_leAtrae_(unSocio, unaActividad){
        if(unSocio.esAdoradorDelSol() && unaActividad.broncearse()){
            return true
        }
        return unaActividad.implicaEsfuerzo()
    } 
}
/*si es un **socio relajado**, la condición es hablar al menos uno de los
 idiomas que se usan en la actividad. P.ej. si un socio relajado habla español
  y quechua, entonces una actividad en español le va a atraer, una en quechua
  y aymará también, una en francés e italiano no. */
object socioRelajado{
    method aElSocio_leAtrae_(unSocio, unaActividad){
        return !(unSocio.idiomasQueHabla().intersect(unaActividad.idiomasQueSeHablan()).isEmpty())
    }
}
       
    
