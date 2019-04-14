# Paradigmas 

## Indice
1. Dibujo.hs
2. Predicado.hs
3. Interp.hs
4. Escher.hs
5. Extras 
    
    5.1 Interactivo

    5.2 Animación 



## Dibujo.hs

Definir el lenguaje y las primeras funciones no fue 
una tarea complicada, ya que, era bastante intuitivo darse cuenta de que hacía cada función. Además al definir nuestros propios operadores facilitó la lectura de las  funciones ``ciclar`` , ``cuarteto`` y ``encimar4`` para que no quedaran 
largas de tal forma que su compresión sea más simple.

``` haskell 
    (.-.) :: Dibujo a -> Dibujo a -> Dibujo a
    a .-. b = Apilar 10 10 a b


    -- Pone una figura al lado de la otra
    (///) :: Dibujo a -> Dibujo a -> Dibujo a
    a /// b = Juntar 10 10 a b

    -- Superpone una figura con otra
    (^^^) :: Dibujo a -> Dibujo a -> Dibujo a
    a ^^^ b = Encimar a b

```


Sin embargo cuando empezamos con *Esquemas para la manipulación de figura* a medida que avazabamos era cada vez más complicado y por otro lado tedioso dado que por ahora teníamos que hacer **Pattern Matching** y las funciones tenían una longitud considerable lo que hacía que sea difícil darse cuenta cual era su función a simple vista.

``` haskell
    --Ejemplos de estas funciones son: 
    mapDib :: (a -> b) -> Dibujo a -> Dibujo b 
    cambia :: (a -> Dibujo b) -> Dibujo a -> Dibujo b 

``` 


A pesar de todas las dificultades que tuvimos hasta el momento la función que más nos constó con diferencia fue 
```sem``` que es la estructura general para la semántica. Después de mucho pensar y discutir con compañeros entendimos el esqueleto de dicha función. Toma 7 funciones y nuestro lenguaje tiene 7 constructores , por lo tanto cada función se aplica al constructor correspondiente. Si bien el resultado de la función que nos quedó no es muy amigable a simple vista, significó que de ahora en más ya **no hacía falta hacer más Pattern Matching** como resultado podíamos definir funciones que ibamos a aplicar sobre dibujos en una sola linea.


## Predicado.hs

Al principio fue un dolor de cabeza no poder hacer Pattern Matching y tener que usar la función **sem**, pero a medida que ibamos avanzando era cada vez más simple e intuitivo. No obstante nos encontramos con un nuevo problema , como sem toma como parametros 7 funciones , muchas veces teníamos que definirlas y volviamos a lo de antes, nada más que en vez de tener que hacer Pattern Matching ahora teníamos que crear muchas funciones auxiliares que solo ibamos a usar una sola vez.

Para poder solucionar esto y facilitar la legibilidad de nuestro código descubrimos que en haskell existen las *funciones anonimas* que tienen la siguiente forma: 


``` haskell 
    allDib ::  Pred a -> Dibujo a -> Bool
    allDib p a = sem p id id id predand predand (&&) a
            where predand = \_ _ x y -> x && y

```

Si bien este tipo de funciones eran muy útiles, en ciertos casos era mejor crear funciones auxiliares aunque no sea lo ideal, esto se puede ver en la forma en la que hicimos ``contar`` y ``desc``.

El mayor obstaculo que tuvimos en esta parte del proyecto fue como crear la función ``TodoBien``, ya que, no podíamos utilizar el análisis por casos convencional de Haskell, para ello encontramos que podíamos utilizar **case**: 

``` haskell 
    case expression of pattern -> result  
                       pattern -> result  
                       pattern -> result  
                       ...  
```

## Interp.hs

Toda la parte de interpretación geométrica no tuvimos mayores complicaciones, dado que, la consigna era bastante clara sobre lo que había que hacer. A pesar de esto para definir la función ``Interp`` estuvimos un buen rato hasta que pudimos entender que era el tipo **Output** ,pero más haya de eso avanzamos bastante rápido.

## Escher.hs

Llegado a este punto las cosas se complicaron porque había que hacer el Dibujo Escher, para poder entender mejor como estaba compuesto decidimos leer del apunte proporcionado por los profes donde explicaba de forma detallada como creearlo y como estaban especificadas las funciones auxiliares. 

Las funciones ``Lado`` y ``Esquina`` estan definidas de forma recursiva sobre un cuarteto, haciendo uso de **dibujo_t** y **dibujo_u**. Despues Noneto es solo juntar 9 dibujos en uno solo de 3x3. Finalmente Escher es un noneto donde cada dibujo es un lado o esquina según corresponde.


## Extras 

Una vez que terminamos con los objetivos del proyecto y corregimos un par de errores, decidimos divertirnos un poco e implementamos un par de cosas más.

### Interactivo 

Hacerlo interactivo no estaba dentro de nuestros planes, pero uno de los profesores nos sugirió la idea y como teníamos tiempo decidimos implementrarlo.

Lo podríamos haber hecho todo en un sólo bloque dentro del Main, pero iba a quedar con muchos if's anidados entonces la lectura del código no iba a ser secilla, para ello decidimos separlo en tres funciones: ``dibujaLineas`` , ``muestraArchivos`` y ``dibujaBmp``.

La primera es la que estaba por defecto para dibujar triangulos, le agregamos una configuracion para curvas, y lo pusimos en una función por separado. MuestraArchivos como dice el nombre se encarga de mostrar todas las imagenes básicas que se encuentrarn en **pathBase** ("./img/bmp/") para que el usuario eliga el Bmp que desea cargar. Finalmente dibujaBmp se encarga de cargar el archivo seleccionado y lo usa para la interpretación. Todas dan la posibilidad de salir de la ejecucion con ``0``

### Animación

Para poder comprender mejor como hacer una animación utilizando **Gloss** decidimos hacerlo desde cero, puesto que, si tratabamos de hacerlo sobre nuestro proyecto sin realmente comprender como funciona la librería era un receta para el desastre. 

Descubrimos que teníamos que usar la función *animate*, que funciona exactamente igual que *display* nada más que tiene un parametro extra que es una función que va de **Float -> Picture**
que sirve para producir el siguiente frame de la animación, a la que se le pasa el tiempo en segundos desde que empezó el programa.

En nuestro caso nosotros queríamos que el dibujo Escher rotara cierta cantidad de grados cada frame y lo implementamos de la siguiente manera: 

``` haskell 
    
    draw :: Float -> Picture -> Picture
    draw t = rotate (t*70)

    in animate win white (\time -> draw time) $ interp ..

```

### Color 

Una vez que logramos que todo lo anterior funcionara decidimos que el dibujo tenga un color distinto para ello encontramos que podíamos usar la función **color**. Como no queríamos que siempre tenga el mismo color encontramos la función **makecolor** que dado 4 numeros (entre 0 y 1) te devuelve un color. Los priemros 3 son las componentes rojo, verde, azul y la última es la alpha. Lo hicimos de las siguiente forma:

```haskell
    color (makeColor (abs (sin (3*time))) (abs (cos (9*time))) (abs (sin time)) 1)
```
Como queríamos que cambie a medida que pasa el tiempo teníamos que usar la varible tiempo de alguna forma, pero como los datos tenían que ser entre 0 y 1 al principio no se nos ocurría la forma. Luego de pensar mucho decidimos usar las funciones seno y coseno, sin embargo nos pueden dar valores entre -1 y 1, por lo tanto le aplicamos el valor absoluto para asegurarnos que los valores estén bien. También podemos observar que la componente roja y la azul usan ambes la función seno, pero toman distintos valores, esto es para que no den los mismo valores y tengamos un rango de colores mucho más amplio.


## Bibliografía

1. [Anonymous function](https://wiki.haskell.org/Anonymous_function)
2. [Haskell syntax](http://learnyouahaskell.com/syntax-in-functions)
3. [Functional Geometry](https://cs.famaf.unc.edu.ar/~mpagano/henderson-funcgeo2.pdf)
4. [Animate Gloss](https://hackage.haskell.org/package/gloss-1.6.0.1/docs/Graphics-Gloss-Interface-Animate.html)
5. [Color Gloss](http://hackage.haskell.org/package/gloss-1.1.0.0/docs/Graphics-Gloss-Color.html)
