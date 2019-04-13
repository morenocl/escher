# Paradigmas 

## Indice
1. Dibujo.hs

    1.1  
## Dibujo.hs

Definir nuestro el lenguaje y las primeras funciones no fue 
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
> ``` haskell 
>    mapDib :: (a -> b) -> Dibujo a -> Dibujo b
>    cambia :: (a -> Dibujo b) -> Dibujo a -> Dibujo b
>``` 

