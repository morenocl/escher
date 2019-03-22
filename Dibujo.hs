module Dibujo where

-- definir el lenguaje
type Dibujo a = Basica a | Rotar a | Espejar a | Rot45 a
              | Apilar Int Int a a
              | Juntar Int Int a a
              | Encimar a a

comp :: (a -> a) -> Int -> a-> a
comp f 0 a  = a 
comp f c a = comp(f c-1 f(a))



