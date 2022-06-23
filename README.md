# SPIKE
Technologies
- k3d (local kubernetes development)
- OpenReplay
- Angular (frontend application)
- ngrok (public access required for OpenReplay, HTTPS only)

## Deploy OpenReplay in local cluster

- Create local cluster with 1 node

```bash
make init
make create
```

- Build image for OpenReplay

```bash
make openreplay
```

- Apply OpenReplay deployment

```bash
kubectl apply -f deploy/openreplay.yaml
```

- Verify pod creation

```bash
kubectl get pods
```

- Copy the pod name and open a shell in the pod

```bash
kubectl exec --stdin --tty <POD_NAME> -- /bin/bash
```

## Install OpenReplay in pod

_Practice Opportunity: see if you can add the OpenReplay installation commands to the image_

```bash
apt-get install sudo
sudo apt install curl
git clone https://github.com/openreplay/openreplay.git
```

- Forward from ngrok to service NodePort on local

```bash
ngrok http 8080 // copy forwarding url i.e. https://<RANDOM_STRING>.ngrok.io
```

```bash
cd openreplay/scripts/helm && bash install.sh

// paste copied forwarding url in domain name prompt
```

## Run frontend application

```bash
ng serve --disable-host-check // flag will prevent invalid host header in ngrok
```

## Serve local application via ngrok

- Create free ngrok account
- Set authtoken

```bash
ngrok config add-authtoken <TOKEN_FROM_NGROK_ACCOUNT>
```

- Fire up ngrok

```bash
ngrok http 4200 // port is what the Angular application is being served on
```

### Docs

- https://docs.openreplay.com/troubleshooting/localhost

