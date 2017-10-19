{-# LANGUAGE OverloadedStrings #-}

module Main where

import Network.Pusher.WebSockets
import Control.Monad.IO.Class
import Control.Monad

main :: IO ()
main = runPusher


runPusher :: IO ()
runPusher =
  -- Connect to Pusher with your key, SSL, and the us-east-1 region, and
  -- do some stuff.
  pusherWithOptions (defaultOptions key) $ do
    -- Subscribe to all the channels
    mapM_ subscribe channels

    -- Bind an event handler for all events on all channels which prints
    -- the received JSON.
    bindAll Nothing (liftIO . print)

    -- Wait for user input and then close the connection.
    liftIO (void getLine)
    disconnectBlocking
  where
    key = "de504dc5763aeef9ff52"
    channels = ["live_trades", "live_orders"]
