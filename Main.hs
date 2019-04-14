module Main where
import Graphics.Gloss
import Graphics.Gloss.Interface.IO.Display
import Graphics.UI.GLUT.Begin
import Dibujo
import Interp
import qualified Basico.Ejemplo as E
import Escher
import System.Directory

data Conf a = Conf {
    basic :: Output a
  , fig  :: Dibujo a
  , width :: Float
  , height :: Float
  }

ej1 x y = Conf {
    basic = Escher.interpBas    -- Configuracion que interpreta triangulos
  , fig = Escher.ejemplo
  ,  width = x
  , height = y
  }

ej2 x y = Conf {
    basic = Escher.interpBas'   -- Configuracion que interpreta curvas
  , fig = Escher.ejemplo
  ,  width = x
  , height = y
  }

-- Dada una computación que construye una configuración, mostramos por
-- pantalla la figura de la misma de acuerdo a la interpretación para
-- las figuras básicas. Permitimos una computación para poder leer
-- archivos, tomar argumentos, etc.
initial :: IO (Conf Escher.Escher) -> IO ()
initial cf = cf >>= \cfg ->
                  let x  = width cfg
                      y  = height cfg
                  in display win white $ interp (basic cfg) (fig cfg) (-x/2,-y/2) (x,0) (0,y)

-- Configuracion que interpreta imagenes bmp
qw :: Picture -> Vector -> IO(Conf Escher.Escher)
qw img (x,y) = return $ Conf {
                     basic = Escher.interpBas2 img (x,y)
                   , fig = Escher.ejemplo
                   , width = x
                   , height = y
                   }

-- Path donde seran contenidas las imagenes bmp
pathBase = "./img/bmp/"

-- Modularizacion de main para facilitar su lectura.
-- Leer desde el main hacia arriba.
dibujaBmp :: String -> IO()
dibujaBmp str = if str=="0"
                  then return()
                  else do
                    img <- loadBMP $ pathBase ++ str
                    initial $ qw img (153, 153)

muestraArchivos = do listaDeArchivos <- listDirectory pathBase
                     mapM putStrLn listaDeArchivos
                     putStrLn "0- Salir"
                     archivo <- getLine
                     dibujaBmp archivo

dibujaLineas = do putStrLn "1- Triangulos\n2- Curvas\n0- Salir"
                  opt <- getLine
                  case opt of
                    "0" -> return()
                    "1" -> initial $ return (ej1 700 700)
                    "2" -> initial $ return (ej2 700 700)

win = InWindow "Nice Window" (700, 700) (0, 0)
main = do putStrLn "1- Lineas\n2- bmp\n0- Salir"
          str <- getLine
          case str of
            "0" -> return()
            "1" -> dibujaLineas
            "2" -> muestraArchivos
