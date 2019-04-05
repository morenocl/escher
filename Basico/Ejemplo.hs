module Basico.Ejemplo where
import Dibujo
import Interp

type Bas = Int
ejemplo :: Dibujo Bas
ejemplo = Apilar 1 1 (Basica 2) (Basica 3)

interpBas :: Output Bas
interpBas 2 = trian1
interpBas 3 = trian1
