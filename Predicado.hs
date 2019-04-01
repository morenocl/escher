module Predicado where 

import Dibujo

-- Tipo Predicado
type Pred a = a -> Bool

-- ¿Que es una figura vacia?
--limpia :: Pred a -> Dibujo a -> Dibujo a

-- alguna básica satisface el predicado
anyDIb :: Pred a -> Dibujo a -> Bool
anyDIb p a  = sem p id id id predor predor (||) a
    where predor = \_ _ a b -> a || b

-- todas las básicas satisfacen el predicado
allDib ::  Pred a -> Dibujo a -> Bool
allDib p a = sem p id id id predand predand (&&) a
    where predand = \_ _ x y -> x && y

-- describe la figura
rot :: String -> String 
rot  s = "rot " ++"("++ s ++ ")" 

esp :: String -> String 
esp  s = "esp " ++"("++ s ++ ")"

rot45 :: String -> String 
rot45  s = "rot45 " ++"("++ s ++ ")"

api :: Int -> Int -> String -> String -> String
api _ _ s1 s2 = "api " ++ "("++ s1 ++")" ++ "("++ s2 ++")"

jun :: Int -> Int -> String -> String -> String
jun _ _ s1 s2 = "jun " ++ "("++ s1 ++")" ++ "("++ s2 ++")"

enc :: String -> String -> String 
enc s1 s2 = "enc " ++ "("++ s1 ++")" ++ "("++ s2 ++")"

desc :: (a -> String) -> Dibujo a -> String
desc s a = sem s rot esp rot45 api jun enc a

-- junta todas las figuras básicas de un dibujo
conc :: Int -> Int -> [b] -> [b] -> [b]
conc _ _ a b = a++b

every :: Dibujo a -> [a]
every a = sem (:[]) id id id conc conc (++) a

-- cuenta la cantidad de veces que aparecen las básicas en una figura.
primero :: a -> [(a,Int)]
primero a = [(a,1)] 

esta :: Eq a => (a,Int) -> [(a,Int)] -> [(a,Int)]
esta (a,b) [] = [(a,b)]
esta (a,b) ((x,y) : xs) | x == a = (x,y+b):xs
                        | otherwise = (x,y):(esta (a,b) xs)

esta2 :: Eq a => [(a,Int)] -> [(a,Int)] -> [(a,Int)]
esta2 [] ys = ys  
esta2 ((x,y) : xs ) ys = esta2 xs (esta (x,y) ys)

junta :: Eq a => Int -> Int -> [(a,Int)] -> [(a,Int)] -> [(a,Int)]
junta _ _ a b = esta2 a b

contar :: Eq a => Dibujo a -> [(a,Int)]
contar a = sem primero id id id junta junta esta2 a

-- hay 4 rotaciones seguidas (empezando en el tope)
-- ¿que pasa con una rotacion 360+90?
esRot360 :: Pred (Dibujo a)
esRot360 a = ( (sem (const 0) (+1) (const 0) (const 0) v v w a)::Integer) >= 4
            where v = \_ _ x y -> ( 0)
                  w = \ x y -> ( 0)

-- hay 2 espejados seguidos (empezando en el tope)
esFlip2 :: Pred (Dibujo a)
esFlip2 a = ( (sem (const 0) (const 0) (+ 1) (const 0) v v w a)::Integer) >= 2
            where v = \_ _ x y -> ( 0)
                  w = \ x y -> ( 0)


check :: Pred (Dibujo a) -> String -> Dibujo a -> Either String (Dibujo a)
check p error b | p b == True = Right b
                | otherwise   = Left error


-- aplica todos los chequeos y acumula todos los errores,
-- sólo devuelve la figura si no hubo ningún error.
todoBien :: Dibujo a -> Either [String] (Dibujo a)
todoBien d = case check esRot360 "err1" d of 
                Left err1 -> case check esFlip2 "err2" d of
                                Left err2 -> Left [err1,err2]
                                Right d -> Left [err1]
                Right d   -> case  check esFlip2 "err2" d of
                                Left err2 -> Left [err2]
                                Right d -> Right d


-- Corrige errores de rotacion
noRot360 :: Dibujo a -> Dibujo a
noRot360 d | esRot360 d = noRot360 $ quitar4Rot d
           | otherwise  = d

-- Corrige errores de espejar
noFlip2  :: Dibujo a -> Dibujo a
noFlip2 d | esFlip2 d = noFlip2 $ quitar2Espejar d
          | otherwise  = d










