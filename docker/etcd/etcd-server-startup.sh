#!/bin/sh
./etcd/etcd --name etcd-7-202 \
       --data-dir ./data \
       --listen-peer-urls https://192.168.56.202:2380 \
       --listen-client-urls https://192.168.56.202:2379,http://127.0.0.1:2379 \
       --quota-backend-bytes 8000000000 \
       --initial-advertise-peer-urls https://192.168.56.202:2380 \
       --advertise-client-urls https://192.168.56.202:2379,http://127.0.0.1:2379 \
       --initial-cluster  etcd-7-202=https://192.168.56.202:2380,etcd-7-203=https://192.168.56.203:2380,etcd-7-204=https://192.168.56.204:2380 \
       --ca-file ./conf/ca.pem \
       --cert-file ./conf/etcd-peer.pem \
       --key-file ./conf/etcd-peer-key.pem \
       --client-cert-auth  \
       --trusted-ca-file ./conf/ca.pem \
       --peer-ca-file ./conf/ca.pem \
       --peer-cert-file ./conf/etcd-peer.pem \
       --peer-key-file ./conf/etcd-peer-key.pem \
       --peer-client-cert-auth \
       --peer-trusted-ca-file ./conf/ca.pem \
       --log-output stdout