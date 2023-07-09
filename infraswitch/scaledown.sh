# Scale Down GKE Node
echo 'Starting Scale Down GKE Node Process ...'
gcloud container clusters get-credentials cc-project-capstone --region us-central1 --project cc-capstone-ta
gcloud container node-pools update app --cluster=cc-project-capstone --no-enable-autoprovisioning --zone=us-central1
gcloud container clusters resize cc-project-capstone --num-nodes=0 --zone=us-central1
echo 'Scale Down GKE Node Process, Done!'

# Scale Patch HPA to 0
echo 'Starting Patch HPA to 0 ...'
kubectl scale hpa --replicas=0 --namespace=default
echo 'Patch HPA, Done!'

# Patch PDB to 0
echo 'Starting Patch PDB to 0 ...'
for pdb in $(kubectl get pdb -n default -o=name); do
  kubectl patch "$pdb" -n default> --type='json' -p='[{"op": "replace", "path": "/spec/minAvailable", "value": 0}]'
done
echo 'Patch PDB to 0, Done!'

echo 'Starting Scale Down Replicas to 0 ...'
# Scale Replicas to 0
for deployment in $(kubectl get deployments -n default -o=name); do
  kubectl scale "$deployment" --replicas=<0 -n default
done
echo 'Scale Down Replicas, Done!'
