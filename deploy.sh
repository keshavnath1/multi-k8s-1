docker build -t keshavnath1/multi-client:latest -t keshavnath1/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t keshavnath1/multi-server:latest -t keshavnath1/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t keshavnath1/multi-worker:latest -t keshavnath1/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push keshavnath1/multi-client:latest
docker push keshavnath1/multi-server:latest
docker push keshavnath1/multi-worker:latest

docker push keshavnath1/multi-client:$SHA
docker push keshavnath1/multi-server:$SHA
docker push keshavnath1/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=keshavnath1/multi-server:$SHA
kubectl set image deployments/client-deployment client=keshavnath1/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=keshavnath1/multi-worker:$SHA