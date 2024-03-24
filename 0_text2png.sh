#!/bin/bash

paps --cpi 7 ./sample.txt | ps2pdf - > output.pdf
convert -background white -flatten output.pdf output.png
rm output.pdf

xdg-open output.png
