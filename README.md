Subasta - Trabajo Final Buenos Aires
Se requiere un contrato inteligente verificado y publicado en la red de Scroll Sepolia que cumpla con lo siguiente:

Funciones:
Constructor. Inicializa la subasta con los parámetros necesario para su funcionamiento.
Función para ofertar: Permite a los participantes ofertar por el artículo. Para que una oferta sea válida debe ser mayor que la mayor oferta actual al menos en 5% y debe realizarse mientras la subasta esté activa.
Mostrar ganador: Muestra el ofertante ganador y el valor de la oferta ganadora.
Mostrar ofertas: Muestra la lista de ofertantes y los montos ofrecidos.
Devolver depósitos: Al finalizar la subasta se devuelve el depósito a los ofertantes que no ganaron, descontando una comisión del 2% para el gas.
Manejo de depósitos:
Las ofertas se depositan en el contrato y se almacenan con las direcciones de los ofertantes.
Eventos:
Nueva Oferta: Se emite cuando se realiza una nueva oferta.
Subasta Finalizada: Se emite cuando finaliza la subasta.
Funcionalidades avanzadas:

Reembolso parcial:
Los participantes pueden retirar de su depósito el importe por encima de su última oferta durante el desarrollo de la subasta.
Consideraciones adicionales:

Se debe utilizar modificadores cuando sea conveniente.
Para superar a la mejor oferta la nueva oferta debe ser superior al menos en 5%.
El plazo de la subasta se extiende en 10 minutos con cada nueva oferta válida. Esta regla aplica siempre a partir de 10 minutos antes del plazo original de la subasta. De esta manera los competidores tienen suficiente tiempo para presentar una nueva oferta si así lo desean.
El contrato debe ser seguro y robusto, manejando adecuadamente los errores y las posibles situaciones excepcionales.
Se deben utilizar eventos para comunicar los cambios de estado de la subasta a los participantes.
La documentación del contrato debe ser clara y completa, explicando las funciones, variables y eventos.

IMPORTANTE: El trabajo debe ser presentado en la sección TRABAJO FINAL MÓDULO 2, donde sólo se debe incluir la URL correspondiente del contrato inteligente que cumpla con los requisitos definidos en esta sección que debe estar publicado y verificado.
