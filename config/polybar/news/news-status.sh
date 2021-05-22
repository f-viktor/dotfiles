#!/bin/bash

NEWS=$(newsboat -x print-unread | awk '{print $1}')

if [[ $NEWS == *"Error"* ]]; then
	echo ""
else
	echo $NEWS
fi
