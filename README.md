# TiltToSurvive

<br> Do you remember the golden age of mobile games? The age in which a game could be developed and distributed without the aim to put an advertisement after each pushed button?

<br> Well, let's go back to that period and unbury one of my favorite games of all time: "Tilt to Live!"

<br> This fairly simple game is about moving an arrow across the screen and dodging red dots that spawn and chase the player.

<br> To move the player, the gyroscope is used, and thus the "Tilt" in the title. 

This repository aims at reproducing this cool mobile game, which has been lost throughout software and hardware updates, in a web app game format. The final goal is to be able to play this game for free from everywhere, also thanks to a Kubernetes cluster implementation.

#### Inspiration:

This video is an example of a small match:<br>

https://github.com/LobinArcolungo/TiltToSurvive/blob/main/img/ttl_video.mp4

## The Game Engine

As a game engine, I'm using Godot, as it's open source and fairly simple to get started with.

## The Game System

The chosen system is a mobile web browser. This is a strange choice, but I think it's the best to keep the low maintenance and broad device support that I'm looking forward to. Also, this will help me figure out how to put the game online and to work with containers.

## To play the game 

There will be a link from which you can access the game, but of course you can also download and build it from Godot and run it on your own.

