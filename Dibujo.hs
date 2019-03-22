module Dibujo where

-- definir el lenguaje
type Dibujo a = Basica a | Rotar a | Espejar a | Rot45 a
              | Apilar Int Int a a
              | Juntar Int Int a a
              | Encimar a a
