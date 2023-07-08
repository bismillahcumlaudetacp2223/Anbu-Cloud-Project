# Scale Up GKE Node
gcloud container clusters get-credentials cc-project-capstone --region us-central1 --project cc-capstone-ta
gcloud container clusters resize cc-project-capstone --num-nodes=3 --zone=us-central1

# Patch PDB to 1
for pdb in $(kubectl get pdb -n default -o=name); do
  kubectl patch "$pdb" -n default> --type='json' -p='[{"op": "replace", "path": "/spec/minAvailable", "value": 1}]'
done

# Scale Replicas to 1
for deployment in $(kubectl get deployments -n default -o=name); do
  kubectl scale "$deployment" --replicas=1 -n default
done

