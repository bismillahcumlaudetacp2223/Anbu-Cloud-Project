# Scale Up GKE Node
echo 'Starting Scale Up GKE Node Process ...'
gcloud container clusters get-credentials cc-project-capstone --region us-central1 --project cc-capstone-ta
gcloud container clusters resize cc-project-capstone --num-nodes=3 --zone=us-central1
echo 'Scale Up GKE Node Process, Done!'


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

