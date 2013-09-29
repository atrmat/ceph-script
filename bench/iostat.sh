#!/bin/bash

rm /tmp/iostat.log
iostat -dzmxt 1 >> /tmp/iostat.log
