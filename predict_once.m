function np = predict_once (projectile, transition_matrix)
   np = transition_matrix * projectile;
end