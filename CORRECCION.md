# Grupo 14		
## Corrección		
	Tag o commit corregido:	lab-1
		
### Entrega		100.00%
	Tag correcto	100.00%
	En tiempo	100.00%
### Funcionalidad		92.00%
	No hay errores de tipo	100.00%
	Se puede compilar y ejecuta correctamente	90.00%
	Esquemas para manipulación	100.00%
	Consultas (definibles por esquemas, `contar` sólo suma)	100.00%
	Chequeos y corrección de rot360 y flipFlip	30.00%
	Interpretación geométrica	100.00%
	Escher	100.00%
		
### Modularización y diseño		84.00%
	Dibujo es paramétrico	100.00%
	Alto orden para consultas	100.00%
	Identificación de situaciones recurrentes (parentizado en descr, por ejemplo)	60.00%
	Correcta elección de tipo para Escher (con justificación)	100.00%
### Calidad de código		85.00%
	Buenas prácticas funcionales	80.00%
	Líneas de más de 80 caracteres	50.00%
	estilo	100.00%
		
		
		
### Uso de git		100.00%
	Commits frecuentes	100.00%
	Nombres de commits significativos	100.00%
	Commits de todes les integrantes	100.00%
### Opcionales		
		
	Puntos estrella	100.00%
		
# Nota Final		9.892
		
		
# Comentarios		
	runghc Main.hs tira error Main.hs:63:41: Not in scope: ‘listDirectory’. Aparentemente mi versión de haskell es demasiado vieja, pero tienen que tener en cuenta estas cosas. Tuve que comentar toda la parte interactiva para poder evaluar.	
	Escher.hs debería haber ido en Basico	
	Los predicados esRot y esFlip2 (y por lo tanto todoBien) no detectan errores en los siguientes dibujos	
	(Encimar (Rotar (Rotar (Rotar (Rotar (Simple T))))) (Simple T))	
	(Encimar (Espejar (Espejar (Rotar (Rotar (Simple T))))) (Simple T))	
	noRot360 y noFlip2 no corrigen dibujos si el problema no está en el primer constructor	
	Tienen algunas funciones auxiliares que se utilizan en un único lugar, y que podrían haberse definido dentro de la función principal con un where	

