# Paradigmas 

## Indice
1. Dibujo.hs

    1.1  

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


Sin embargo cuando empezamos con *Esquemas para la manipulación de figura* a medida que avazabamos era cada vez más complicado y por otro lado tedioso dado que por ahora teníamos que hacer **Pattern Matching** y las funciones tenían una longitud considerable lo que hacía que sea difícil darse cuenta cual era su función a simple viste.

> Ejemplos de estas funciones son: 
> *  mapDib :: (a -> b) -> Dibujo a -> Dibujo b 
> *  cambia :: (a -> Dibujo b) -> Dibujo a -> Dibujo b  


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



## Bibliografía

1. [Anonymous function](https://wiki.haskell.org/Anonymous_function)
2. [Haskell syntax](http://learnyouahaskell.com/syntax-in-functions)