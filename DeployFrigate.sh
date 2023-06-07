#!/bin/bash
services:
    frigate:
      container_name: frigate
      image: blakeblackshear/frigate:stable-amd64
      restart: always
      volumes:
        - /etc/localtime:/etc/localtime
        - /root/frigate:/config:rw
        - /root/frigate/clips:/media/frigate/clips:rw
        - /root/frigate/recordings:/media/frigate/recordings:rw
      ports:
        - 5000:5000
        - 1935:1935
      environment:
        FRIGATE_RTSP_PASSWORD: "super-secret"
        