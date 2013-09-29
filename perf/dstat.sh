#!/bin/bash

rm /tmp/dstat.csv
dstat -cdmnrtgsf --disk-util --output /tmp/dstat.csv
