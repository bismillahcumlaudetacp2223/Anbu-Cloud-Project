# Scale Down GKE Node
gcloud container clusters get-credentials cc-project-capstone --region us-central1 --project cc-capstone-ta
gcloud container clusters resize cc-project-capstone --num-nodes=0 --zone=us-central1

# Patch PDB to 0
for pdb in $(kubectl get pdb -n default -o=name); do
  kubectl patch "$pdb" -n default> --type='json' -p='[{"op": "replace", "path": "/spec/minAvailable", "value": 0}]'
done

# Scale Replicas to 0
for deployment in $(kubectl get deployments -n default -o=name); do
  kubectl scale "$deployment" --replicas=<0 -n default
done

