module Main where
import Graphics.Gloss
import Graphics.Gloss.Interface.IO.Display
import Graphics.UI.GLUT.Begin
import Dibujo
import Interp
import qualified Basico.Ejemplo as E
import Escher

data Conf a = Conf {
    basic :: Output a
  , fig  :: Dibujo a
  , width :: Float
  , height :: Float
  }

ej x y = Conf {
                basic = Escher.interpBas
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
                  in display win white $ interp (basic cfg) (fig cfg) (0,0) (x,0) (0,y)

qw :: Picture -> Vector -> IO(Conf Escher.Escher)
qw img (x,y) = return $ Conf {
                     basic = Escher.interpBas2 img (x,y)
                   , fig = Escher.ejemplo
                   , width = x
                   , height = y
                   }

win = InWindow "Nice Window" (700, 700) (0, 0)
main = do img <- loadBMP "fish.bmp"
          initial $ qw img (153, 153)
