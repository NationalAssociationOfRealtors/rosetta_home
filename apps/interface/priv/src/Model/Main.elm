module Model.Main exposing (..)

import Material
import Time exposing (Time)

import Update.Light as Light
import Model.Lights as Lights
import Model.MediaPlayers as MediaPlayers
import Model.WeatherStations as WeatherStations
import Model.SmartMeters as SmartMeters
import Model.IEQ as IEQ
import Model.HVAC as HVAC

type alias Model =
  { lights : Lights.Model
  , media_players : MediaPlayers.Model
  , ieq: IEQ.Model
  , weather_stations: WeatherStations.Model
  , hvac: HVAC.Model
  , smart_meters: SmartMeters.Model
  , time: Time
  , mdl : Material.Model
  , selectedTab : Int
  , lastTab: Int
  , histograms: List String
  , hostname: String
  }

model : Model
model =
  { lights = Lights.model
  , media_players = MediaPlayers.model
  , ieq = IEQ.model
  , weather_stations = WeatherStations.model
  , hvac = HVAC.model
  , smart_meters = SmartMeters.model
  , time = 0
  , mdl = Material.model
  , selectedTab = 0
  , lastTab = 0
  , histograms = []
  , hostname = ""
  }
