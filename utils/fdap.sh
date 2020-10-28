#!/bin/bash

sudo iwlist wlo1 scanning | \
rg 'Cell|Encryption|Quality|Last beacon|ESSID'

