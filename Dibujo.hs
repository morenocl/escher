module Dibujo where

-- definir el lenguaje
data Dibujo a = Basica a 
              | Rotar (Dibujo a) 
              | Espejar (Dibujo a) 
              | Rot45 (Dibujo a)
              | Apilar Int Int (Dibujo a) (Dibujo a)
              | Juntar Int Int (Dibujo a) (Dibujo a)
              | Encimar (Dibujo a) (Dibujo a)
                deriving(Show,Eq)

-- composicion n-veces de una funcion
comp :: (a -> a) -> Int -> a-> a
comp f 0 a  = a 
comp f c a = comp f (c-1) (f a)

-- rotaciones de multiplos de 90
r180 :: Dibujo a -> Dibujo a
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
cuarteto :: Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a
cuarteto a b c d = (a /// b) .-. (c /// d)


-- una figura repetida con las cuatro rotaciones, superimpuestas.
encimar4 :: Dibujo a -> Dibujo a 
encimar4 a = ((Rotar a) ^^^ (r180 a)) ^^^ ((r270 a) ^^^ a)

-- cuadrado con la misma figura rotada $i$ por $90$ para $i \in \{1..3\}$.
-- No confundir con encimar4!
ciclar :: Dibujo a -> Dibujo a
ciclar a = ((Rotar a) /// a ) .-. ((r270 a) /// (r180 a))

-- ver un a como una figura
pureDibe :: a -> Dibujo a
pureDibe a = Basica a

-- map para nuestro lenguaje
mapDib :: (a -> b) -> Dibujo a -> Dibujo b
mapDib f (Basica a) = Basica (f a)
mapDib f (Rotar a) = Rotar (mapDib f a)
mapDib f (Espejar a) = Espejar (mapDib f a)
mapDib f (Rot45 a) = Rot45 (mapDib f a)
mapDib f (Apilar n m a b) =  Apilar n m (mapDib f a) (mapDib f b) 
mapDib f (Juntar n m a b) = Juntar n m (mapDib f a) (mapDib f b)
mapDib f (Encimar a b) = Encimar (mapDib f a) (mapDib f b)

-- verificar que las operaciones satisfagan
-- 1. map pureDibe = id
-- 2. map (g . f) = mapDib g . mapDib f

-- convencerse que se satisface
-- cambiar pureDibe = id
-- cambiar f (pureDibe a) = f a
-- (cambiar g) (cambiar f ma) = cambiar (cambiar g . f) ma
cambia :: (a -> Dibujo b) -> Dibujo a -> Dibujo b
cambia f (Basica a) = f a
cambia f (Rotar a) = Rotar (cambia f a)
cambia f (Espejar a) = Espejar (cambia f a)
cambia f (Rot45 a) = Rot45 (cambia f a)
cambia f (Apilar n m a b) = Apilar n m (cambia f a) (cambia f b)
cambia f (Juntar n m a b) = Juntar n m (cambia f a) (cambia f b)
cambia f (Encimar a b) = Encimar (cambia f a) (cambia f a)

-- estructura general para la semántica (a no asustarse. Ayuda: 
-- pensar en foldr y las definiciones de intro a la lógica)
sem :: (a -> b) -> (b -> b) -> (b -> b) -> (b -> b) ->
    (Int -> Int -> b -> b -> b) -> 
    (Int -> Int -> b -> b -> b) -> 
    (b -> b -> b) ->
    Dibujo a -> b
sem bas rot esp rot45 api jun enc (Basica a) = bas a
sem bas rot esp rot45 api jun enc (Rotar a) = rot (sem bas rot esp rot45 api jun enc a)
sem bas rot esp rot45 api jun enc (Espejar a) = esp (sem bas rot esp rot45 api jun enc a)
sem bas rot esp rot45 api jun enc (Rot45 a) = rot45 (sem bas rot esp rot45 api jun enc a)
sem bas rot esp rot45 api jun enc (Apilar x y a b) = api x y pd sd
    where pd = sem bas rot esp rot45 api jun enc a
          sd = sem bas rot esp rot45 api jun enc b
sem bas rot esp rot45 api jun enc (Juntar x y a b) = jun x y pd sd
    where pd = sem bas rot esp rot45 api jun enc a
          sd = sem bas rot esp rot45 api jun enc b
sem bas rot esp rot45 api jun enc (Encimar a b) = enc pd sd
    where pd = sem bas rot esp rot45 api jun enc a
          sd = sem bas rot esp rot45 api jun enc b
          
          
          
-- Se puede hacer recurcion para mejorar en los demas casos.
-- Espejar Rotar Rotar Rotar Rotar Basica a => Espejar Basica a
quitar4Rot :: Dibujo a -> Dibujo a
quitar4Rot (Rotar(Rotar(Rotar(Rotar d)))) = d 

quitar2Espejar :: Dibujo a -> Dibujo a
quitar2Espejar (Espejar(Espejar d)) = d



