#!/bin/bash
ps aux | grep test_feeding | awk '{print $2}' | xargs kill -9
