init: 
# create local registry
	@docker network create k3d
	@k3d registry create registry.localhost --port 5000
	@docker network connect k3d k3d-registry.localhost

delete :
	# delete the cluster (if exists)
	@# this will fail harmlessly if the cluster does not exist
	@k3d cluster delete

create : delete
	@# create the cluster and wait for ready
	@# this will fail harmlessly if the cluster exists
	@# default cluster name is k3d

	@k3d cluster create --registry-use k3d-registry.localhost:5000 --config deploy/k3d.yaml --k3s-arg "--disable=traefik@server:0"

	# wait for cluster to be ready
	@kubectl wait node --for condition=ready --all --timeout=60s
	@sleep 5
	@kubectl wait pod -A --all --for condition=ready --timeout=60s

openreplay :
	# build push the local image
	docker build . -t k3d-registry.localhost:5000/openreplay:local
	docker push k3d-registry.localhost:5000/openreplay:local

