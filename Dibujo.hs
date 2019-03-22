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
a .-. b = Apilar 10 10 a b


-- Pone una figura al lado de la otra
(///) :: Dibujo a -> Dibujo a -> Dibujo a
a /// b = Juntar 10 10 a b

-- Superpone una figura con otra
(^^^) :: Dibujo a -> Dibujo a -> Dibujo a
a ^^^ b = Encimar a b


-- dada una figura la repite en cuatro cuadrantes
cuarteto :: Dibujo a -> Dibujo a
cuarteto a = (a /// a) .-. (a /// a)

-- una figura repetida con las cuatro rotaciones, superimpuestas.
encimar4 :: Dibujo a -> Dibujo a 
encimar4 a = ((Rotar a) ^^^ (r180 a)) ^^^ ((r270 a) ^^^ a)

-- cuadrado con la misma figura rotada $i$ por $90$ para $i \in \{1..3\}$.
-- No confundir con encimar4!
ciclar :: Dibujo a -> Dibujo a
ciclar a = ((Rotar a) /// a ) .-. ((r270 a) /// (r180 a))

-- ver un a como una figura
pureDibe :: a -> Dibujo a
pureDibe a = Basico a

-- map para nuestro lenguaje
mapDib :: (a -> b) -> Dibujo a -> Dibujo b
mapDib f (Basico a) = Basico (f a)
mapDib f (Rotar a) = Rotar (mapDib f a)
mapDib f (Espejar a) = Espejar (mapDib f a)
mapDib f (Rot45 a) = Rot45 (mapDib f a)
mapDib f (Apilar n m a b) =  Apilar n m (mapDib f a) (mapDib f b) 
mapDib f (Juntar n m a b) = Juntar n m (mapDib f a) (mapDib f b)
mapDib f (Encimar a b) = Encimar (mapDib f a) (mapDib f b)

-- verificar que las operaciones satisfagan
-- 1. map pureDibe = id
-- 2. map (g . f) = mapDib g . mapDib f


