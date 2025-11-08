import viajes.*
class Mutual {
    var actividadesDisponibles = #{}
    var sociosRegistrados = #{}

    method agregarActividad(unaActividad) {
        actividadesDisponibles.add(unaActividad)
    }

    method registrarSocio(unSocio) {
        sociosRegistrados.add(unSocio)
    }

    method recomendarPara(unSocio) =
        actividadesDisponibles.filter({a => a.actividadRecomendadaParaSocio(unSocio)})

    method actividadesEsforzadasPara(unSocio) =
        self.recomendarPara(unSocio).filter({a => a.implicaEsfuerzo()})

    method actividadesQueBronceanPara(unSocio) =
        self.recomendarPara(unSocio).filter({a => a.broncearse()})

    method actividadesPorIdioma(idioma) =
        actividadesDisponibles.filter({a => a.idiomasQueSeHablan().contains(idioma)})
}