module Escher where

import Dibujo

-- supongamos que eligen 
type Escher = Bool

-- el dibujo u
dibujo_u :: Dibujo Escher -> Dibujo Escher
dibujo_u p = rot45(ciclar p) 

-- el dibujo t
dibujo_t :: Dibujo Escher -> Dibujo Escher
dibujo_t p = p ^^^ Rot45(p .-. p3)
            where p3 = r270 p

-- esquina con nivel de detalle en base a la figura p
esquina :: Int -> Dibujo Escher -> Dibujo Escher
esquina 1 p = cuarteto blank blank blank (dibujo_u p)
esquina n p = cuarteto (esquina n-1) (lado n-1 p) (Rotar (lado n-1 p)) (dibujo_u p)

-- lado con nivel de detalle
lado :: Int -> Dibujo Escher -> Dibujo Escher
lado 1 p = cuarteto b b (Rotar p) p
lado n p = cuarteto (lado (n-1) p) (lado (n-1) p) (Rotar p) p

-- por suerte no tenemos que poner el tipo!
noneto p q r s t u v w x = undefined

-- el dibujo de Escher:
escher :: Int -> Escher -> Dibujo Escher
escher = undefined
