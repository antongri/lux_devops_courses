#!/bin/bash
gcloud container clusters get-credentials demo --zone europe-west3-c --project training-276723
curl -L https://git.io/getLatestIstio | ISTIO_VERSION=1.4.2 sh -
cd istio-1.4.2
export PATH=$PWD/bin:$PATH
kubectl apply -f install/kubernetes/helm/helm-service-account.yaml
# helm init --service-account tiller --upgrade

# ### functions to catch tiller status before proceeding next ###
# progress(){
#   echo -n "$0: Please wait..."
#   while true
#   do
#     echo -n "."
#     sleep 2
#   done
# }

# tiller_status_callback () {
#   if 
#     kubectl get po --all-namespaces | grep tiller-deploy | awk '{print $4}' | grep Running; then
#     echo "success" > /dev/null 2>&1
#   fi
# }

# progress &
# MYSELF=$!
# tiller_status_callback
# kill $MYSELF >/dev/null 2>&1

# echo -n "...done."
# echo
sleep 30
helm install install/kubernetes/helm/istio-init --name istio-init --namespace istio-system
sleep 30
# kubectl get crds | grep 'istio.io' | wc -l
helm install install/kubernetes/helm/istio istio --namespace istio-system
sleep 30
cd ../../../
kubectl create secret docker-registry training-276723 --docker-server=gcr.io \
    --docker-username=_json_key \
    --docker-password="$(cat terraform.json)" \
    --docker-email=anton.v.grishko@gmail.com
kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "training-276723"}]}'
kubectl label namespace default istio-injection=enabled
rm -rf ../gcloud/demo-app/demo.local
cd ../gcloud/demo-app &&
yes | ./generate.sh demo.local demo_pwd_1
mkdir demo.local && mv 1_root 2_intermediate 3_application 4_client demo.local/
kubectl create -n istio-system secret tls istio-ingressgateway-certs \
--key demo.local/3_application/private/demo.local.key.pem --cert demo.local/3_application/certs/demo.local.cert.pem
kubectl create -n istio-system secret generic istio-ingressgateway-ca-certs \
--from-file=demo.local/2_intermediate/certs/ca-chain.cert.pem
cd microservices-demo/
kubectl apply -f istio-manifests/
kubectl apply -f kubernetes-manifests/
kubectl apply -f ./istio-manifests-advanced-cases/frontend-gateway-100-v1.yaml
sleep 30
SITE_IP=$(kubectl get svc --all-namespaces | grep Load | awk '{print $5}')
export SITE=http://$SITE_IP
# open http://$SITE_IP
