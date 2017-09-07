# Defined in - @ line 0
function j --description alias\ j\ cd\ \(z\ -l\ \|\ awk\ \'\{print\ \$2\}\'\ \|\ fzf\)
	cd (z -l $argv | awk '{print $2}' | fzf);
end
