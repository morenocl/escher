module Escher where

import Dibujo
import Interp
import Graphics.Gloss
-- supongamos que eligen 
type Escher = Bool

-- el dibujo u
dibujo_u :: Dibujo Escher -> Dibujo Escher
dibujo_u p = encimar4 (Rot45 p)

-- el dibujo t
dibujo_t :: Dibujo Escher -> Dibujo Escher
dibujo_t p = p ^^^ (p2 ^^^ p3)
            where p2 = Espejar (Rot45 p)
                  p3 = r270 p2

-- esquina con nivel de detalle en base a la figura p
esquina :: Int -> Dibujo Escher -> Dibujo Escher
esquina 0 _ = Basica False
esquina n p = cuarteto (esquina (n-1) p) (lado (n-1) p) (Rotar (lado (n-1) p)) (dibujo_u p)

-- lado con nivel de detalle
lado :: Int -> Dibujo Escher -> Dibujo Escher
lado 0 _ = Basica False
lado n p = cuarteto (lado (n-1) p) (lado (n-1) p) (Rotar (dibujo_t p)) (dibujo_t p)

-- por suerte no tenemos que poner el tipo!
noneto p q r s t u v w x = Apilar 3 1 (Juntar 1 3 p (Juntar 2 1 q r))
                            (Apilar 1 2 (Juntar 1 3 s (Juntar 2 1 t u))
                                        (Juntar 1 3 v (Juntar 2 1 w x)))

-- el dibujo de Escher:
escher :: Int -> Dibujo Escher -> Dibujo Escher
escher n p = noneto (esquina n p) (lado n p) (r270(esquina n p)) 
                    (Rotar(lado n p)) (dibujo_u p) (r270(lado n p)) 
                    (Rotar(esquina n p)) (r180(lado n p)) (r180(esquina n p))



type Bas = Bool
ejemplo :: Dibujo Bas
ejemplo = escher 2 (Basica True)

interpBas :: Output Bas
interpBas True = trian4
interpBas False = Interp.blank

interpBas2 :: Picture -> Vector -> Output Bas
interpBas2 algo (x,y) True = transf f algo (x,y)
                            where f p (_, _) = p
interpBas2 algo (x,y) False = Interp.blank












