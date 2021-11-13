
class Posicion{
	var property elementosQueTieneCerca = #{}
	
	method validarSiTIeneElemento(elemento) = elementosQueTieneCerca.contains(elemento)	
	
	method obtenerElemento(elemento) = elementosQueTieneCerca.add(elemento)
	
	method eliminarElemento(elemento) = elementosQueTieneCerca.remove(elemento)
	
	
}

class Comensal{
	var property lugar

	var property criterioPersona = sordo
	
	var property criterioComida = vegetariano
	
	var property comidas = []
	
	var property criterioComensal 
	
	
	method pedirElemento(elemento, persona){
		
		if(not persona.lugar() . validarSiTIeneElemento(elemento)){
			throw new DomainException(message = "La persona no tiene ese elemento")
		}
		else{
			
			 (persona.criterioPersona()).generarCambioElemento(self,persona,elemento)
 				
		}
	}

	method comer(comida){
		
		if( not self.validarCriterioComida(comida)){
			
			throw new DomainException(message = "La persona no puede comer debido a su criterio")
		}		
		else{
			 self.registrarComida(comida)
		}
	}
	
	method validarCriterioComida(comida){
		
		return self.criterioComida() . puedoComer(comida)
	}
	
	method registrarComida(comida){
			comidas.add(comida)
	}
	
	
	method pipon(){
		return comidas.any({comidaIngerida=>comidaIngerida.esPesada()})
	}
	
	method pasandoBuenRato(){
		
		return self.cantComidasIngeridas() >0 && self.criterioComensal() . criterio(self)
	}
	
	method cantComidasIngeridas(){
		return comidas.size()
	}
}
const lugarA = new Posicion (elementosQueTieneCerca= [1,2,3])
const lugarB = new Posicion (elementosQueTieneCerca=[4,5,6] )

const alex = new Comensal (lugar=lugarA, criterioPersona=cambiarPosicion, criterioComensal= criterioFacu, criterioComida= vegetariano)
const lean = new Comensal (lugar=lugarB , criterioPersona=sordo, criterioComensal= criterioMoni, criterioComida= dietetico)


// CRITERIOS DE PASAR ELEMENTOS
object sordo{

	method generarCambioElemento(receptor, otorgador, elemento){
		
		receptor. lugar() . obtenerElemento( otorgador. lugar().elementosQueTieneCerca() . head() )
 		
 		otorgador. lugar(). eliminarElemento(otorgador. lugar().elementosQueTieneCerca()  . head() )
	}
}


object todoLosElementos{
	
	method generarCambioElemento(receptor, otorgador, elemento ){
		
		receptor. lugar(). elementosQueTieneCerca(receptor.lugar() . elementosQueTieneCerca() + otorgador.lugar() .elementosQueTieneCerca())
		otorgador. lugar(). elementosQueTieneCerca(null)
	}
}

object cambiarPosicion{
	
	var auxPosicion 
	
	method generarCambioElemento(receptor, otorgador, elemento){
		auxPosicion = receptor. lugar()
		
		receptor.lugar(otorgador.lugar())
		otorgador.lugar(auxPosicion)
		
	}
}


object normal{
				
		method generarCambioElemento(receptor, otorgador, elemento){
		
		receptor. lugar() . obtenerElemento (elemento)
 		
 		otorgador. lugar(). eliminarElemento(elemento)
	}
}

// BANDEJA DE COMIDA
class BandejaComida{
	
		var property calorias 
		const vegetariano = true
		
		method esDeCarne(){
				return not vegetariano
		}
		
		
		method esPesada(){
			return calorias>500
		}		
}

// CRITERIOS PARA COMER 

object vegetariano{
	
	method puedoComer(comida){
		return  not comida.esDeCarne()
	}
}


object dietetico{
	
	method puedoComer(comida){
		return  comida.calorias() < 500
	}
}

object alternado{
	var aleatoridad= false
	
	method puedoComer(comida){
		aleatoridad = not aleatoridad
		return aleatoridad
	}
}

class Combinacion{
		 var criteriosComidaACumplir = #{}
			
		method puedoComer(comida){
			return criteriosComidaACumplir.all({criterioComida=> criterioComida.puedoComer(comida) })
		}
}

//CRITERIO COMENSAL

object criterioOsky{
	
	method criterio(persona){
		return true
	}
}

object criterioMoni{
		
		method criterio(persona){
			return persona.lugar() == 1
		}
}

object criterioFacu{
		
		method criterio(persona){
			return not (persona. comidas()  . filter({comida => comida.esDeCarne()}) ). isEmpty()  //usar any
		}
}

object criterioVero{
		
		method criterio(persona){
				return 3< persona.lugar() . elementosQueTieneCerca()
		}
}