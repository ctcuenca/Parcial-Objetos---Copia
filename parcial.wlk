
//1) Se debe corregir el metodo "obtenerEstadoDeServicio" pues la implementacion de if/else if
// No es correcta, esto se debe a que, si se quisiera agregar a futuro un nuevo servicio
// Se caeria en un concepto eterno de if "algo" else if "algo" else if "otra cosa" lo cual
// No es coincidente con el paradigma de objetos
object servicioDeUptime {
  const serviciosRegistrados = [
    new ServicioWeb(url="http://localhost:8080", puerto = 8080),
    new BaseDeDatos(puerto=5432)
  ]

  method registrarServicio(servicio) {
    serviciosRegistrados.add(servicio)
  }
// Me permite comprobar en los tests si un servicio esta disponible o no, de una forma sencilla
// para saber si el servicio esta disponible, puedo añadirlo a servicioDeUptime
// y luego consultar si serviciosNoDisponibles esta vacia
// En cambio, si el servicio no esta disponible, puedo añadirlo a servicioDeUptime y consultar
// si el servicio está en serviciosNoDisponibles o no
  method serviciosNoDisponibles() {
        return serviciosRegistrados.filter { servicio => not servicio.estaDisponible() }
    }
// Creado para los tests
  method resetear(){
    serviciosRegistrados.clear()
  }

  method todosLosTests() = serviciosRegistrados

}
// 1) No es correcto que tanto ServicioWeb como baseDeDatos tengan sus variables de tipoServicio
// Pues como tal el tipo al que pertenecen está dado por su clase (Ademas, escribir new ServicioWeb ya implica lo que es)
// A su vez, ese variable fue hecha solo para que obtenerEstadoDeServicio pueda funcionar, como en el inciso
// Anterior se aclara lo incorrecto de ese funcionamiento, simultaneamente tipoServicio tambien esta incorrecta
// Otro punto incorrecto era la falta de herencia, como tanto ServicioWeb como base de datos definen un
// puerto, entonces es mas practico el uso de una clase de la cual ambos luego hereden dicha variable 
class Servicio {
  var property puerto
  method estaDisponible(){
    throw new Exception(message = "El servicio no implementa 'estaDisponible()'")
  }
}
// Aqui se puede ver como ServicioWeb hereda el puerto y luego se le asigna un valor cuando se lo registra
// en servicioDeUptime. Es una forma mas eficiente de tratarlo
class ServicioWeb inherits Servicio { 
  var property url
  var property estadoServicio = "ok"
// Al usar llamarServicio de esta manera, resulta mas eficiente en lugar de anidar multiples if y else if
// Este metodo es mas razonable, pues la unica forma en que ServicioWeb este disponible es que la ruta sea
// "/health", cualquier otro caso seria una ruta no encontrada
  method llamarServicio(ruta) {
        if (ruta == "/health") {
            return estadoServicio
        } else {
            return "ruta no encontrada"
        }
    }

  override method estaDisponible(){
    return self.llamarServicio("/health") == "ok"
  }
}

// 1) Que baseDeDatos sea un objeto implica que la empresa tiene una unica base de datos, esto puede pasar
// pero es raro el caso donde suceda, por ejemplo puede tener una base de datos asociada a los empleados, 
// otra a los clientes, y entonces la empresa no podria monitorear mas de una base, entonces baseDeDatos
// deberia ser una clase, igual que ServicioWeb
// Ademas posee una cantidad de codigo redundante, que por definicion es innecesario y solamente esta
// generando carga extra, como es el caso de obtenerPuerto y setearPuerto
class BaseDeDatos inherits Servicio {
  const datosAlmacenados = []

  method agregarDato(dato){
    datosAlmacenados.add(dato)
  }
  method cantidadDeDatosAlmacenados() = datosAlmacenados.size()

  override method estaDisponible(){
    return not datosAlmacenados.isEmpty()
  }
}

// Nuevo servicio: Cache

class ServicioCache inherits Servicio{
  var property hitRatio = 0

  override method estaDisponible(){
    return hitRatio > 0.3
  }
}