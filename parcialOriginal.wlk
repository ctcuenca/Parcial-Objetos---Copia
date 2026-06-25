object servicioDeUptime {
  const serviciosRegistrados = [
    new ServicioWeb(url="http://localhost:8080"),
    baseDeDatos
  ]

  method registrarServicio(servicio) {
    serviciosRegistrados.add(servicio)
  }

  method obtenerEstadoDeServicio(tipoServicio) {
    if (tipoServicio == "web") {
      const servicioWeb = serviciosRegistrados.find({s => s.tipoServicio() == "web"})
      return servicioWeb.llamarServicio("/health")
    } else if (tipoServicio == "base de datos") {
      const servicioBaseDeDatos = serviciosRegistrados.find({s => s.tipoServicio() == "base de datos"})
      return servicioBaseDeDatos.cantidadDeDatosAlmacenados() > 0
    } else {
      return "ruta no encontrada"
    }
  }
}

class ServicioWeb { 
  var tipoServicio = "web"
  var property puerto = 8080
  var property url
  var property estadoServicio = "ok"

  method setearTipoServicio(tipo) {
    tipoServicio = tipo
  }

  method obtenerTipoServicio() = tipoServicio

  method llamarServicio(ruta) {
    if (ruta == "/holamundo") {
      return "hola mundo"
    } else if (ruta == "/health") {
      return estadoServicio
    } else {
      return "ruta no encontrada"
    }
  }
}

object baseDeDatos {
  var puerto = 5432
  var property tipoServicio = "base de datos"
  var property datosAlmacenados = []

  method agregarDato(dato) {
    datosAlmacenados.add(dato)
  }
  method cantidadDeDatosAlmacenados() = datosAlmacenados.size()

  method obtenerTipoServicio() = tipoServicio

  method obtenerPuerto() = puerto 

  method setearPuerto(nuevoPuerto) {
    puerto = nuevoPuerto
  }
}