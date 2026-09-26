import 'package:flutter/material.dart';

void main() {
  runApp(const CalendarApp());
}

// StatelessWidget se utiliza cuando la interfaz no necesita cambiar
// su estado durante la ejecución de la aplicación.
class CalendarApp extends StatelessWidget {
  const CalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calendario Nocturno',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
      ),
      home: const CalendarPage(),
    );
  }
}

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  // static const permite crear valores constantes que pertenecen
  // a esta clase y que serán reutilizados en diferentes partes
  // del diseño.
  static const Color background = Color(0xFF07111F);
  static const Color card = Color(0xFF0D1B2E);
  static const Color cardLight = Color(0xFF13243A);
  static const Color primary = Color(0xFF8B7CFF);
  static const Color secondary = Color(0xFF58C7FF);
  static const Color textPrimary = Color(0xFFF4F7FF);
  static const Color textSecondary = Color(0xFF8796AC);

  // =========================================================
  // DÍA DEL CALENDARIO
  // =========================================================

  // Método reutilizable para construir cada casilla del calendario.
  // Los parámetros permiten cambiar el número, el estado del día
  // y si contiene un evento sin repetir todo el diseño.
  Widget buildDay({
    // required indica que este dato es obligatorio al utilizar
    // el método.
    required String day,

    // Estos parámetros tienen valores predeterminados y permiten
    // personalizar cada día según sea necesario.
    bool isToday = false,
    bool hasEvent = false,
    Color eventColor = secondary,
    bool isOtherMonth = false,
  }) {
    // Expanded hace que cada día ocupe proporcionalmente el
    // espacio disponible dentro del Row.
    return Expanded(
      child: Container(
        height: 70,
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: isToday
              ? primary
              : isOtherMonth
                  ? const Color(0xFF091625)
                  : card,

          // BoxDecoration permite personalizar visualmente un
          // Container mediante colores, bordes, esquinas y sombras.
          borderRadius: BorderRadius.circular(12),

          border: Border.all(
            color: isToday
                ? primary
                : Colors.white.withValues(alpha: 0.06),
          ),

          // El operador ternario permite decidir si se agrega
          // una sombra dependiendo de si el día está destacado.
          boxShadow: isToday
              ? [
                  BoxShadow(
                    color: primary.withValues(alpha: 0.35),
                    blurRadius: 14,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),

        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                day,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isToday
                      ? Colors.white
                      : isOtherMonth
                          ? textSecondary.withValues(alpha: 0.4)
                          : textPrimary,
                ),
              ),

              // Spacer ocupa el espacio disponible y permite
              // colocar el indicador del evento en la parte inferior.
              const Spacer(),

              // Esta condición agrega el indicador únicamente
              // cuando el día tiene un evento.
              if (hasEvent)
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: isToday ? Colors.white : eventColor,
                        shape: BoxShape.circle,

                        // BoxShadow crea el pequeño efecto de brillo
                        // alrededor del indicador del evento.
                        boxShadow: [
                          BoxShadow(
                            color: isToday
                                ? Colors.white.withValues(alpha: 0.5)
                                : eventColor.withValues(alpha: 0.5),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 5),

                    Expanded(
                      child: Container(
                        height: 3,
                        decoration: BoxDecoration(
                          color: isToday
                              ? Colors.white.withValues(alpha: 0.8)
                              : eventColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // DÍA DE LA SEMANA
  // =========================================================

  // Método reutilizable para mostrar cada nombre de día.
  Widget buildWeekDay(String text) {
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
            color: textSecondary,
          ),
        ),
      ),
    );
  }

  // =========================================================
  // TARJETA DE EVENTO
  // =========================================================

  // Método reutilizable para crear las tarjetas de eventos.
  // Recibe el color, título, fecha e icono para poder crear
  // diferentes eventos utilizando el mismo diseño.
  Widget buildEventCard({
    required Color color,
    required String title,
    required String date,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        // withValues(alpha) permite establecer transparencia
        // sin utilizar el método withOpacity, que está deprecated.
        color: Colors.white.withValues(alpha: 0.045),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.35),
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.06),
            blurRadius: 15,
          ),
        ],
      ),

      child: Row(
        children: [
          // Icono del evento
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: color.withValues(alpha: 0.25),
              ),
            ),
            child: Icon(
              icon,
              color: color,
              size: 19,
            ),
          ),

          const SizedBox(width: 12),

          // Información del evento
          // Expanded permite que esta sección utilice el espacio
          // restante disponible entre el icono y la flecha.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 11,
                    color: textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Flecha visual.
          // No tiene ninguna función porque el laboratorio
          // únicamente solicita el diseño.
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.04),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // ESTRELLA DECORATIVA
  // =========================================================

  // Método utilizado para crear las estrellas decorativas
  // de la cabecera.
  Widget buildStar({
    required double size,
    required double opacity,
  }) {
    return Icon(
      Icons.star,
      size: size,
      color: Colors.white.withValues(alpha: opacity),
    );
  }

  // =========================================================
  // INTERFAZ
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      // SafeArea evita que el contenido quede debajo de elementos
      // del sistema, como la barra de estado.
      body: SafeArea(
        // SingleChildScrollView permite desplazarse verticalmente
        // si el contenido supera el tamaño disponible de la pantalla.
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              // Limita el ancho máximo para que el calendario no
              // se vea demasiado extendido en pantallas grandes.
              constraints: const BoxConstraints(
                maxWidth: 950,
              ),

              child: Column(
                children: [

                  // =================================================
                  // CABECERA NOCTURNA
                  // =================================================

                  Container(
                    height: 230,
                    width: double.infinity,

                    // LinearGradient crea un degradado entre
                    // dos colores para conseguir el efecto de
                    // cielo nocturno.
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF0A1830),
                          Color(0xFF081423),
                        ],
                      ),
                    ),

                    // Stack permite colocar varios widgets
                    // unos encima de otros.
                    // Aquí se utiliza para superponer estrellas,
                    // luna, título y montañas.
                    child: Stack(
                      children: [

                        // Estrellas
                        // Positioned permite establecer la posición
                        // de un elemento dentro de un Stack.
                        Positioned(
                          top: 35,
                          left: 70,
                          child: buildStar(
                            size: 8,
                            opacity: 0.8,
                          ),
                        ),

                        Positioned(
                          top: 55,
                          right: 110,
                          child: buildStar(
                            size: 6,
                            opacity: 0.6,
                          ),
                        ),

                        Positioned(
                          top: 90,
                          left: 180,
                          child: buildStar(
                            size: 5,
                            opacity: 0.5,
                          ),
                        ),

                        Positioned(
                          top: 45,
                          right: 250,
                          child: buildStar(
                            size: 7,
                            opacity: 0.7,
                          ),
                        ),

                        Positioned(
                          top: 110,
                          right: 80,
                          child: buildStar(
                            size: 5,
                            opacity: 0.5,
                          ),
                        ),

                        // Luna
                        Positioned(
                          top: 35,
                          right: 45,
                          child: Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFE7EBFF),

                              // Se utiliza una sombra para crear
                              // un efecto de iluminación alrededor
                              // de la luna.
                              boxShadow: [
                                BoxShadow(
                                  color: secondary.withValues(alpha: 0.2),
                                  blurRadius: 25,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.nightlight_round,
                              color: Color(0xFF7884B5),
                              size: 27,
                            ),
                          ),
                        ),

                        // Título
                        Positioned(
                          left: 28,
                          top: 30,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month,
                                    color: secondary,
                                    size: 20,
                                  ),

                                  const SizedBox(width: 8),

                                  Text(
                                    'MI CALENDARIO',
                                    style: TextStyle(
                                      fontSize: 12,
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.bold,
                                      color: secondary.withValues(
                                        alpha: 0.9,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 15),

                              const Text(
                                'Septiembre',
                                style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                  color: textPrimary,
                                ),
                              ),

                              const Text(
                                '2026',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Silueta de montañas.
                        // CustomPaint permite realizar dibujos
                        // personalizados directamente en Flutter.
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: SizedBox(
                            height: 75,
                            child: CustomPaint(
                              painter: MountainPainter(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // =================================================
                  // CONTENIDO
                  // =================================================

                  Padding(
                    padding: const EdgeInsets.all(24),

                    child: Column(
                      children: [

                        // Navegación del mes
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [

                            const Text(
                              'Calendario mensual',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: textPrimary,
                              ),
                            ),

                            Row(
                              children: [

                                // Flecha izquierda.
                                // Es únicamente visual y no tiene
                                // navegación implementada.
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: card,
                                    borderRadius:
                                        BorderRadius.circular(11),
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.07,
                                      ),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.chevron_left,
                                    color: textSecondary,
                                    size: 21,
                                  ),
                                ),

                                const SizedBox(width: 8),

                                // Flecha derecha.
                                // También es únicamente visual.
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: card,
                                    borderRadius:
                                        BorderRadius.circular(11),
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.07,
                                      ),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.chevron_right,
                                    color: textSecondary,
                                    size: 21,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 22),

                        // Días de la semana
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: card,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Row(
                            children: [
                              buildWeekDay('LUN'),
                              buildWeekDay('MAR'),
                              buildWeekDay('MIÉ'),
                              buildWeekDay('JUE'),
                              buildWeekDay('VIE'),
                              buildWeekDay('SÁB'),
                              buildWeekDay('DOM'),
                            ],
                          ),
                        ),

                        const SizedBox(height: 7),

                        // Cada Row representa una semana.
                        // Los días se colocan horizontalmente dentro
                        // del Row mediante el método buildDay().

                        // Semana 1
                        Row(
                          children: [
                            buildDay(day: '31', isOtherMonth: true),
                            buildDay(day: '1'),
                            buildDay(day: '2'),
                            buildDay(
                              day: '3',
                              hasEvent: true,
                              eventColor: Colors.orange,
                            ),
                            buildDay(day: '4'),
                            buildDay(day: '5'),
                            buildDay(day: '6'),
                          ],
                        ),

                        // Semana 2
                        Row(
                          children: [
                            buildDay(day: '7'),
                            buildDay(
                              day: '8',
                              hasEvent: true,
                              eventColor: secondary,
                            ),
                            buildDay(day: '9'),
                            buildDay(day: '10'),
                            buildDay(
                              day: '11',
                              hasEvent: true,
                              eventColor: Colors.greenAccent,
                            ),
                            buildDay(day: '12'),
                            buildDay(day: '13'),
                          ],
                        ),

                        // Semana 3
                        Row(
                          children: [
                            buildDay(day: '14'),

                            // Este es el día destacado del calendario.
                            buildDay(
                              day: '15',
                              isToday: true,
                              hasEvent: true,
                            ),

                            buildDay(day: '16'),
                            buildDay(day: '17'),
                            buildDay(day: '18'),
                            buildDay(
                              day: '19',
                              hasEvent: true,
                              eventColor: primary,
                            ),
                            buildDay(day: '20'),
                          ],
                        ),

                        // Semana 4
                        Row(
                          children: [
                            buildDay(day: '21'),
                            buildDay(day: '22'),
                            buildDay(
                              day: '23',
                              hasEvent: true,
                              eventColor: Colors.redAccent,
                            ),
                            buildDay(day: '24'),
                            buildDay(
                              day: '25',
                              hasEvent: true,
                              eventColor: Colors.orange,
                            ),
                            buildDay(day: '26'),
                            buildDay(day: '27'),
                          ],
                        ),

                        // Semana 5
                        Row(
                          children: [
                            buildDay(day: '28'),
                            buildDay(day: '29'),
                            buildDay(day: '30'),

                            // Estos días pertenecen al siguiente mes
                            // y se muestran con un color más apagado.
                            buildDay(
                              day: '1',
                              isOtherMonth: true,
                            ),
                            buildDay(
                              day: '2',
                              isOtherMonth: true,
                            ),
                            buildDay(
                              day: '3',
                              isOtherMonth: true,
                            ),
                            buildDay(
                              day: '4',
                              isOtherMonth: true,
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // =================================================
                        // EVENTOS
                        // =================================================

                        Row(
                          children: [
                            const Text(
                              'Próximos eventos',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: textPrimary,
                              ),
                            ),

                            const SizedBox(width: 8),

                            // Indicador visual de la cantidad de eventos.
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: primary.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                '3',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: primary,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        // Cada llamada utiliza el mismo método
                        // buildEventCard() pero con información diferente.
                        buildEventCard(
                          color: secondary,
                          title: 'Reunión de proyecto',
                          date: '08 Sep · 10:00 AM',
                          icon: Icons.groups,
                        ),

                        buildEventCard(
                          color: Colors.greenAccent,
                          title: 'Entrega de trabajo',
                          date: '11 Sep · 02:00 PM',
                          icon: Icons.task_alt,
                        ),

                        buildEventCard(
                          color: Colors.orangeAccent,
                          title: 'Presentación',
                          date: '25 Sep · 04:00 PM',
                          icon: Icons.present_to_all,
                        ),

                        const SizedBox(height: 25),

                        // =================================================
                        // PIE
                        // =================================================

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: primary,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: primary.withValues(
                                      alpha: 0.5,
                                    ),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 7),

                            const Text(
                              'Día destacado',
                              style: TextStyle(
                                fontSize: 12,
                                color: textSecondary,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // =============================================================
      // BOTÓN FLOTANTE
      // =============================================================

      // Este botón es solamente visual para cumplir con el diseño.
      // No se agrega onPressed porque el laboratorio no solicita
      // funcionalidad para registrar nuevos eventos.
      floatingActionButton: Container(
        width: 58,
        height: 58,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [
              primary,
              Color(0xFF5B8CFF),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: primary.withValues(alpha: 0.35),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
      ),

      // Indica que el botón flotante se ubicará en la parte
      // inferior central de la pantalla.
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
    );
  }
}

// =============================================================
// PINTOR DE MONTAÑAS
// =============================================================

// CustomPainter permite crear gráficos personalizados.
// En este caso se utiliza para dibujar las montañas del
// encabezado sin utilizar una imagen externa.
class MountainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    // Paint contiene las propiedades visuales que tendrá
    // el dibujo, como el color y el tipo de relleno.
    final paint = Paint()
      ..color = const Color(0xFF050C17)
      ..style = PaintingStyle.fill;

    // Path permite crear una figura personalizada mediante
    // diferentes puntos y líneas.
    final path = Path();

    // Se van agregando puntos para formar la silueta
    // de las montañas.
    path.moveTo(0, size.height);

    path.lineTo(0, size.height * 0.65);

    path.lineTo(size.width * 0.15, size.height * 0.25);

    path.lineTo(size.width * 0.28, size.height * 0.68);

    path.lineTo(size.width * 0.43, size.height * 0.35);

    path.lineTo(size.width * 0.58, size.height * 0.72);

    path.lineTo(size.width * 0.73, size.height * 0.18);

    path.lineTo(size.width * 0.88, size.height * 0.65);

    path.lineTo(size.width, size.height * 0.40);

    path.lineTo(size.width, size.height);

    // close() conecta el último punto con el primero,
    // cerrando la figura para poder rellenarla.
    path.close();

    // Dibuja la figura creada por Path utilizando las
    // propiedades definidas anteriormente en Paint.
    canvas.drawPath(path, paint);
  }

  // Como las montañas son estáticas, no es necesario volver
  // a dibujarlas cuando cambia la pantalla.
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}