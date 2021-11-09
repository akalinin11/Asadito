
// comensal que sabe su posicion y los elementos que tiene cerca 
// cada comensal tiene un criterio sordo-todos los elementos-cambiarPosicion- normales
// toda la pinta a composicion
// cuando paso el elemento deja de estar cerca



// bandeja con UNA comida, te dice si es de carne y las cantidade de calorias
// persona decide si comer depende de: vegetariano-dietetico-alternado-combinacion de condiciones
// tambien parece que es composicion 



// pipon mensaje a comensal si alguna de las comidas que ingirio es pesada>500



// saber si un comensal la paso bien que depende de ciertas cuestiones


//Teorica 

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
			
			 (persona.criterioPersona()).hacerEfecto(self,persona,elemento)
 				
		}
	}

	method comer(comida){
		
		if(self.validarCriterioComida(comida)){
			
			self.registrarComida(comida)
		}
		
		else{
			throw new DomainException(message = "La persona no puede comer debido a su criterio")
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
		
		return comidas.size()>0 && self.criterioComensal() . criterio(self)
	// DELEGAR ESTEO EN UN METHOD
	}
}
const lugarA = new Posicion (elementosQueTieneCerca= [1,2,3])
const lugarB = new Posicion (elementosQueTieneCerca=[4,5,6] )

const alex = new Comensal (lugar=lugarA, criterioPersona=cambiarPosicion, criterioComensal= facu, criterioComida= vegetariano)
const lean = new Comensal (lugar=lugarB , criterioPersona=sordo, criterioComensal= moni, criterioComida= dietetico)


// CRITERIOS DE PASAR ELEMENTOS
object sordo{

	method hacerEfecto(receptor, otorgador, elemento){
		
		receptor. lugar() . obtenerElemento( otorgador. lugar().elementosQueTieneCerca() . head() )
 		
 		otorgador. lugar(). eliminarElemento(otorgador. lugar().elementosQueTieneCerca()  . head() )
	}
}


object todoLosElementos{
	
	method hacerEfecto(receptor, otorgador, elemento ){
		
		receptor. lugar(). elementosQueTieneCerca(receptor.lugar() . elementosQueTieneCerca() + otorgador.lugar() .elementosQueTieneCerca())
		otorgador. lugar(). elementosQueTieneCerca(null)
	}
}

object cambiarPosicion{
	
	var auxPosicion 
	
	method hacerEfecto(receptor, otorgador, elemento){
		auxPosicion = receptor. lugar()
		
		receptor.lugar(otorgador.lugar())
		otorgador.lugar(auxPosicion)
		
	}
}


object normal{
				
		method hacerEfecto(receptor, otorgador, elemento){
		
		receptor. lugar() . obtenerElemento (elemento)
 		
 		otorgador. lugar(). eliminarElemento(elemento)
	}
}

// BANDEJA DE COMIDA
class BandejaComida{
		var productos= []  //CORREGIR hacer una variable si es vegetariano o no 
		var property calorias 
		
		method esDeCarne(){
				return productos.contains("carne")
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
	const criteriosComida = #{dietetico, vegetariano, self}  // AL AZAR ES UNO SI UNO NO 
	
	method puedoComer(comida){
		criteriosComida.anyOne() . puedoComer(comida)
	}
}

class Combinacion{
		 var criteriosComidaACumplir = #{}
		
		
		method puedoComer(comida){
			return criteriosComidaACumplir.all({criterioComida=> criterioComida.puedoComer(comida) })
		}
}

//CRITERIO COMENSAL

object osky{
	
	method criterio(persona){
		return true
	}
}

object moni{
		
		method criterio(persona){
			return persona.lugar() == 1
		}
}

object facu{
		
		method criterio(persona){
			return not (persona. comidas()  . filter({comida => comida.esDeCarne()}) ). isEmpty()
		}
}

object vero{
		
		method criterio(persona){
				return 3< persona.lugar() . elementosQueTieneCerca()
		}
}