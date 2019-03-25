module Predicado where 

import Dibujo

-- Tipo Predicado
type Pred a = a -> Bool

-- ¿Que es una figura vacia?
--limpia :: Pred a -> Dibujo a -> Dibujo a

-- alguna básica satisface el predicado
predor ::  Int -> Int -> Bool -> Bool -> Bool
predor _ _ a b = a || b

anyDIb :: Pred a -> Dibujo a -> Bool
anyDIb p a  = sem p id id id predor predor (||) a

-- todas las básicas satisfacen el predicado
predand ::  Int -> Int -> Bool -> Bool -> Bool
predand _ _ a b = a && b

allDib ::  Pred a -> Dibujo a -> Bool
allDib p a = sem p id id id predand predand (&&) a

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
esta2 ((x,y) : xs ) ys = esta2 xs (esta (x,y) ys)

junta :: Eq a => Int -> Int -> [(a,Int)] -> [(a,Int)] -> [(a,Int)]
junta _ _ a b = esta2 a b

contar :: Eq a => Dibujo a -> [(a,Int)]
contar a = sem primero id id id junta junta esta2 a

