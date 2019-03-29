module Escher where

import Dibujo

-- supongamos que eligen 
type Escher = Bool

-- el dibujo u
dibujo_u :: Dibujo Escher -> Dibujo Escher
dibujo_u p = undefined 

-- el dibujo t
dibujo_t :: Dibujo Escher -> Dibujo Escher
dibujo_t p = undefined 

-- esquina con nivel de detalle en base a la figura p
esquina :: Int -> Dibujo Escher -> Dibujo Escher
esquina n p = undefined

-- lado con nivel de detalle
lado :: Int -> Dibujo Escher -> Dibujo Escher
lado n p = undefined

-- por suerte no tenemos que poner el tipo!
noneto p q r s t u v w x = undefined

-- el dibujo de Escher:
escher :: Int -> Escher -> Dibujo Escher
escher = undefined