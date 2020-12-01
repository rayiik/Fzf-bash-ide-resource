#!/bin/bash
_log () {
	date +%Y-%m-%d
}

export _tstamp="$(_log)"
export pkglog="$HOME/tmp/pkglog.${_tstamp}"
pks() {

pkgsearch "$@" | tee -a pkglog."$(date +%Y-%m-%d)"
}


