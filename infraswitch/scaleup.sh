# Scale Up GKE Node
echo 'Starting Scale Up GKE Node Process ...'
gcloud container clusters get-credentials cc-project-capstone --region us-central1 --project cc-capstone-ta
gcloud container node-pools update app --cluster=cc-project-capstone --enable-autoprovisioning --zone=us-central1
gcloud container clusters resize cc-project-capstone --num-nodes=3 --zone=us-central1
echo 'Scale Up GKE Node Process, Done!'

# Scale Patch HPA to 1
echo 'Starting Patch HPA to 0 ...'
kubectl scale hpa --current-replicas=0 --replicas=1 --namespace=my-namespace
echo 'Patch HPA, Done!'

# Patch PDB to 1
echo 'Starting Patch PDB to 1 ...'
for pdb in $(kubectl get pdb -n default -o=name); do
  kubectl patch "$pdb" -n default> --type='json' -p='[{"op": "replace", "path": "/spec/minAvailable", "value": 1}]'
done
echo 'Patch PDB to 0, Done!'

# Scale Replicas to 1
echo 'Starting Scale Down Replicas to 2 ...'
for deployment in $(kubectl get deployments -n default -o=name); do
  kubectl scale "$deployment" --replicas=1 -n default
done
echo 'Scale Down Replicas, Done!'

