#!/usr/bin/env bash

if [[ $1 == "--kitty" ]]; then
	cd
	kitty
fi

if [[ $1 == "--spotify" ]]; then
	~/.config/polybar/scripts/poly_spoti.sh
fi

if [[ $1 == "--git" ]]; then
	vivaldi-stable -e "https://github.com/Eric-Song-Nop"
fi

if [[ $1 == "--edge" ]]; then
	microsoft-edge-beta
fi

if [[ $1 == "--files" ]]; then
    dolphin
fi

if [[ $1 == "--discord" ]]; then
	discord
fi

if [[ $1 == "--brave" ]]; then
    vivaldi-stable
fi
