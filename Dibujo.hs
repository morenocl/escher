module Dibujo where

-- definir el lenguaje
type Dibujo a = Basica a | Rotar a | Espejar a | Rot45 a
              | Apilar Int Int a a
              | Juntar Int Int a a
              | Encimar a a

-- composicion n-veces de una funcion
comp :: (a -> a) -> Int -> a-> a
comp f 0 a  = a 
comp f c a = comp(f c-1 f(a))

-- rotaciones de multiplos de 90
r180 :: Dibujo a -> Dibujo -> a
r180 a = Rotar $ Rotar a

r270 :: Dibujo a -> Dibujo a
r270 a = Rotar $ Rotar $ Rotar a


-- Pone una figura sobre la otra, ambas ocupan el mismo espacio
(.-.) :: Dibujo a -> Dibujo a -> Dibujo a
(.-.) a b = Apilar a b


-- Pone una figura al lado de la otra
(///) :: Dibujo a -> Dibujo a -> Dibujo a
(///) a b = Juntar a b

-- Superpone una figura con otra
(^^^) :: Dibujo a -> Dibujo a -> Dibujo a
(^^^) a b = Encimar a b


-- dada una figura la repite en cuatro cuadrantes
cuarteto :: Dibujo a -> Dibujo a
cuarteto a = Apilar (juntar a a) (Juntar a a)

-- una figura repetida con las cuatro rotaciones, superimpuestas.
encimar4 :: Dibujo a -> Dibujo a 
encimar4 a = Encimar (Encimar (Rotar a) (Rotar $ Rotar a) ) (Encimar (Rotar $ Rotar $ Rotar a) a)

-- cuadrado con la misma figura rotada $i$ por $90$ para $i \in \{1..3\}$.
-- No confundir con encimar4!
ciclar :: Dibujo a -> Dibujo a
ciclar a = Apilar (Juntar  (Rotar a) a )  (Juntar (Rotar $ Rotar $ Rotar a) (Rotar $ Rotar a) )
