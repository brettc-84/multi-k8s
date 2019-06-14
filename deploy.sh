docker build -t brettc84/multi-client:latest -t brettc84/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t brettc84/multi-server:latest -t brettc84/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t brettc84/multi-worker:latest -t brettc84/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push brettc/multi-client:latest
docker push brettc/multi-server:latest
docker push brettc/multi-worker:latest
docker push brettc/multi-client:$GIT_SHA
docker push brettc/multi-server:$GIT_SHA
docker push brettc/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=brettc84/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=brettc84/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=brettc84/multi-worker:$GIT_SHA